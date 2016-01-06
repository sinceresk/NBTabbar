//
//  UIImage+Extesion.m
//  QQ空间
//
//  Created by apple-jd33 on 15/10/31.
//  Copyright © 2015年 HansRove. All rights reserved.
//


#import "UIView+Extesion.h"
#import "UIImage+Extesion.h"

@implementation UIImage (Extesion)
+ (UIImage *)imageWithCaptureView:(UIView *)view {
    CGSize size = CGSizeMake(view.width, view.height*0.9);
    
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    // 获取上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // 把控件上的图层渲染到上下文,layer只能渲染
    [view.layer renderInContext:ref];
    // 生成新tupian
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

@end

