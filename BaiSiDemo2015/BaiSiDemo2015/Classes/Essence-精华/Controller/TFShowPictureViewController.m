//
//  TFShowPictureViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/2.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFShowPictureViewController.h"
#import "UIImageView+WebCache.h"
#import "TFTopic.h"
#import "SVProgressHUD.h"
#import "DALabeledCircularProgressView.h"

@interface TFShowPictureViewController ()


/**
 *  滚动
 */
@property (weak, nonatomic) IBOutlet UIScrollView *pictureScrollView;
/**
 *  图片view
 */
@property (nonatomic,weak) UIImageView *pictureView;

/**
 * DALabeledCircularProgressView 进度条
 */
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@end

@implementation TFShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加图片控件
    UIImageView *pictureView=[[UIImageView alloc]init];
    self.pictureView=pictureView;
    pictureView.userInteractionEnabled=YES;
    [pictureView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.pictureScrollView addSubview:pictureView];
    
    //屏幕的尺寸
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    CGFloat screenH=[UIScreen mainScreen].bounds.size.height;
    
    //图片的尺寸
    CGFloat pictureW=screenW;
    CGFloat pictureH=pictureW*self.topic.height/self.topic.width;
    
    if(pictureH>screenH){
        //图片显示高度大于屏幕的宽度,需要滚动查看
        pictureView.frame=CGRectMake(0, 0, pictureW, pictureH);
        self.pictureScrollView.contentSize=CGSizeMake(0, pictureH);
        
        
    
    }else{
    
        pictureView.size=CGSizeMake(pictureW, pictureW);
        pictureView.centerY=screenH*0.5;
    }
    
    
//    [pictureView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    [pictureView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden=NO;
        CGFloat pictureProgress=1.0*receivedSize/expectedSize;
        self.topic.pictureProgress=pictureProgress;
        [self.progressView setProgress:self.topic.pictureProgress animated:YES];
        self.progressView.progressLabel.text=[NSString stringWithFormat:@"%.0f%%",(1.0*receivedSize/expectedSize)*100];
        
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden=YES;
    }];
    
    
}


-(IBAction )back{


    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)save {
    
    if(self.pictureView.image==nil){
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完毕"];
        return;
    
    
    }
    
    //将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.pictureView.image, self, @selector(image: didFinishSavingWithError: contextInfo:), nil);
    
    
    
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if(error){
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
    
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功"];
    
    }



}

@end
