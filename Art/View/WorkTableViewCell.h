//
//  WorkTableViewCell.h
//  Art
//
//  Created by dkq on 16/4/24.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *focusButton;
@property (weak, nonatomic) IBOutlet UILabel *focusNumber;

@property (weak, nonatomic) IBOutlet UIButton *userIconButton;

@end
