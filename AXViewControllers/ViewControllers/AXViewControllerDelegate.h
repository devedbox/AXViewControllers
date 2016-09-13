//
//  AXViewControllerDelegate.h
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

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MJRefresh/MJRefresh.h>
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AXViewControllerDelegate <NSObject>
@required
#pragma mark - Bar items.
/// Left bar button item.
@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftBarButtonItem;
/// Back bar button item.
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backBarButtonItem;
/// Right bar button item.
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightBarButtonItem;
#pragma mark - View load.
/// View did load set up after view finished loading.
- (void)viewDidLoadSetup;
#pragma mark - Badge.
/// Setup unread badge.
- (void)setupUnreadBadgeView;
#pragma mark - Login.
/// Asks login if need.
- (BOOL)asksLoginIfNeeded;
@optional
#pragma mark - Data refresh and load.
/// Refresh data using the system UIKit.
- (void)refresh:(UIRefreshControl *)refreshControl;
/// Refresh component enabled. Defaults is NO.
- (BOOL)refreshEnabled;
/// Load more enabled.
- (BOOL)loadMoreEnabled;
/// Load more.
- (void)loadMore;
/// Update the state of refresh component.
- (void)setNeedsRefreshUpdates;
/// Update the state of load more component.
- (void)setNeedsLoadModeUpdates;
/// Begin refresh and show refresh control.
- (void)beginRefreshing;
/// End refresh and reload table view.
- (void)endRefreshing;
/// End refeshing reload data.
- (void)endRefreshingReloadData;
/// Refresh grace tiem. Default is 0.35.
- (NSTimeInterval)refreshGraceTime;
/// Offset of refresh control.
- (CGPoint)refreshingOffsets;
#pragma mark - Transion view
/// Should add transion background view. Defaults is NO.
- (BOOL)shouldAddTransionBackgroundView;
/// Background color for transion background view. Defaults is White color.
- (UIColor *)backgroundColorForTransionView;
#pragma mark - Activity indicator.
/// Show activity indicator on the right navigation item.
- (void)showActivityView;
/// Hide activity indicator.
- (void)hideActivityView;
@end

@protocol AXViewControllerBadgeDelegate <NSObject>
/// Set up count message of unread messages.
- (void)setupUnreadMessageCount;
@end
NS_ASSUME_NONNULL_END
