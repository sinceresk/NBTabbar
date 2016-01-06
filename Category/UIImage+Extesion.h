//
//  UIImage+Extesion.h
//  QQ空间
//
//  Created by apple-jd33 on 15/10/31.
//  Copyright © 2015年 HansRove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extesion)
/**
 *  截取当前View作为一张背景图返回, capture:捕获,刻画
 */
+ (UIImage *)imageWithCaptureView:(UIView *)view;
@end
