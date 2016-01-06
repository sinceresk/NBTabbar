//
//  ViewController.m
//  TabarDefined
//
//  Created by sincere on 15/12/9.
//  Copyright © 2015年 sincere. All rights reserved.
//

#import "ViewController.h"
#import "AppButton.h"
#import "Masonry.h"
#import "UIView+Extesion.h"


#define bCOLS 4   // 一排按钮个数
#define bWH 67  // 宏定义按钮的宽高
// 按钮间的间距
#define bMARGIN  ([UIScreen mainScreen].bounds.size.width - bWH*bCOLS) / (bCOLS/2 + 1)

@interface ViewController ()
/**
 *  记录底部返回按钮的属性
 */
@property (nonatomic,strong) UIButton *backBtn;
/**
 *  专门存放button的视图
 */
@property (nonatomic,strong) UIView *btnView;
@property (nonatomic,strong) UIView *btn2View;
@property (nonatomic,strong) UIScrollView *btnScrollerView;
/**
 *  定时器
 */
@property (nonatomic,strong) NSTimer *timer;
/**
 *  存放按钮的数组
 */
@property (nonatomic,strong) NSMutableArray *btnArray;
/**
 *  存放按钮图片的数组
 */
@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,strong) NSArray *image2Array;
/**
 *  图片往上滑动的索引
 */
@property (nonatomic,assign) NSInteger upIndex;
/**
 *  图片向下滑回的索引
 */
@property (nonatomic,assign) NSInteger downIndex;




@end

@implementation ViewController
- (void)loadViews {
    //    [super loadView];
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:self.captureImage];
    // 创建模糊视图, blur模糊不清的
    UIView *blurView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [blurView setBackgroundColor:[UIColor colorWithWhite:0.8f alpha:0.9f]];
    [imgView addSubview:blurView];
    [view addSubview:imgView];
    self.view = view;
    
    // 应用按钮视图设置
    _btnView = [UIView new];
    _btnView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_btnView];
    [_btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-49);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(2*bWH + 3*bMARGIN);
    }];
    
    _btn2View = [UIView new];
    _btn2View.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_btn2View];
    [_btn2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-49);
        make.width.mas_equalTo(self.view.width);
        make.left.mas_equalTo(_btnView.mas_right);
        make.height.mas_equalTo(2*bWH + 3*bMARGIN);
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViews];
    [self createBtn];
    [self createBackButton];
    self.view.backgroundColor = [UIColor clearColor];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(popUpBtn) userInfo:nil repeats:YES];

    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.5f animations:^{
        self.backBtn.transform = CGAffineTransformRotate(self.backBtn.transform,M_PI);
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
   
}

#pragma mark - getter懒加载
- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
- (NSArray *)imageArray {
    if (!_imageArray) {
        // 前8个是一层   后6个是第二层
        _imageArray = @[@"tabbar_btn_popup_talk",@"tabbar_btn_popup_transferphotos",@"tabbar_btn_popup_watermarkcamera",@"tabbar_btn_popup_video",@"tabbar_btn_popup_registration",@"tabbar_btn_popup_dynamic_album",@"tabbar_btn_popup_journal",@"tabbar_btn_popup_addmore"];
    }
    return _imageArray;
}
- (NSArray *)image2Array {
    if (!_image2Array) {
        // 前8个是一层   后6个是第二层
        _image2Array = @[@"tabbar_btn_popup_continuousshooting",@"tabbar_btn_popup_videobackup",@"tabbar_btn_popup_puzzle",@"tabbar_btn_popup_2dbarcode",@"tabbar_btn_popup_videocamera",@"tabbar_btn_popup_delete",];
    }
    return _image2Array;
}
- (UIScrollView *)btnScrollerView {
    if (!_btnScrollerView) {
        _btnScrollerView = [UIScrollView new];
        _btnScrollerView.backgroundColor = [UIColor whiteColor];
        _btnScrollerView.bounces = NO;
        _btnScrollerView.showsHorizontalScrollIndicator = NO;
        _btnScrollerView.showsVerticalScrollIndicator = NO;
    }
    return _btnScrollerView;
}

#pragma mark -  控制器创建按钮方法
- (void)createBtn {
    int col = 0;
    int row = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i<self.imageArray.count; i++) {
        NSArray *titleArr = @[@"说说",@"照片",@"天气相机",@"视频",@"签到",@"动感影集",@"日记",@"更多应用"];
        // 设置每个按钮的图片与文字
        AppButton *btn = [AppButton buttonWithType:(UIButtonTypeCustom)];
        UIImage *image = [UIImage imageNamed:self.imageArray[i]];
        NSString *title = titleArr[i];
        [btn setImage:image forState:(UIControlStateNormal)];
        [btn setTitle:title forState:(UIControlStateNormal)];
        
        // 计算每个按钮的坐标与大小
        col = i % bCOLS;
        row = i / bCOLS;
        x =  col*(bMARGIN + bWH);
        y = bMARGIN + row*(bMARGIN + bWH);
        btn.frame = CGRectMake(x, y, bWH, bWH);
        btn.transform = CGAffineTransformMakeTranslation(0,self.view.height);
        btn.tag = 1000 + i;
        // 按一下就消失
        [btn addTarget:self action:@selector(touchDownBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.btnArray addObject:btn];
        //        [self.btnScrollerView addSubview:btn];
        [self.btnView addSubview:btn];
    }
}
// Center按钮点击方法
- (void)touchDownBtn:(AppButton *)btn {
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeScale(2.0, 2.0);
        btn.alpha = 0;
        // 此处写方法
        NSLog(@"按钮被点击%ld",btn.tag);
    }];
}
#pragma mark - 按钮落上, 下屏幕方法
- (void)popUpBtn {

    if (self.upIndex == 8) {
        [self.timer invalidate];
        self.upIndex = 0;
        return ;
    }
    AppButton *btn = self.btnArray[self.upIndex];
    [self setupButtonAnim:btn];
    self.upIndex++;
    
}
// 设置按钮滑动方法
- (void)setupButtonAnim:(UIButton *)btn {
    
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        btn.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.downIndex = 7 ;  // 按钮数-1;
    }];
}

// 底部取消按钮创建
- (void)createBackButton {
    UIButton *btn = [UIButton new];
    [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_btn_click"] forState:(UIControlStateNormal)];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(5);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(60);
    }];
    self.backBtn = btn;
    [btn addTarget:self action:@selector(backVC) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)popUPVC {
    if (_downIndex == -1) {
        [self.timer invalidate];
        return ;
    }
    AppButton *btn = self.btnArray[_downIndex];
    [self setDownOneBtnAnim:btn];
    _downIndex--;
}
// 从第一个开始按钮落下屏幕
- (void)setDownOneBtnAnim:(UIButton *)btn {
    [UIView animateWithDuration:0.8 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, self.view.height);
    } completion:^(BOOL finished) {
        // 如果完成, 则跳回推出的控制器
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - 手势响应事件处理方法
- (void)backVC {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(returnVC) userInfo:nil repeats:YES];
    [UIView animateWithDuration:0.2 animations:^{
        
  

        self.backBtn.transform = CGAffineTransformRotate(self.backBtn.transform, -M_PI_2*1.5);
    }];
}


-(void)returnVC {
    if (_downIndex == -1) {
        [self.timer invalidate];
        return ;
    }
    AppButton *btn = self.btnArray[_downIndex];
    [self setDownOneBtnAnim:btn];
    _downIndex--;
    
}@end
