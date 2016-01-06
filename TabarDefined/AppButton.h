//
//  AppButton.h
//  TabarDefined
//
//  Created by sincere on 15/12/9.
//  Copyright © 2015年 sincere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppButton : UIButton
/**
*  设置按钮的圆角半径
*/
- (void)setCornerRadius:(CGFloat)cornerRaidus;

/**
 *  设置按钮的变宽度和颜色
 */
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color;
@end


