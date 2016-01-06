//
//  AppButton.m
//  TabarDefined
//
//  Created by sincere on 15/12/9.
//  Copyright © 2015年 sincere. All rights reserved.
//

#import "AppButton.h"
#import "UIView+Extesion.h"


@implementation AppButton


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

/**
 *  自定义按钮图片与文字的位置
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    // 自定义应用按钮
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.width;
    CGFloat imageH = self.height * 0.8;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    // 自定义label
}
/**
 *  设置按钮圆角
 */
- (void)setCornerRadius:(CGFloat)cornerRaidus {
    self.layer.cornerRadius = cornerRaidus;
    self.layer.masksToBounds = YES;
}
/**
 *  设置按钮的变宽和颜色
 */
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color {
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}
@end