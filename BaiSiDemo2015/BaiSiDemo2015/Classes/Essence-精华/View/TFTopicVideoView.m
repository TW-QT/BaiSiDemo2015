//
//  TFTopicVideoView.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/4.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFTopicVideoView.h"
#import "UIImageView+WebCache.h"
#import "TFTopic.h"

@interface TFTopicVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;


@end

@implementation TFTopicVideoView




+(instancetype)topicVideoView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

-(void)awakeFromNib{
    
    self.autoresizingMask=UIViewAutoresizingNone;
    
}

-(void)setTopic:(TFTopic *)topic{
    
    
    _topic=topic;
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    //播放次数
    self.playCountLabel.text=[NSString stringWithFormat:@"已播放%zd次",topic.playcount];
    
    
    //时长
    NSInteger sencond=topic.videotime;
    NSInteger minute=sencond/60;
    sencond=sencond%60;
    
    
    
    self.videoTimeLabel.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,sencond];
    
//    TFLog(@"视频:%zd",topic.videotime);

}
@end
