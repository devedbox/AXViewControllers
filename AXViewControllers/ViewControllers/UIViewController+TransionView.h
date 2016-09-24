//
//  UIViewController+TransionVIew.h
//  AXViewControllers
//
//  Created by devedbox on 2016/9/24.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXTransionBackgroundView.h"

@interface UIViewController (TransionView)
/// Transion view.
@property(readonly, strong, nonatomic) AXTransionBackgroundView *transionView;
@end
