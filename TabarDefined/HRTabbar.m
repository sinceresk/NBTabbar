//
//  HRTabbar.m
//  TabarDefined
//
//  Created by sincere on 15/12/9.
//  Copyright © 2015年 sincere. All rights reserved.
//


#import "UIView+Extesion.h"
#import "HRTabbar.h"

@implementation HRTabbar
@synthesize delegate;

-(instancetype)initWithFrame:(CGRect)frame{


    if (self  = [super initWithFrame:frame]) {
        
        UIButton * middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [middleBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_btn"] forState:UIControlStateNormal];
        middleBtn.size = middleBtn.currentBackgroundImage.size;
        [middleBtn addTarget:self action:@selector(middleClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:middleBtn];
        self.middleBtn = middleBtn;


    }


    return self;

}

- (void)middleClick {
    // 通知代理
    if ([self.hrdelegate respondsToSelector:@selector(tabbarDidClickMiddleButon:)]) {
        [self.hrdelegate tabbarDidClickMiddleButon:self];
    }
    
    
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.middleBtn.centerX = self.width*0.5;
    self.middleBtn.centerY = self.height*0.5;
    
//    设置其他tabbarBtn的位置。
    CGFloat tabBtnW = self.width/5;
    CGFloat tabBtnIndex = 0;
    NSLog(@"%ld",self.subviews.count);
    for (UIView * childView in self.subviews) {
        if ([childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            childView.width = tabBtnW;
            childView.x = tabBtnIndex * tabBtnW;
            tabBtnIndex++;
            if (tabBtnIndex == 2) {
                tabBtnIndex++;
            }
        }

    }

}




@end
