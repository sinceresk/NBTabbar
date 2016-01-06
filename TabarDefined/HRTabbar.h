//
//  HRTabbar.h
//  TabarDefined
//
//  Created by sincere on 15/12/9.
//  Copyright © 2015年 sincere. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HRTabbar;
@protocol TabBarDelegate <NSObject>
@optional

- (void)tabbarDidClickMiddleButon : (HRTabbar *)tabbar;
@end


@interface HRTabbar : UITabBar


@property (nonatomic,strong) UIButton *middleBtn;
@property(nonatomic,weak)  id<TabBarDelegate>hrdelegate;




@end
