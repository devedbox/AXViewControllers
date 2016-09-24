//
//  UIViewController+TransionVIew.m
//  AXViewControllers
//
//  Created by devedbox on 2016/9/24.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "UIViewController+TransionView.h"
#import <objc/runtime.h>

@implementation UIViewController (TransionView)
#pragma mark - Getters
- (AXTransionBackgroundView *)transionView {
    AXTransionBackgroundView *view = objc_getAssociatedObject(self, _cmd);
    if (view) return view;
    AXTransionBackgroundView *transionView = [[AXTransionBackgroundView alloc] init];
    objc_setAssociatedObject(self, _cmd, transionView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return transionView;
}
@end
