//
//  LoginViewController.m
//  Art
//
//  Created by dkq on 16/4/24.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import "LoginViewController.h"
#import "RootViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

{
    NSInteger keyHeight;
    CGFloat textFlidHeight;
}

@property (nonatomic,strong) UITextField *userName;
@property (nonatomic, strong) UITextField *passWord;

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

- (IBAction)LoginClick:(id)sender;

- (IBAction)ForgetClick:(id)sender;

- (IBAction)RegisterClick:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgImage.userInteractionEnabled = YES;
}


-(void)createView{
    
    self.userName = [[UITextField alloc] initWithFrame:CGRectMake(40, 13, 170, 25)];
    self.userName.font = [UIFont systemFontOfSize:11.f];
    self.userName.textColor = RGB(255, 255, 255);
    self.userName.placeholder = @"请输入手机号";
    self.userName.borderStyle = UITextBorderStyleNone;
    self.userName.keyboardType = UIKeyboardTypeNumberPad;
    [self.bgImage addSubview:self.userName];
    
    self.passWord = [[UITextField alloc] initWithFrame:CGRectMake(40, self.userName.bottom + 20, 170, 25)];
    self.passWord.font = [UIFont systemFontOfSize:11.f];
    self.passWord.textColor = RGB(255, 255, 255);
    self.passWord.placeholder = @"请输入密码";
    self.passWord.borderStyle = UITextBorderStyleNone;
    self.passWord.secureTextEntry = YES;
    [self.bgImage addSubview:self.passWord];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[RootViewController shareSingleton] setStatusBarColor:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[RootViewController shareSingleton] setStatusBarColor:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
}

//当键盘出现或改变时调用

-(void)keyboardShow:(NSNotification *)notification{
    
    // 获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    keyHeight = keyboardRect.size.height;
    if (ScreenHeight - self.bgImage.bottom - keyHeight < 0) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [self.view setYOffset:ScreenHeight - self.bgImage.bottom - keyHeight - 30];
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
}

//当键退出时调用
-(void)keyboardHide:(NSNotification *)notification{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.view setYOffset:0];
        
    } completion:^(BOOL finished) {
        
    }];
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //将要开始编辑
    textFlidHeight = self.bgImage.bottom;
    return YES;
}

- (IBAction)LoginClick:(id)sender {
    
    
    //[self dismissViewControllerAnimated:YES completion:^{
        
 //   }];
    NSLog(@"JHGG");
    
}

- (IBAction)ForgetClick:(id)sender {
}

- (IBAction)RegisterClick:(id)sender {
    
    RegisterViewController *rvc = [[RegisterViewController alloc] init];
    rvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:rvc animated:YES completion:^{
        
    }];
    
    
    
}
@end
