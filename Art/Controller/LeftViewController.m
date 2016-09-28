//
//  LeftViewController.m
//  Art
//
//  Created by dkq on 16/4/20.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import "LeftViewController.h"


static LeftViewController *left = nil;
@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>

//每一个子功能的名字
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UITableView *tableView;
//头像
@property (nonatomic, strong) UIImageView *image;
//昵称
@property (nonatomic, strong) UILabel *name;

@end

@implementation LeftViewController

+(LeftViewController *)shareSingleton{
    
    @synchronized(self){
        
        if (!left) {
            left = [[self alloc] init];
        }
    }
    return left;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initData {
    self.titles = @[@"我的工作室", @"个人信息", @"我的关注", @"邀请好友", @"设置"];
}

- (void)createView {
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake((191 * PRO - 55) / 2, 114 * PRO - 64, 55, 55)];
    self.image.layer.cornerRadius = 55 / 2;
    self.image.layer.masksToBounds = YES;
    self.image.backgroundColor = RGB(34, 34, 35);
    [self.view addSubview:self.image];
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(10, self.image.bottom + 5, 191 * PRO - 20, 21)];
    self.name.textAlignment = NSTextAlignmentCenter;
    self.name.textColor = RGB(0, 0, 0);
    self.name.font = [UIFont systemFontOfSize:11.f];
    self.name.text = @"哈哈哈哈哈";
    [self.view addSubview:self.name];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(16, self.name.bottom + 5, 191 * PRO, 200) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.scrollEnabled = NO;
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //隐藏tableView底部的线
  //  [self hideTableViewBottomLine];
}

//设置左侧视图的代理
+(void)setLeftViewDelegate:(id)delegate{
    
    left.delegate = delegate;
    
}

//- (void)hideTableViewBottomLine {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, self.tableView.height)];
//    view.backgroundColor = [UIColor clearColor];
//    self.tableView.tableFooterView = view;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12.f];
        NSArray *imageName = @[@"studio", @"personal", @"focus", @"invitation", @"Settings"];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageName objectAtIndex:indexPath.row]]];
   // cell.backgroundColor = [UIColor clearColor];
  //  cell.backgroundView = nil;
   // cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
        return 40.f;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(toNextViewController:)]) {
        
        [self.delegate toNextViewController:79 + (int)indexPath.row];
        
    }
}



@end
