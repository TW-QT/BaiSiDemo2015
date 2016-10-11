//
//  TFCommentCell.h
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/7.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TFComment;
@interface TFCommentCell : UITableViewCell

/** 评论数据模型 */
@property (nonatomic,strong) TFComment *comment;

@end
