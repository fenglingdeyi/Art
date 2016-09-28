//
//  WorkViewController.m
//  Art

//  Created by dkq on 16/4/20.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import "WorkViewController.h"
#import "WorkTableViewCell.h"

@interface WorkViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

//因为有分页，JSONModelArray不支持直接添加数据，我们就将数据放在这个可变数组中。
@property (nonatomic, strong) NSMutableArray *dataArray;
//页码
@property (nonatomic, assign) NSInteger pageNumber;

//首页数据源
@property (nonatomic,strong) NSMutableArray *dataSource;
//存放轮播的数据源
@property (nonatomic,strong) NSMutableArray *dataSlider;


//用来记录图片的个数
@property (nonatomic,strong) NSMutableArray *imageArray;



@end

@implementation WorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.imageArray = [[NSMutableArray alloc] init];
}


-(void)createView{
    
//    self.imageArray = @[@"1",@"2",@"3",@"4"];
//    self.imageArray = @[@"1",@"2"];
    self.imageArray = [[NSMutableArray alloc] init];
   
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WorkTableViewCell" owner:self options:nil]  lastObject];
    }
    [self createLayout:cell andIndex:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)createLayout:(WorkTableViewCell *)cell andIndex:(NSIndexPath *)index{
    [self.imageArray removeAllObjects];
    int ret = 0;
    ret = arc4random() % 10 + 1;
    
    for (int i = 0; i < ret; i ++) {
        
        [self.imageArray addObject:@"1"];
    }
    
    NSLog(@"~~~~~~~~~~~~~~~~%ld",self.imageArray.count);
    
    UILabel *content = [[UILabel alloc] init];
    NSString *str = @"HelveticaNeueffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
    UIFont *fnt = [UIFont fontWithName:str size:13.f];
    content.font = fnt;
    content.text = str;
    content.lineBreakMode = NSLineBreakByCharWrapping;//实现文字多行显示
    content.numberOfLines = 0;
    // CGSize size = CGSizeMake(name.width, MAXFLOAT);
    CGSize size = [content sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
    CGFloat contentH = size.height;
    content.frame = CGRectMake(10, cell.userIconButton.bottom + 15, ScreenWidth - 20, contentH);
    [cell.contentView addSubview:content];
    if (self.imageArray.count == 1) {
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, content.bottom + 13, ScreenWidth - 20, (ScreenWidth - 20) * 0.75)];
        image.backgroundColor = RandomColor;
        image.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:image];
    }
    
    else if (self.imageArray.count == 2){
        
        for (int i = 0; i < self.imageArray.count; i ++) {
            
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10 + i * (10 + (ScreenWidth - 30) / 2), content.bottom + 13, (ScreenWidth - 30) / 2 , (ScreenWidth - 30) / 2 * 0.86)];
            image.backgroundColor = RandomColor;
            image.contentMode = UIViewContentModeScaleAspectFit;
            [cell.contentView addSubview:image];
        }

    }
    else{
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, content.bottom + 13, ScreenWidth, (ScreenWidth - 37) / 3)];
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize =CGSizeMake((ScreenWidth - 37) / 3.0 * self.imageArray.count + 20 + 9 * (self.imageArray.count - 1), (ScreenWidth - 37) / 3.0);
        scrollView.contentOffset = CGPointMake(0, 0);
        for (int i = 0; i < self.imageArray.count; i ++) {
            
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10 + i * (9 + (ScreenWidth - 37) / 3.0), 0, (ScreenWidth - 37) / 3.0, (ScreenWidth - 37) / 3.0)];
            image.contentMode = UIViewContentModeScaleAspectFit;
            image.backgroundColor = RandomColor;
            [scrollView addSubview:image];
        }
        
        
        [cell.contentView addSubview:scrollView];
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UILabel *content = [[UILabel alloc] init];
    NSString *str = @"HelveticaNeueffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
    UIFont *fnt = [UIFont fontWithName:str size:13.f];
    content.font = fnt;
    content.text = str;
    content.lineBreakMode = NSLineBreakByCharWrapping;//实现文字多行显示
    content.numberOfLines = 0;
    // CGSize size = CGSizeMake(name.width, MAXFLOAT);
    CGSize size = [content sizeThatFits:CGSizeMake(ScreenWidth - 20, MAXFLOAT)];
    CGFloat contentH = size.height;
    if (self.imageArray.count == 1) {
        
        return 63 + contentH + 38 + (ScreenWidth - 20) * 0.75;
        
    }
    
    else if (self.imageArray.count == 2){
    
        return 100 + contentH + (ScreenWidth - 30) / 2 * 0.86;
    }
    else{
    
        return 100 + contentH + (ScreenWidth - 37) / 3;
    
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
    
}
@end
