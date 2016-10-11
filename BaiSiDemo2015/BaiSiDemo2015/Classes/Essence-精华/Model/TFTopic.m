//
//  TFTopic.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/1.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFTopic.h"
#import "MJExtension.h"
#import "TFComment.h"
#import "TFUser.h"

@implementation TFTopic
//这个成员变量要自己申明
{
    
    CGFloat _cellH;
    CGRect _pictureViewFrame;
    CGRect _voiceViewFrame;
    CGFloat _pictureProgress;
    CGRect _videoViewFrame;
}

+(NSDictionary *)replacedKeyFromPropertyName{

    return @{
             @"small_image":@"image0",
             @"large_image":@"image1",
             @"middle_image":@"image2",
             @"ID":@"id"
              };
}

+(NSDictionary *)objectClassInArray{


    return @{@"top_cmt":@"TFComment"};

}


-(NSString *)create_time{

    
    //优化时间显示,发布时间,字符串-->>>data,设置日期格式
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    //发布时间
    NSDate *create=[fmt dateFromString:_create_time];
    
    if ([create isThisYear]) {
        //今年
        if(create.isToday){
            //今天
            NSDateComponents *cmps=[[NSDate date] deltaFrom:create];
            if(cmps.hour>=1){
                //大于一个小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if(cmps.minute>=1){
                //不到一个小时
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
                
            }else{
                //小于1分钟
                return  @"刚刚";
                
            }
        }else if(create.isYesterday){
            //昨天
            fmt.dateFormat=@"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
            
        }else{
            //其他
            fmt.dateFormat=@"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }else{
        //非今年
        return _create_time;
    }
    
    
    /*
     非今年
     2012-01-02 12:22:22
     
     今年
     今天:今天 12:22:22
     1分钟内:刚刚
     1小时内:xx分钟前
     其他:xx小时前
     
     昨天: 昨天 19:12:12
     
     其他: 06-23 12:12:12
     */
}

-(CGFloat)cellH{
    
    
    if(!_cellH){
    
        CGSize maxSize=CGSizeMake([UIScreen mainScreen].bounds.size.width-4*TFTopicCellMargin, MAXFLOAT);
        //    CGFloat textH=[topic.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        
        
        
        CGFloat textH=[self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;

        
        //cell的高度,段子
        _cellH=TFTopicCellTextY+textH+TFTopicCellMargin;
        
        //根据帖子的类型来计算cell的高度
        if(self.type==TFTopicTypePicture)
        {
            //图片
            CGFloat imageW=maxSize.width;
            CGFloat imageH=imageW*self.height/self.width;
            CGFloat pictureX=TFTopicCellMargin;
            CGFloat pictureY=TFTopicCellTextY+textH+TFTopicCellMargin;
            if(imageH>TFTopicCellPictureMaxH){
                imageH=TFTopicCellPictureBreakH;
                self.pictureTooBig=YES;
            }
            _pictureViewFrame=CGRectMake(pictureX, pictureY, imageW, imageH);
            _cellH+=TFTopicCellMargin+imageH;
        }else if(self.type==TFTopicTypeVoice){
            //声音
            CGFloat voiceX=TFTopicCellMargin;;
            CGFloat voiceY=TFTopicCellTextY+textH+TFTopicCellMargin;
            CGFloat voiceW=maxSize.width;
            CGFloat voiceH=voiceW*self.height/self.width;
            _voiceViewFrame=CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellH+=TFTopicCellMargin+voiceH;
            
        }else if (self.type==TFTopicTypeVideo){
            //视频
            CGFloat videoX=TFTopicCellMargin;;
            CGFloat viodeY=TFTopicCellTextY+textH+TFTopicCellMargin;
            CGFloat videoW=maxSize.width;
            CGFloat videoH=videoW*self.height/self.width;
            _videoViewFrame=CGRectMake(videoX, viodeY, videoW, videoH);
            _cellH+=TFTopicCellMargin+videoH;
        
        }else if(self.type==TFTopicTypeWord){
        
        
        
        }
        
        //如果有最热评论
        TFComment *top_cmt=[self.top_cmt firstObject];
        if(top_cmt){
            
            CGFloat contentH=[top_cmt.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}  context:nil].size.height;
            
            _cellH+=20+TFTopicCellMargin+contentH;
        
        }
        
        
        
        _cellH+=TFTopicCellBottomBarH+TFTopicCellMargin;
    }

    
    return _cellH;
    
//    TFTopicTypeAll=1,
//    TFTopicTypePicture=10,
//    TFTopicTypeWord=29,
//    TFTopicTypeVoice=31,
////    TFTopicTypeVideo=41,

}


@end
