//
//  RootViewController.m
//  Art
//
//  Created by dkq on 16/4/20.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import "RootViewController.h"
static RootViewController *root = nil;
@interface RootViewController ()

{
    //用来接受恢复状态的请求
    UIView *_midMask;
}

@end

@implementation RootViewController

+ (RootViewController *)shareSingleton {
    @synchronized (self) {
        if (!root) {
            root = [[self alloc] init];
        }
    }
    return root;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //状态栏隐藏
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
//    
//    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    image.image = [UIImage imageNamed:[NSString stringWithFormat:@"Defaultretein%d.png",arc4random() % 7 + 1]];
//    [self.view addSubview:image];
//    
//    [UIView animateWithDuration:2 animations:^{
//        
//        image.alpha = 0;
//        
//    } completion:^(BOOL finished) {
//        
//        //状态栏显示
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];
//        [image removeFromSuperview];
//        
//    }];
    
    //初始化点击恢复状态
    _midMask = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _midMask.backgroundColor = RGB(0, 0, 0);
    _midMask.alpha = 0.1;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(restoreView)];
    [_midMask addGestureRecognizer:gesture];
}

+(void)restoreViewFrame:(AnimationDidEnd)block{
    
    //将block传值
    // [home setValue:block forKey:@"block"];
    
    root.block = block;
    
    [root restoreViewFrame];
    
}

-(void)restoreView{
    
    [UIView animateWithDuration:0.5f animations:^{
        _midView.view.transform = CGAffineTransformMakeScale(1.f, 1.f);
        [_midView.view setXOffset:0];
    } completion:^(BOOL finished) {
        [_midMask removeFromSuperview];

    }];
}



- (void)restoreViewFrame {
    [UIView animateWithDuration:0 animations:^{
        _midView.view.transform = CGAffineTransformMakeScale(1.f, 1.f);
        [_midView.view setXOffset:0];
    } completion:^(BOOL finished) {
        [_midMask removeFromSuperview];
        
        if (_block) {
            //动画完成后调用Block
            _block(YES);
        }
    }];
}

- (void)setMidView:(UIViewController *)midView {
    if (_midView != midView) {
        _midView = midView;
    }
    [self.view insertSubview:_midView.view atIndex:0];
}

//用类方法调用单例，来实现对象方法的操作
+ (void)showLeftViewController {
    [root showLeftViewController];
}

//+ (void)showRightViewController {
//    [root showRightViewController];
//}

- (void)showLeftViewController {
    [_midView.view addSubview:_midMask];
    //将左侧视图插入主视图底部
    [self.view insertSubview:self.leftView.view belowSubview:self.midView.view];
    if (self.leftView != nil) {
        [UIView animateWithDuration:0.3 animations:^{
            [_midView.view setXOffset:PRO * 191];
            _midView.view.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
    }
}

//- (void)showRightViewController {
//    [_midView.view addSubview:_midMask];
//    //将右侧视图插入主视图底部
//    [self.view insertSubview:self.rightView.view belowSubview:self.midView.view];
//    if (self.rightView != nil) {
//        [UIView animateWithDuration:0.3 animations:^{
//            [_midView.view setXOffset:-250];
//            _midView.view.transform = CGAffineTransformMakeScale(0.9, 0.9);
//        }];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHidden;
}

- (void)setStatusBarHidden:(BOOL)statusBarHidden {
    _statusBarHidden = statusBarHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}



-(void)setStatusBarColor:(BOOL)statusBarColor{

    _statusBarColor = statusBarColor;
    [self setNeedsStatusBarAppearanceUpdate];
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    
    if (self.statusBarColor) {
        return UIStatusBarStyleLightContent;
    }
    else{
        return UIStatusBarStyleDefault;
    }
}









@end
