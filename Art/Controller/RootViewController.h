//
//  RootViewController.h
//  Art
//
//  Created by dkq on 16/4/20.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AnimationDidEnd)(BOOL isEnd);
@interface RootViewController : UIViewController

@property (nonatomic,strong) AnimationDidEnd block;

//中间视图的控制器
@property (nonatomic, strong) UIViewController *midView;
//左侧视图的控制器
@property (nonatomic, strong) UIViewController *leftView;

//是否隐藏状态栏
@property (nonatomic,assign) BOOL statusBarHidden;


//是否修改状态栏的颜色
@property (nonatomic, assign) BOOL statusBarColor;


//将这个类型改成单例
+ (RootViewController *)shareSingleton;
//显示左侧的视图控制器
+ (void)showLeftViewController;

//使用类方法调用恢复状态
+(void) restoreViewFrame:(AnimationDidEnd)block;


@end
