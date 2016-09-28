//
//  PhotoViewController.m
//  Art
//
//  Created by dkq on 16/4/21.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import "PhotoViewController.h"
#import "RootViewController.h"

@interface PhotoViewController ()<UIScrollViewDelegate>

{

    BOOL isPop;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *imagesArray;


@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *buttomView;

//用户头像
@property (nonatomic, strong) UIButton *userIcon;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIButton *LikeButton;
@property (nonatomic, strong) UILabel *LikeLabel;
@property (nonatomic, strong) UIButton *DiscussButton;
@property (nonatomic, strong) UILabel *DiscussLabel;

//分享按钮
@property (nonatomic, strong) UIButton *shareButton;
//返回按钮
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, strong) UITextView *textView;

//用来显示第几张图片
@property (nonatomic, strong) UILabel *page;


@end

@implementation PhotoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    isPop = YES;
    [self setScrollView];
    [self createPopView];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    //[self setPageControl];
}

//设置弹框
-(void)createPopView{
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 102)];
    self.topView.backgroundColor = [UIColor blackColor];
    self.topView.userInteractionEnabled = YES;
    [self.view addSubview:self.topView];
    self.buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 136, ScreenWidth, 136)];
    self.buttomView.backgroundColor = [UIColor blackColor];
    self.buttomView.userInteractionEnabled = YES;
    [self.view addSubview:self.buttomView];
    
    self.page = [[UILabel alloc] initWithFrame:CGRectMake(10, ScreenHeight - 167, 60, 21)];
    self.page.backgroundColor = [UIColor blackColor];
    self.page.font = [UIFont systemFontOfSize:15.f];
    self.page.textColor = [UIColor whiteColor];
    self.page.layer.cornerRadius = 10;
    self.page.layer.masksToBounds = YES;
    [self.view addSubview:self.page];
    [self createTopView];
    [self createbuttomView];
}

-(void) createTopView{
    
    self.backButton = [Factory createButtonWithTitle:nil frame:CGRectMake(0, 13, 30, 30) target:self selector:@selector(backPopView)];
    self.backButton.backgroundColor = [UIColor clearColor];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [self.topView addSubview:self.backButton];
    self.userIcon = [Factory createButtonWithTitle:nil frame:CGRectMake(self.backButton.right + 10, self.backButton.top, 35, 35) target:self selector:@selector(IconClick)];
    self.userIcon.layer.cornerRadius = 35 / 2;
    self.userIcon.layer.masksToBounds = YES;
    self.userIcon.backgroundColor = [UIColor clearColor];
    //[self.userIcon sd_setImageWithURL:<#(NSURL *)#> forState:<#(UIControlState)#>];
    [self.topView addSubview:self.userIcon];
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(self.userIcon.right + 10, 13, 100, 18)];
    self.userName.font = [UIFont systemFontOfSize:14];
    self.userName.textColor = [UIColor whiteColor];
    [self.topView addSubview:self.userName];
    self.time = [[UILabel alloc] initWithFrame:CGRectMake(self.userIcon.right + 10, 13, 150, 18)];
    self.time.font = [UIFont systemFontOfSize:12.f];
    self.time.textColor = [UIColor whiteColor];
    [self.topView addSubview:self.time];
    self.shareButton = [Factory createButtonWithTitle:nil frame:CGRectMake(ScreenWidth - 40, 13, 30, 30) target:self selector:@selector(shareClick)];
    self.shareButton.backgroundColor = [UIColor clearColor];
    [self.shareButton setBackgroundImage:[UIImage imageNamed:@"works_details_share"] forState:UIControlStateNormal];
    [self.topView addSubview:self.shareButton];
    
    self.LikeButton = [Factory createButtonWithTitle:nil frame:CGRectMake(17, self.backButton.bottom + 15, 30, 30) target:self selector:@selector(LickClick)];
    [self.LikeButton setBackgroundImage:[UIImage imageNamed:@"works_details_focus_default"] forState:UIControlStateNormal];
    [self.LikeButton setBackgroundImage:[UIImage imageNamed:@"works_details_focus_selected"] forState:UIControlStateSelected];
    self.LikeButton.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:self.LikeButton];
    
    self.LikeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.LikeButton.right + 3, self.LikeButton.top + 5, 60, 21)];
    self.LikeLabel.font = [UIFont systemFontOfSize:12.f];
    self.LikeLabel.textColor = [UIColor whiteColor];
    [self.topView addSubview:self.LikeLabel];
    
    self.DiscussButton = [Factory createButtonWithTitle:nil frame:CGRectMake(self.LikeLabel.right + 33, self.LikeButton.top, 30, 30) target:self selector:@selector(DiscussClick)];
    [self.DiscussButton setBackgroundImage:[UIImage imageNamed:@"works_details_comments"] forState:UIControlStateNormal];
    self.DiscussButton.backgroundColor = [UIColor clearColor];
    [self.topView addSubview:self.DiscussButton];
    
    self.DiscussLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.DiscussButton.right + 3, self.DiscussButton.top + 5, 60, 21)];
    self.DiscussLabel.font = [UIFont systemFontOfSize:12.f];
    self.DiscussLabel.textColor = [UIColor whiteColor];
    [self.topView addSubview:self.DiscussLabel];
}

-(void)createbuttomView{
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(17, 10, ScreenWidth - 34, 106)];
    self.textView.text = @"很疯狂的很少看见后你会发现非客户的身份我；参加；玩家官方；那个；给你人工；恩情；国庆节；我不管了健康那都给你发多少分界面；； 本人更费劲儿；给你看几点上；老姑家；感觉啊；就；抗热就给了肯德基很疯狂的很少看见后你会发现非客户的身份我；参加；玩家官方；那个；给你人工；恩情；国庆节；我不管了健康那都给你发多少分界面；； 本人更费劲儿；给你看几点上；老姑家；感觉啊；就；抗热就给了肯德基很疯狂的很少看见后你会发现非客户的身份我；参加；玩家官方；那个；给你人工；恩情；国庆节；我不管了健康那都给你发多少分界面；； 本人更费劲儿；给你看几点上；老姑家；感觉啊；就；抗热就给了肯德基";
    self.textView.editable = NO;
    self.textView.backgroundColor = [UIColor blackColor];
    self.textView.textColor = RGB(255, 255, 255);
    self.textView.font = [UIFont systemFontOfSize:13.f];
    [self.buttomView addSubview:self.textView];
    
}

//手势监听
- (void)tapImage:(UITapGestureRecognizer *)tap{

    NSLog(@"!!!!!!!!!!!!!!!!!!!!!");
    
    if (isPop) {
        
        [UIView animateWithDuration:0.5f animations:^{
           
            [self.topView setYOffset:-102];
            [self.buttomView setYOffset:ScreenHeight];
            //状态栏隐藏
            //[[UIApplication sharedApplication] setStatusBarHidden:YES];
            NSLog(@"hahha");
            //[RootViewController shareSingleton].statusBarHidden = YES;
            
        }];
        isPop = NO;
    }
    else{
        [UIView animateWithDuration:0.5f animations:^{
            
            [self.topView setYOffset:0];
            [self.buttomView setYOffset:ScreenHeight - 136];
            //状态栏显示
            //[[UIApplication sharedApplication] setStatusBarHidden:NO];
             //[RootViewController shareSingleton].statusBarHidden = NO;
        }];
        isPop = YES;
    }
}

//评论按钮
-(void)DiscussClick{

    


}


//点赞按钮
-(void)LickClick{





}




//点击分享
-(void)shareClick{

    


}


//点击返回按钮
-(void)backPopView{

    [self.navigationController popViewControllerAnimated:YES];
}


//点击头像
-(void)IconClick{

    


}




//设置滚动视图
- (void)setScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
   // self.scrollView.backgroundColor = RGB(0, 0, 0);
    self.scrollView.delegate = self;//设置代理
    NSMutableArray *imageArray = [NSMutableArray array];
    //[self setImageArray:imageArray];
    self.imagesArray = [NSMutableArray arrayWithArray: [self setImageArray:imageArray]];
    //[self.imagesArray insertObject:imageArray.lastObject atIndex:0];
    for (int i = 0; i < self.imagesArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(ScreenWidth * i, 0, ScreenWidth, ScreenHeight))];
        imageView.contentMode = UIViewContentModeScaleAspectFit;

        imageView.image = [self.imagesArray objectAtIndex:i];
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = RGB(0, 0, 0);
        [self.scrollView addSubview:imageView];
        
    }
    self.scrollView.contentSize = CGSizeMake(ScreenWidth * self.imagesArray.count, 0);//设置内容大小
    self.scrollView.contentOffset = CGPointMake(0, 0);//设置内容偏移量
//    self.scrollView.delaysContentTouches = YES;
//    self.scrollView.canCancelContentTouches=NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
  // self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
}

- (NSMutableArray *)setImageArray:(NSMutableArray *)imageArray {
    for (int i = 1; i < 10; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"图层-29@3x.png"]];
        [imageArray addObject:image];
    }
    return imageArray;
}

// 滚动动画结束的时候更改pageControl
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    CGFloat x = scrollView.contentOffset.x;//获取当前的偏移量
//    NSInteger page = x / ScreenWidth + 1;//对应的pageControl值
//
//    NSLog(@"~~~~~~~~~~~~~~%ld",page);
//    
//}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
        CGFloat x = scrollView.contentOffset.x;//获取当前的偏移量
        NSInteger page = x / ScreenWidth + 1;//对应的pageControl值
    self.page.text = [NSString stringWithFormat:@"%ld/%ld",page,self.imagesArray.count];
    NSLog(@"~~~~~~~~~~~~~~~~~%ld",page);
    
   
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
