//
//  TFTopicVideoView.h
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/4.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TFTopic;
@interface TFTopicVideoView : UIView

/** 模型数据 */
@property (nonatomic,strong) TFTopic *topic;

+(instancetype)topicVideoView;


@end
