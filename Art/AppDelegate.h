//
//  AppDelegate.h
//  Art
//
//  Created by dkq on 16/4/20.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


//抽屉暴漏出来
@property (strong, nonatomic) RootViewController *root;


@end

