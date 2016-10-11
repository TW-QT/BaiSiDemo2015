//
//  TFComment.h
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/4.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import <Foundation/Foundation.h>


@class TFUser;

@interface TFComment : NSObject


/** id */
@property (nonatomic,strong) NSString *ID;

/** 音频文件的路径 */
@property (nonatomic,strong) NSString *voiceurl;

/** 音频的时长 */
@property (nonatomic,assign) NSInteger voicetime;

/** 评论的内容 */
@property (nonatomic,strong) NSString *content;

/** 评论被点赞的次数 */
@property (nonatomic,assign) NSInteger like_count;

/** 评论的人 */
@property (nonatomic,strong) TFUser *user;

@end
