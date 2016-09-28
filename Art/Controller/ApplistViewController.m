//
//  ApplistViewController.m
//  Art
//
//  Created by dkq on 16/4/20.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import "ApplistViewController.h"
#import "LeftViewController.h"
#import "RootViewController.h"


@interface ApplistViewController ()<LeftViewControllerDelegate>

@end

@implementation ApplistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个导航的左按钮
    [self LeftNavigationButton];
    
}

-(void)LeftNavigationButton{
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 70) / 2, 11, 70, 17)];
    [image setImage:[UIImage imageNamed:@"logo.png"]];
    self.navigationItem.titleView = image;
    UIButton *customButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [customButton addTarget:self action:@selector(barButtonItemLeft) forControlEvents:UIControlEventTouchUpInside];
    [customButton setImage:[UIImage imageNamed:@"personal1.png"] forState:UIControlStateNormal];
    UIBarButtonItem *barItem = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:customButton];
    self.navigationItem.leftBarButtonItem = barItem;
}
-(void)addTouchAction{
    //设置leftView的代理
    [LeftViewController setLeftViewDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)barButtonItemLeft{

    [RootViewController showLeftViewController];
    
    
}


#pragma mark - LeftViewControllerDelegate
-(void)toNextViewController:(LeftTableViewCellDidclicked)type{
    
  //  if (type == collectType) {
        
        //因为此时点击了我的收藏，还处于分屏状态，所以需要回复正常，然后再动画结束后进行push操作
        [RootViewController restoreViewFrame:^(BOOL isEnd) {
//            MyCollectionViewController *mvc = [[MyCollectionViewController alloc] init];
//            mvc.hidesBottomBarWhenPushed = YES;
            //[self.navigationController pushViewController:mvc animated:NO];
        }];
 //   }
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
