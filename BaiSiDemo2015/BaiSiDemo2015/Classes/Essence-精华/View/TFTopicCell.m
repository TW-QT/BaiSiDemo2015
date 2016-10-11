//
//  TFTopicCell.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/1.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFTopicCell.h"
#import "TFTopic.h"
#import "UIImageView+WebCache.h"
#import "TFTopicPictureView.h"
#import "TFTopicVoiceView.h"
#import "TFTopicVideoView.h"
#import "TFComment.h"
#import "TFUser.h"
#import "UIImage+TFExtension.h"

@interface TFTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

/** 图片帖子中间的内容 */
@property (nonatomic,weak) TFTopicPictureView *topicPictureView;
/** 声音帖子中间的内容 */
@property (nonatomic,weak) TFTopicVoiceView *topicVoiceView;
/** 声音帖子中间的内容 */
@property (nonatomic,weak) TFTopicVideoView  *topicVideoView;
/** 最热评论的整体 */
@property (weak, nonatomic) IBOutlet UIView *top_cmtView;
/** 最热评论的内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
/** 最热评论的用户名 */
@property (weak, nonatomic) IBOutlet UILabel *top_cmtUserLabel;

@end

@implementation TFTopicCell

+(instancetype)cell{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject] ;

}



-(TFTopicPictureView *)topicPictureView{

    if(!_topicPictureView){
        TFTopicPictureView *topicPictureView=[TFTopicPictureView topicPictureView];
        [self.contentView addSubview:topicPictureView];
        _topicPictureView=topicPictureView;
    }

    return _topicPictureView;
}
-(TFTopicVoiceView *)topicVoiceView{
    
    if(!_topicVoiceView){
        TFTopicVoiceView *topicVoiceView=[TFTopicVoiceView topicVoiceView];
        [self.contentView addSubview:topicVoiceView];
        _topicVoiceView=topicVoiceView;
    }
    
    return _topicVoiceView;
}
-(TFTopicVideoView *)topicVideoView{
    
    if(!_topicVideoView){
        TFTopicVideoView *topicVideoView=[TFTopicVideoView topicVideoView];
        [self.contentView addSubview:topicVideoView];
        _topicVideoView=topicVideoView;
    }
    
    return _topicVideoView;
}


-(void)awakeFromNib{
    
    UIImageView *bgView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.backgroundView=bgView;
    
//    self.profile_imageView.layer.cornerRadius=self.profile_imageView.width*0.5;
//    self.profile_imageView.layer.masksToBounds=YES;



}

-(void)setTopic:(TFTopic *)topic{

    //设置其他的控件
    _topic=topic;
    
    UIImage* profileimage=[[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    [self.profile_imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
            
        self.profile_imageView.image=image?[image circleImage]:profileimage;
    }];
    self.nameLabel.text=topic.name;
    
    //新浪加V
    self.sina_vImageView.hidden=!topic.isSina_v;
    
    //设置帖子的创建时间
    self.createTimeLabel.text=topic.create_time;
    
    //设置按钮的文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"转发"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    
    //设置帖子的文字内容
    self.text_label.text=topic.text;
    
    
    
//    TFTopicTypeAll=1,
//    TFTopicTypePicture=10,
//    TFTopicTypeWord=29,
//    TFTopicTypeVoice=31,
////    TFTopicTypeVideo=41,
//    
    //根据帖子的类型添加相应的内容到帖子中间
    if(topic.type==TFTopicTypePicture)
    {
        //图片
        
        self.topicVoiceView.hidden=YES;
        self.topicVideoView.hidden=YES;
        self.topicPictureView.hidden=NO;
        self.topicPictureView.topic=self.topic;
        self.topicPictureView.frame=topic.pictureViewFrame;
    }else if(topic.type==TFTopicTypeVoice){
        //音频
        self.topicVoiceView.hidden=NO;
        self.topicVideoView.hidden=YES;
        self.topicPictureView.hidden=YES;//这里的bug没有解决
        self.topicVoiceView.topic=self.topic;
        self.topicVoiceView.frame=topic.voiceViewFrame;
        
    
    }else if(topic.type==TFTopicTypeVideo){
        //视频
        self.topicVideoView.hidden=NO;
        self.topicPictureView.hidden=YES;//这里的bug没有解决
        self.topicVoiceView.hidden=YES;//这里的bug没有解决
        self.topicVideoView.topic=self.topic;
        self.topicVideoView.frame=topic.videoViewFrame;
    }else if(topic.type==TFTopicTypeWord){
    
        self.topicPictureView.hidden=YES;
        self.topicVoiceView.hidden=YES;
        self.topicVideoView.hidden=YES;
    }
    
    //处理最热评论
    TFComment *top_cmt=[self.topic.top_cmt firstObject];
    if(top_cmt){
        self.contentLabel.hidden=NO;
        self.top_cmtUserLabel.hidden=NO;
        self.contentLabel.text=[NSString stringWithFormat:@"%@:%@",top_cmt.user.username,top_cmt.content];
    }else{
        self.contentLabel.hidden=YES;
        self.top_cmtUserLabel.hidden=YES;
    
    }
    
    
    
}

/**
 *设置按钮的文字标题
 */
-(void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    NSString *title=nil;
    if(count==0){
        title=placeholder;
    }else if(count>10000){
        title=[NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else{
        title=[NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:title forState:UIControlStateNormal];
}


-(void)setFrame:(CGRect)frame{

    frame.origin.x=TFTopicCellMargin;
    frame.size.width-=2*TFTopicCellMargin;
//    frame.size.height-=TFTopicCellMargin;//这句有问题
    frame.size.height=self.topic.cellH-TFTopicCellMargin;
    frame.origin.y+=TFTopicCellMargin;
    
    [super setFrame:frame];

 }
- (IBAction)more:(id)sender {
    
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    
    
    [sheet showInView:self.window];
    
}




@end
