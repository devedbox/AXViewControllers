//
//  AXNavigationController.m
//  AXViewControllers
//
//  Created by devedbox on 2016/9/13.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "AXNavigationController.h"

@interface AXNavigationController ()

@end

@implementation AXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Set up keyboard manager.
    /*
    [[[IQKeyboardManager sharedManager] disabledDistanceHandlingClasses] addObject:self.class];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Status bar
- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
}

@end
