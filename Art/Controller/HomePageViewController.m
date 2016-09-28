//
//  HomePageViewController.m
//  Art
//
//  Created by dkq on 16/4/20.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import "HomePageViewController.h"
#import "SDCycleScrollView.h"
#import "HomePageViewCell.h"
#import "PhotoViewController.h"
#import "RootViewController.h"


@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

//声明一个集合，用来设置动画
@property (nonatomic,strong) NSMutableSet *indexSet;


@property (nonatomic,strong) UITableView *tableView;

//因为有分页，JSONModelArray不支持直接添加数据，我们就将数据放在这个可变数组中。
@property (nonatomic, strong) NSMutableArray *dataArray;
//页码
@property (nonatomic, assign) NSInteger pageNumber;

//首页数据源
@property (nonatomic,strong) NSMutableArray *dataSource;
//存放轮播的数据源
@property (nonatomic,strong) NSMutableArray *dataSlider;

//存放轮播图的图片
@property (nonatomic,strong) NSMutableArray *dataImage;


@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataImage = [[NSMutableArray alloc] init];
    [self getNetData];
   // [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self createViewTableView];
    
    // Do any additional setup after loading the view.
}

-(void)getNetData{


}

-(void)createViewTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
     SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 160 * PRO) imageURLStringsGroup:nil];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.delegate = self;
    cycleScrollView.dotColor = [UIColor blackColor]; // 自定义分页控件小圆标颜色
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    self.tableView.tableHeaderView = cycleScrollView;
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
  //  return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    HomePageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"findViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomePageViewCell" owner:self options:nil]  lastObject];
    }
    [cell.image setImage:[UIImage imageNamed:@"图层-29@3x.png"]];
    cell.title.text = @"不得回家后发给对方";
    cell.Author.text = @"哈哈 • 作者:董凯强";
    cell.contentView.backgroundColor= RGB(0, 0, 0);
    cell.image.alpha = 0.5;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180 * PRO;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PhotoViewController *pvc = [[PhotoViewController alloc] init];
    pvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pvc animated:YES];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![self.indexSet containsObject:indexPath]) {
        
        [self.indexSet addObject:indexPath];
        UIView *mainView = cell.contentView;
      //  mainView.transform = CGAffineTransformMakeRotation(M_PI_2 / 3);
       // mainView.transform = CGAffineTransformTranslate(mainView.transform, 180, 0);
        mainView.alpha = 0;
        [UIView animateWithDuration:2 animations:^{
            mainView.transform = CGAffineTransformIdentity;
            mainView.alpha = 1;
        }];
        
    }
}

#pragma mark - SDCycleScrollViewDelegate


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    
//        return UIStatusBarStyleLightContent;
//    
//}





@end
