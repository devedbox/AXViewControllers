//
//  AXViewController.m
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

#import "AXViewController.h"

@interface AXViewController ()

@end

@implementation AXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleLoginChanged:) name:@"loginStateChange" object:nil];
    [self viewDidLoadSetup];
    if (kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_8_0) {
        self.navigationController.navigationBar.translucent = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.tabBarController respondsToSelector:@selector(setupUnreadMessageCount)]) {
        [self.tabBarController performSelector:@selector(setupUnreadMessageCount)];
    }
}

- (BOOL)asksLoginIfNeeded {
    return YES;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

- (void)setupUnreadBadgeView {
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

#pragma mark - Private
- (void)handleLoginChanged:(NSNotification *)notification {
    /*
     if (self.navigationController.viewControllers.count > 0) {
     [self.navigationController popToRootViewControllerAnimated:NO];
     }
     */
}
@end
