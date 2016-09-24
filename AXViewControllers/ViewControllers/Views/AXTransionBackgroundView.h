//
//  AXTransionBackgroundView.h
//  AXViewControllers
//
//  Created by devedbox on 2016/9/24.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXTransionBackgroundView : UIView
{
    UIImageView *_separatorView;
}
/// Separator view.
@property(readonly, nonatomic) UIImageView *separatorView;
/// Separator view hidden.
@property(assign, nonatomic, getter=isSeparatorHidden) BOOL separatorHidden;
// Set separator hidden.
- (void)setSeparatorHidden:(BOOL)separatorHidden animated:(BOOL)animated;
@end
