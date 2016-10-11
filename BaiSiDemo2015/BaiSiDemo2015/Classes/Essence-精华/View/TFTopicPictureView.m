//
//  TFTopicPictureView.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/2.
//  Copyright © 2015年 taofei. All rights reserved.
//  图片帖子中间的图片

#import "TFTopicPictureView.h"
#import "TFTopic.h"
#import "UIImageView+WebCache.h"
#import "DALabeledCircularProgressView.h"
#import "TFShowPictureViewController.h"



@interface TFTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *pictureIamgeView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;


@end


@implementation TFTopicPictureView


-(void)awakeFromNib{

    self.autoresizingMask=UIViewAutoresizingNone;
    
    //设置进度显示的圆角
    self.progressView.roundedCorners=2;
    self.progressView.progressLabel.textColor=[UIColor whiteColor];
    
    //给图片添加监听器
    self.pictureIamgeView.userInteractionEnabled=YES;
    [self.pictureIamgeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];

}


-(IBAction)seeBigPicture{
    TFShowPictureViewController *showPictureVc=[[TFShowPictureViewController alloc]init];
    showPictureVc.topic=self.topic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPictureVc animated:YES completion:nil];
    
}




+(instancetype)topicPictureView{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}


-(void)setTopic:(TFTopic *)topic{

    _topic=topic;
    
    
    //立马设置下载进度值....
    //...................
//    [self.progressView setProgress:topic.pictureProgress animated:YES];
    
    
    
    //设置显示的图片
//    [self.pictureIamgeView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    [self.pictureIamgeView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden=NO;
        [self.progressView setProgress:1.0*receivedSize/expectedSize animated:YES];
        self.progressView.progressLabel.text=[NSString stringWithFormat:@"%.0f%%",(1.0*receivedSize/expectedSize)*100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden=YES;
    }];
    
    //判断是否为gif
    NSString *extension=topic.large_image.pathExtension;
    self.gifView.hidden=![extension.lowercaseString isEqualToString:@"gif"];
    
    //判断是否显示"点击查看全图"的按钮
    if(topic.isPictureTooBig){
        self.seeBigButton.hidden=NO;
        self.pictureIamgeView.contentMode=UIViewContentModeScaleAspectFill;
    
    }else{
        self.seeBigButton.hidden=YES;
        self.pictureIamgeView.contentMode=UIViewContentModeScaleToFill;
    
    
    }

    
    
    

}
@end
