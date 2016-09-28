//
//  CameraViewController.m
//  Art
//
//  Created by dkq on 16/4/20.
//  Copyright © 2016年 kaiqiang. All rights reserved.
//

#import "CameraViewController.h"
#import "THEditPhotoView.h"
#import <MobileCoreServices/UTCoreTypes.h>


@interface CameraViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,THEditPhotoViewDelegate>
{
    NSInteger ret;

}

@property (nonatomic,strong) UITableView *tableView;
@property(weak,nonatomic) THEditPhotoView *editPhotoView;

//用来记录图片的个数
@property (nonatomic, strong) NSMutableArray *chosenImages;


@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //currentHeight = 155;
    self.chosenImages = [[NSMutableArray alloc] init];
    //添加导航栏右侧侧按钮
    [self createNavigationRightButton];
    [self createViewHead];
    
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetPostNofificationForUploadhead:) name:@"kDeleteAPicFromView" object:nil];
}

-(void)createViewHead{

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
   // self.tableView = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self upLoadView];

}

//刷新视图
-(void)upLoadView{

    NSInteger currentRow;
    if (self.chosenImages.count == 9) {
        currentRow = 3;
    }
    else{
        currentRow = self.chosenImages.count / 3 + 1;
    }
    currentHeight = currentRow *((ScreenWidth - (4 * 15))/3.0 + 15) + 15 + 15 + 5;
    THEditPhotoView *editPhotoView = [THEditPhotoView editPhotoView];
    editPhotoView.frame = CGRectMake(0, 0, ScreenWidth, currentHeight);
    // editPhotoView.frame = CGRectMake(0, 0, ScreenWidth, currentHeight);
    editPhotoView.delegate = self;
    self.editPhotoView = editPhotoView;
    self.tableView.tableHeaderView = editPhotoView;
}

-(void)GetPostNofificationForUploadhead:(NSNotification *)noti{
    [self.chosenImages removeObjectAtIndex:self.chosenImages.count - 1];
    [self upLoadView];
}

//添加导航栏右侧侧按钮
-(void)createNavigationRightButton{
    
    UIButton *customButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 25)];
    [customButton addTarget:self action:@selector(barButtonItemRight) forControlEvents:UIControlEventTouchUpInside];
    [customButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[customButton setImage:[UIImage imageNamed:@"发送"] forState:UIControlStateNormal];
    [customButton setTitle:@"发送" forState:UIControlStateNormal];
    UIBarButtonItem *barItem = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:customButton];
    self.navigationItem.rightBarButtonItem = barItem;
}

-(void)barButtonItemRight{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = @[@"作品名",@"作品简介"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"1"];
    }
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    cell.textLabel.textColor = RGB(51, 51, 51);
    cell.textLabel.font = [UIFont systemFontOfSize:15.f];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma mark - THEditPhotoViewDelegate代理方法
-(void)editPhotoViewToOpenAblum:(THEditPhotoView *)editView{
    ret = 9 - self.chosenImages.count;
    
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
            elcPicker.maximumImagesCount = ret; //Set the maximum number of images to select to 100
            elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
            elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
            elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
            elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie]; //Supports image and movie types
            elcPicker.imagePickerDelegate = self;
            [self presentViewController:elcPicker animated:YES completion:nil];
            
            
        }else {
            [self showMessage:@"你不能调用相册，是否继续调用"];
        }
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self selectImageWith:UIImagePickerControllerSourceTypeCamera];
        }else {
            [self showMessage:@"你不能调用相机，是否继续调用"];
        }
    }]];
    
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertCon animated:YES completion:^{
        
    }];
}

//用来调用相机
- (void)selectImageWith:(UIImagePickerControllerSourceType)type {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = type;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:^{
    }];
}

//调用相机，
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGSize size = CGSizeMake(ScreenWidth, ScreenHeight);
    [self.editPhotoView addOneImage:[self imageWithImageSimple:image scaledToSize:size]];
    [self.chosenImages addObject:image];
}


#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    //   NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                CGSize size = CGSizeMake(ScreenWidth, ScreenHeight);

                 [self.editPhotoView addOneImage:[self imageWithImageSimple:image scaledToSize:size]];
                [self.chosenImages addObject:image];
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
               // UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            NSLog(@"Uknown asset type");
        }
    }
    //self.chosenImages = images;
}


//重新修改图片的大小
-(UIImage *) imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize) newSize{
    newSize.height=image.size.height*(newSize.width/image.size.width);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}



-(void)showMessage:(NSString *)message{
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"放弃不取消", nil];
    [alertView show];
}


- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//-(void)dealloc{
//    [[NSNotificationCenter debugDescription] removeObserver:self forKeyPath:@"kDeleteAPicFromView"];
//}





@end
