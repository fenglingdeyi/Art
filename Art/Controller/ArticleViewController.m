//
//  ArticleViewController.m
//  Art
//
//  Created by dkq on 16/4/20.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import "ArticleViewController.h"
#import "WorkTableViewCell.h"

@interface ArticleViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

//因为有分页，JSONModelArray不支持直接添加数据，我们就将数据放在这个可变数组中。
@property (nonatomic, strong) NSMutableArray *dataArray;
//页码
@property (nonatomic, assign) NSInteger pageNumber;

//首页数据源
@property (nonatomic,strong) NSMutableArray *dataSource;


@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



-(void)createView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
//    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    [self.view addSubview:self.tableView];
    
    //添加下拉刷新
    [self addMJRefresh];
}

-(void)addMJRefresh{
    
    WeakSelf;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNumber = 1;
        [weakSelf getNetData];
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
    }];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageNumber ++;
        [weakSelf getNetData];
        [weakSelf.tableView.footer endRefreshing];
    }];
}

-(void)getNetData{




}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WorkTableViewCell" owner:self options:nil]  lastObject];
    }
    [self createLayout:cell andIndex:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    return cell;
}


-(void)createLayout:(WorkTableViewCell *)cell andIndex:(NSIndexPath *)index{
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, cell.userIconButton.bottom + 15, ScreenWidth, ScreenWidth * 0.53)];
    image.backgroundColor = RandomColor;
    [cell.contentView addSubview:image];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 18)];
    CGPoint point = title.center;
    point.x = image.width / 2;
    point.y = image.height / 2;
    title.center = point;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:13.f];
    title.textColor = RGB(252, 250, 249);
    title.text = @"————  哈哈哈哈哈  ————";
    [image addSubview:title];
    
    UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, title.bottom + 20, ScreenWidth, 16)];
    subTitle.textAlignment = NSTextAlignmentCenter;
    subTitle.font = [UIFont systemFontOfSize:11.f];
    subTitle.textColor = RGB(252, 250, 249);
    subTitle.text = @"hahhahahg几号房间开个会尽快的返回该";
    [image addSubview:title];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 63 + ScreenWidth * 0.53 + 15;
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
    
}
@end
