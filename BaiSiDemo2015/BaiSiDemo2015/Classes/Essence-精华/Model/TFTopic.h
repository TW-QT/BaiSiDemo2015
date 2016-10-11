//
//  TFTopic.h
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/1.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import <Foundation/Foundation.h>//最好改为UIkit框架

@interface TFTopic : NSObject

/** id */
@property (nonatomic,strong) NSString *ID;
/** 发帖人姓名 */
@property (nonatomic,copy) NSString *name;
/** 头像的URL */
@property (nonatomic,copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic,copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic,copy) NSString *text;
/** 顶的数量 */
@property (nonatomic,assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic,assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic,assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic,assign) NSInteger comment;
/** 是否为新浪的加V用户 */
@property (nonatomic,assign,getter=isSina_v) BOOL sina_v;
/** 图片的宽度 */
@property (nonatomic,assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic,assign) CGFloat height;
/** small_image图片的URL */
@property (nonatomic,copy) NSString *small_image;
/** large_image图片的URL */
@property (nonatomic,copy) NSString *large_image;
/** middle_image图片的URL */
@property (nonatomic,copy) NSString *middle_image;
/** 帖子的类型 */
@property (nonatomic,assign) TFTopicType type;
/** 声音的时长 */
@property (nonatomic,assign) NSInteger voicetime;
/** 播放次数 */
@property (nonatomic,assign) NSInteger playcount;
/** 视频的时长 */
@property (nonatomic,assign) NSInteger videotime;
/** 最热评论()期望是comment模型 */
@property (nonatomic,strong) NSArray  *top_cmt;






/**额外的属性*/
/** cell的高度*/
@property (nonatomic,assign,readonly) CGFloat cellH;
/** 图片控件的frame */
@property (nonatomic,assign,readonly) CGRect pictureViewFrame;
/** 图片是否太大 */
@property (nonatomic,assign,getter=isPictureTooBig) BOOL pictureTooBig;
/** 图片的下载进度*/
@property (nonatomic,assign) CGFloat pictureProgress;


/** 声音控件的frame */
@property (nonatomic,assign,readonly) CGRect voiceViewFrame;
/** 声音控件的frame */
@property (nonatomic,assign,readonly) CGRect videoViewFrame;

@end
