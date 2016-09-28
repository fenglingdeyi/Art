//
//  THEditPhotoView.m
//  WangQiuJia-1-2015
//
//  Created by 王鑫 on 16/3/7.
//  Copyright © 2016年 网球家. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ViewFrameExt.h"
@interface THRemoveButton :UIButton
@property(weak,nonatomic) UIButton *removeBtn;

@end

@implementation THRemoveButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *removeBtn = [[UIButton alloc]init];
        [removeBtn addTarget:self action:@selector(removeImageIcon:) forControlEvents:UIControlEventTouchUpInside];
        [removeBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [self addSubview:removeBtn];
        self.removeBtn = removeBtn;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat removeW = 34;
    CGFloat removeH = removeW;
    CGFloat removeX = self.width - 17;
    CGFloat removeY = - 17;
    self.removeBtn.frame = CGRectMake(removeX, removeY, removeW, removeH);
}
-(void)removeImageIcon:(UIButton *)button{
//    NSLog(@"--removeImageIcon--");
    UIButton *willDisBtn = (UIButton *)button.superview;
//    [button.superview removeFromSuperview];
    //当某张图片删除时候，我们发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kDeleteAPicFromView" object:nil userInfo:@{@"obj":willDisBtn}];
}
@end

#import "THEditPhotoView.h"

static NSInteger const kMaxColumn = 3;           //最大列数
static NSInteger const kMargin         = 15;         //图片之间-间距
#define CWScreenW [UIScreen mainScreen].bounds.size.width
#define kImageViewWidth (CWScreenW - (4*kMargin))/3.0 //图片的宽度

static THEditPhotoView *tvc = nil;

@interface THEditPhotoView ()


/**  提示文字 */
@property(weak,nonatomic) UILabel *noticeLab;

/**  加号按钮 */
@property(strong,nonatomic) UIButton *addBtn;

/**  用于存放照片的控制器 */
@property(nonatomic,strong)NSMutableArray *photoes;
@end
@implementation THEditPhotoView
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc]init];
        [_addBtn addTarget:self action:@selector(addImages:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(NSMutableArray *)photoes{
    if (!_photoes) {
        _photoes = [[NSMutableArray alloc]init];
    }
    return _photoes;
}
#pragma mark - 初始化
+ (id)editPhotoView{
    
    @synchronized(self){
        
        if (!tvc) {
            tvc = [[self alloc] init];
        }
    }
    return tvc;
   
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubviews];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self createSubviews];
    }
    return self;
}
/**  创建子view */
-(void)createSubviews{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetPostNofificationForDeletePic:) name:@"kDeleteAPicFromView" object:nil];
    //添加一个提示按钮
    UILabel *noticeLab = [[UILabel alloc]init];
//    noticeLab.textColor = [UIColor redColor];
    [self addSubview:noticeLab];
    noticeLab.text = @"作品图片(0/9)";
    noticeLab.font = [UIFont systemFontOfSize:15];
    self.noticeLab = noticeLab;
    
    
    self.backgroundColor = [UIColor whiteColor];
    /**  添加加号图片 */
    [self.photoes addObject:[UIImage imageNamed:@"edit"]];
    //添加button
    for (int i = 0; i<self.photoes.count; i++) {
        UIButton *button = nil;
        if (self.photoes.count == i+1) {
            //最后一个用来添加图片
            button = self.addBtn;
        }
        else{
            //在button上添加一个删除按钮
            button = [[THRemoveButton alloc]init];
        }
//        button.tag  = i+1;
        button.contentMode = UIViewContentModeCenter;
        [button setImage:self.photoes[i] forState:UIControlStateNormal];
        [self addSubview:button];
    }
}
#pragma mark - 删除图片的通知处理事件和移除通知监听
-(void)GetPostNofificationForDeletePic:(NSNotification *)noti{
    UIButton *button = noti.userInfo[@"obj"];
    //获取tag,然后删除数组中的元素,开始的tag = 46（不能算lable）
   NSInteger concreteNo =  (button.tag - 46)+1;
   //先从照片中remove ,然后是数组
    [self.photoes removeObjectAtIndex:(concreteNo-1)];
    [button removeFromSuperview];
    //删除照片的时候，我们判断的数量，添加“+”
    BOOL isShow = [self.subviews containsObject:self.addBtn];
    if (self.photoes.count == 8 && !isShow) {
        [self.photoes addObject:[UIImage imageNamed:@"edit"]];
        [self addSubview:self.addBtn];
    }
    
    [self updateNoticeText];
    [self setNeedsLayout];
}
-(void)dealloc{
    [[NSNotificationCenter debugDescription] removeObserver:self forKeyPath:@"kDeleteAPicFromView"];
}
#pragma mark - 添加图片
-(void)addImages:(UIButton *)button
{
//    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"想选择图片来源" message:@"选择一个图片source" preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *imageAlume = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //打开相册
//        [self openAlume];
//    }];
//    [alertVc addAction:imageAlume];
//    
//    UIAlertAction *takePhoes = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //打开相册
//        [self openAlume];
//    }];
//    [alertVc addAction:takePhoes];
    [self makeSureDelegateFun];
}
-(void)makeSureDelegateFun{
    if ([self.delegate respondsToSelector:@selector(editPhotoViewToOpenAblum:)]) {
        [self.delegate editPhotoViewToOpenAblum:self];
    }
}

//布局
-(void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat labX = 15;
    CGFloat labY = 5;
    CGFloat labW = 250;
    CGFloat labH = 15;
    self.noticeLab.frame = CGRectMake(labX, labY, labW, labH);
    
    //设置button的frame
    CGFloat buttonW = kImageViewWidth;
    CGFloat buttonH = buttonW;
    for (int i = 1; i < self.subviews.count; ++ i) {
        UIButton *sub = self.subviews[i];
        sub.tag = 45 + i;//从46开始
        if ([sub isKindOfClass:[UIButton class]]) {
            CGFloat currentRow = (i-1)/kMaxColumn;
            NSInteger currentCol = (i-1)%kMaxColumn;
            CGFloat buttonX = currentCol * (buttonW + kMargin) + kMargin;
            CGFloat buttonY = currentRow *(buttonW + kMargin) + kMargin + labH + labY;//第一个icon的y值离noticLab 的高度是kMargin
            sub.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        }
        sub.contentMode = UIViewContentModeCenter;
        [sub setImage:self.photoes[i-1] forState:UIControlStateNormal];
    }
    //判断自己的view的高度
    NSInteger currentRow = (self.photoes.count - 1)/3 + 1;//至少有一行
    [self setHeight:currentRow *(buttonW + kMargin) + kMargin + labH + labY];
    
    
    
   // NSLog(@"##########################%lf",self.height);
     // currentHeight = self.height;
}


-(void)addOneImage:(UIImage *)image{
    [self.photoes insertObject:image atIndex:(self.photoes.count - 1)];
    //在button上添加一个删除按钮
   THRemoveButton *button = [[THRemoveButton alloc]init];
    [self insertSubview:button atIndex:(self.subviews.count - 1)];
    //判断照片的数量，如果10张，我们就删除“+”
    if (self.photoes.count == 10) {
        [self.photoes removeLastObject];
        [self.addBtn removeFromSuperview];
    }
    [self updateNoticeText];
    [self setNeedsLayout];
}
//更新noticeLab的文字
- (void)updateNoticeText{
    NSInteger picCount = [self fetchPhotos].count;
    self.noticeLab.text = [NSString stringWithFormat:@"作品图片(%ld/9)",picCount];
}
#pragma 获取图片数组
-(NSArray *)fetchPhotos{
    //判断self.addBtn 是否在view中，用来确定是否返回
    if ([self.subviews containsObject:self.addBtn]) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:self.photoes];
        [temp removeLastObject];
        return temp;
    }else{
        return self.photoes;
    }
}
@end
