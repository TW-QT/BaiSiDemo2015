//
//  TFTopicViewController.h
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/1.
//  Copyright © 2015年 taofei. All rights reserved.
//  最基本的帖子控制器

#import <UIKit/UIKit.h>




@interface TFTopicViewController : UITableViewController

/** 帖子的类型 */
@property (nonatomic,assign) TFTopicType type;

-(void)loadNewTopics;

@end
