//
//  LeftViewController.h
//  Art
//
//  Created by dkq on 16/4/20.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftViewControllerDelegate <NSObject>

typedef enum{
    
    WorkType = 79,
    UserType,
    MyFollowType,
    InvitationType,
    SettingType
    
}LeftTableViewCellDidclicked;


//点击左侧内容，进入到下一个视图控制器
-(void)toNextViewController:(LeftTableViewCellDidclicked)type;

@end


@interface LeftViewController : BaseViewController

@property (nonatomic,assign) id <LeftViewControllerDelegate> delegate;

+(LeftViewController *)shareSingleton;

+(void)setLeftViewDelegate:(id)delegate;

@end