//
//  AXTransionBackgroundView.m
//  AXViewControllers
//
//  Created by devedbox on 2016/9/24.
//  Copyright © 2016年 devedbox. All rights reserved.
//

#import "AXTransionBackgroundView.h"
#import <pop/POP.h>

@implementation AXTransionBackgroundView
#pragma mark - Initializer
- (instancetype)init {
    if (self = [super init]) {
        [self initializer];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initializer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initializer];
}

- (void)initializer {
    [self addSubview:self.separatorView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _separatorView.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), 0.5);
}

- (UIImageView *)separatorView {
    if (_separatorView) return _separatorView;
    _separatorView = [UIImageView new];
    _separatorView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    _separatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    return _separatorView;
}

- (void)setSeparatorHidden:(BOOL)separatorHidden {
    [self setSeparatorHidden:separatorHidden animated:NO];
}

- (void)setSeparatorHidden:(BOOL)separatorHidden animated:(BOOL)animated {
    _separatorHidden = separatorHidden;
    NSTimeInterval duration = animated?0.25:0.0;
    POPBasicAnimation *alpha = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    alpha.completionBlock = ^(POPAnimation *ani, BOOL finished) {
        if (finished) {
            _separatorView.hidden = _separatorHidden;
        }
    };
    alpha.duration = duration;
    [_separatorView pop_removeAnimationForKey:@"alpha"];
    [_separatorView pop_addAnimation:alpha forKey:@"alpha"];
}
@end
