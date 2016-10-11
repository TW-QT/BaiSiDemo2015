//
//  TFRecommendTag.h
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/31.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFRecommendTag : NSObject

/** 图片 */
@property (nonatomic,strong) NSString *image_list;
/** 名字 */
@property (nonatomic,strong) NSString *theme_name;
/** 订阅数 */
@property (nonatomic,assign) NSInteger sub_number;

@end
