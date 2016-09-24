//
//  AXTableViewController.m
//  AXViewControllers
//
//  Created by devedbox on 2016/9/13.
//  Copyright © 2016年 devedbox. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "AXTableViewController.h"

@interface AXTableViewController ()
{
    MJRefreshAutoStateFooter *_footer;
    BOOL _footerLimitedByContentSize;
    NSDate *_lastRefreshDate;
}
@end

@implementation AXTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoginChanged:) name:kAXLoginStateChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadBadgeView) name:kAXDidReceivePayloadNotification object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self viewDidLoadSetup];
}

- (void)viewDidLoadSetup {
    if (self.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;
    }
    if (self.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = self.leftBarButtonItem;
    }
    if (self.backBarButtonItem) {
        self.navigationItem.backBarButtonItem = self.backBarButtonItem;
    }
    /*
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0.996 green:0.149 blue:0.255 alpha:1.00],NSForegroundColorAttributeName, [UIFont systemFontOfSize:14],NSFontAttributeName , nil] forState:0];
     */
    [self setNeedsRefreshUpdates];
    [self setNeedsLoadModeUpdates];
    
    if ([self shouldAddTransionBackgroundView]) {
        self.transionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.navigationController.navigationBar.frame), CGRectGetMaxY(self.navigationController.navigationBar.frame));
        self.transionView.backgroundColor = [self backgroundColorForTransionView];
        [self.view addSubview:self.transionView];
    } else {
        [self.transionView removeFromSuperview];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.tabBarController respondsToSelector:@selector(setupUnreadMessageCount)]) {
        [self.tabBarController performSelector:@selector(setupUnreadMessageCount)];
    }
    
    [self setupUnreadBadgeView];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    // Set status bar to light content.
    if ([self.navigationController respondsToSelector:@selector(setStatusBarStyle:)]) {
        [self.navigationController setValue:@(UIStatusBarStyleDefault) forKeyPath:@"statusBarStyle"];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (BOOL)asksLoginIfNeeded {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize size = [change[NSKeyValueChangeNewKey] CGSizeValue];
        if (size.height < self.tableView.bounds.size.height) {
            [self.tableView setMj_footer:nil];
            _footerLimitedByContentSize = YES;
        } else {
            if (_footerLimitedByContentSize) {
                [self setNeedsLoadModeUpdates];
                _footerLimitedByContentSize = NO;
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - Getters
- (UIBarButtonItem *)backBarButtonItem {
    if (_backBarButtonItem) return _backBarButtonItem;
    _backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                          style:UIBarButtonItemStylePlain
                                                         target:nil
                                                         action:nil];
    return _backBarButtonItem;
}

- (UIActivityIndicatorView *)activityIndicator {
    if (_activityIndicator) return _activityIndicator;
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.hidesWhenStopped = YES;
    return _activityIndicator;
}

- (BOOL)refreshEnabled {
    return NO;
}

- (BOOL)loadMoreEnabled {
    return NO;
}

- (MJRefreshAutoStateFooter *)refreshFooter {
    return _footer;
}

#pragma mark - Actions
- (void)beginRefreshing {
    if (!_lastRefreshDate) {
        _lastRefreshDate = [NSDate date];
    }
    if (self.refreshControl.isRefreshing && [[NSDate date] timeIntervalSinceDate:_lastRefreshDate] < 2.5) {
        return;
    }
    if ([self refreshEnabled]) {
        [UIView animateWithDuration:0.25 delay:.1 options:7 animations:^{
            [self.tableView setContentOffset:[self refreshingOffsets]];
        } completion:NULL];
        [self.refreshControl beginRefreshing];
        [self.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
        _lastRefreshDate = [NSDate date];
    }
}

- (CGPoint)refreshingOffsets {
    return CGPointMake(0, -CGRectGetHeight(self.refreshControl.frame));
}

- (void)endRefreshing {
    [self.refreshControl endRefreshing];
    [self performSelector:@selector(endRefreshingReloadData) withObject:nil afterDelay:[self refreshGraceTime]];
}

- (NSTimeInterval)refreshGraceTime {
    return 0.35;
}

- (void)endRefreshingReloadData {
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}

- (void)loadMore {
}

- (void)setNeedsRefreshUpdates {
    if ([self refreshEnabled]) {
        if (!self.refreshControl) {
            //初始化UIRefreshControl
            self.refreshControl = [[UIRefreshControl alloc] init];
            [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
        }
    } else {
        [self setRefreshControl:nil];
    }
}

- (void)setNeedsLoadModeUpdates {
    if ([self loadMoreEnabled]) {
        // 初始化footer
        if (!_footer) {
            _footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
            _footer.stateLabel.font = [UIFont systemFontOfSize:12];
            _footer.stateLabel.textColor = [UIColor lightGrayColor];
        }
        [self.tableView setMj_footer:_footer];
        
    } else {
        [self.tableView setMj_footer:nil];
    }
}

- (void)showActivityView {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    [self.navigationItem setRightBarButtonItem:item animated:YES];
    [_activityIndicator startAnimating];
}

- (void)hideActivityView {
    [_activityIndicator stopAnimating];
    [self.navigationItem setRightBarButtonItem:self.rightBarButtonItem animated:YES];
}

- (void)setupUnreadBadgeView {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return .001;
    }
    return 15.0f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.transionView.transform = CGAffineTransformMakeTranslation(0, scrollView.contentOffset.y);
}

#pragma mark - Transion view
- (BOOL)shouldAddTransionBackgroundView {
    return NO;
}

- (UIColor *)backgroundColorForTransionView {
    return [UIColor whiteColor];
}

#pragma mark - Private
- (void)handleLoginChanged:(NSNotification *)notification {
    /*
     if (self.navigationController.viewControllers.count > 0) {
     [self.navigationController popToRootViewControllerAnimated:NO];
     }
     */
}

- (void)handleApplicationDidBecomeActive:(NSNotification *)notification {
    if (self.refreshControl.isRefreshing) {
        [self endRefreshing];
    }
}
@end
