//
//  TFRecommendUser.h
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/30.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFRecommendUser : NSObject



/** 头像 */
@property (nonatomic,strong) NSString *header;
/** 粉丝数(有多少人关注这个用户) */
@property (nonatomic,assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic,strong) NSString *screen_name;

@end
