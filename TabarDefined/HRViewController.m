//
//  HRViewController.m
//  TabarDefined
//
//  Created by sincere on 15/12/9.
//  Copyright © 2015年 sincere. All rights reserved.
//

#import "HRViewController.h"
#import "FstViewController.h"
#import "SndViewController.h"
#import "TrdViewController.h"
#import "FrhViewController.h"
#import "UIImage+Extesion.h"
#import "ViewController.h"



@interface HRViewController ()

@end

@implementation HRViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FstViewController *authVC = [FstViewController new];
    [self setupChildViewController:authVC title:@"动态" imageName:@"tabbar_icon_auth" selectedImageName:@"tabbar_icon_auth_click"];
    SndViewController *atVC = [SndViewController new];
    [self setupChildViewController:atVC title:@"与我相关" imageName:@"tabbar_icon_at" selectedImageName:@"tabbar_icon_at_click"];
    TrdViewController *spaceVC = [TrdViewController new];
    [self setupChildViewController:spaceVC title:@"我的空间" imageName:@"tabbar_icon_space" selectedImageName:@"tabbar_icon_space_click" ];
    FrhViewController *moreVC = [FrhViewController new];
    [self setupChildViewController:moreVC title:@"玩吧" imageName:@"tabbar_icon_more" selectedImageName:@"tabbar_icon_more_click"];
    UIImage *selectedImage = [self.tabBarItem.selectedImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    self.tabBarItem.selectedImage = selectedImage;
    
    
    // 创建一个特殊的tabbar
    HRTabbar *plusBar = [HRTabbar new];
    plusBar.hrdelegate = self;
//    plusBar.delegate = self;
    [self.view addSubview:plusBar];
    // 讲center按钮放进@"tabBar" , 之前不能设置frame   forKeyPath:@"tabBar"  固定
    [self setValue:plusBar forKeyPath:@"tabBar"];

}

#pragma mark - 包装Navigation,并初始化各个控制器
- (void)setupChildViewController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    controller.title = title; // 同时设置tabbar和navigationBar的文字
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    // 被选中图片需要无渲染模式, 默认是渲染, 所以要设置RenderingMode:UIImageRenderingModeAlwaysOriginal
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    controller.tabBarItem.selectedImage = selectedImage;
    // 先给外面传进来的小控制器 包装 一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    // 添加为子控制器
    [self addChildViewController:nav];
}




- (void)tabbarDidClickMiddleButon:(HRTabbar *)tabbar{
    
    NSLog(@"tabbarDidClickMiddleButon");
    
    ViewController *centerVC = [ViewController new] ;
    centerVC.captureImage = [UIImage imageWithCaptureView:self.view];
    [self presentViewController:centerVC animated:NO completion:nil];



}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
