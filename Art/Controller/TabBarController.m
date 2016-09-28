//
//  TabBarController.m
//  Art
//
//  Created by dkq on 16/4/20.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import "TabBarController.h"
#import "LoginViewController.h"

@interface TabBarController ()<UITabBarControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建tabBarController的子视图控制器
    self.viewControllers = [self createSubViewControllers];
    self.delegate = self;
    //标记默认选中
    self.selectedIndex = 0;
}

-(NSArray *)createSubViewControllers{
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSArray *titles = @[@"首页",@"作品",@"文章",@"照相"];
    NSArray *classes = @[@"HomePageViewController",@"WorkViewController",@"ArticleViewController",@"CameraViewController"];
    
    for (int i = 0; i < classes.count; i ++) {
        //Class 类型
        //NSClassFromString(@"aaa")将字符串aaa代表的类型取出，aaa与类型名保持一致
        Class cls = NSClassFromString([classes objectAtIndex:i]);
        UIViewController *vc = [[cls alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:[titles objectAtIndex:i] image:[self getImageWithType:NO index:i] selectedImage:[self getImageWithType:YES index:i]];
        
        nav.tabBarItem.tag = 100 + i;
        //自定义tabbarItem的字体颜色，下面第一个是默认状态下字体颜色
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(152, 152, 152)} forState:UIControlStateNormal];
        //选中状态下字体颜色
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(0 ,0, 0)} forState:UIControlStateSelected];
        [viewControllers addObject:nav];
    }
    return viewControllers;
}

//根据bool值判断是不是选中图，根据index查找对应的名字
-(UIImage *)getImageWithType:(BOOL)isSelecte index:(int) index{
    
    NSArray *imageNames = @[@"home",@"works",@"article",@"camera"];
    NSString *imageName = [NSString stringWithFormat:@"%@_default",[imageNames objectAtIndex:index]];
    
    if (isSelecte) {
        imageName = [NSString stringWithFormat:@"%@_selected",[imageNames objectAtIndex:index]];
    }
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
    
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    //让image渲染始终使用原图进行渲染
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}


-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    
    
    if (viewController.tabBarItem.tag == 103) {
        
        if (isLogin == 1) {
            isLogin = YES;
            //表示是点击个人中心按钮进入登录页面
            LoginViewController *lvc = [[LoginViewController alloc] init];
            lvc.hidesBottomBarWhenPushed = YES;
            [((UINavigationController *)tabBarController.selectedViewController) presentViewController:lvc animated:YES completion:^{
                
            }];
            
            return NO;
        }
        
    }
//
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
