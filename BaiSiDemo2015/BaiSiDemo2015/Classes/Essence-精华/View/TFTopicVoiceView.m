//
//  TFTopicVoiceView.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/3.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFTopicVoiceView.h"
#import "UIImageView+WebCache.h"
#import "TFTopic.h"
#import "TFShowPictureViewController.h"



@interface TFTopicVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
@property (weak, nonatomic) IBOutlet UILabel *voiceLengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicePlayCountLabel;

@end

@implementation TFTopicVoiceView

+(instancetype)topicVoiceView{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

-(void)awakeFromNib{
    
    self.autoresizingMask=UIViewAutoresizingNone;
    


  
}



-(void)setTopic:(TFTopic *)topic{
    _topic=topic;
    [self.voiceImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    
    
    self.voicePlayCountLabel.text=[NSString stringWithFormat:@"已播放%zd次",topic.playcount];
    
    
    //时长
    NSInteger sencond=topic.voicetime;
    NSInteger minute=sencond/60;
    sencond=sencond%60;
    
    
    
    self.voiceLengthLabel.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,sencond];
    
//    TFLog(@"音频:%zd",topic.voicetime);
    


}
@end
