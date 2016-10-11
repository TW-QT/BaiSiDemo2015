//
//  TFRecommendCategory.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/30.
//  Copyright © 2015年 taofei. All rights reserved.
//  推荐关注左边的数据模型

#import "TFRecommendCategory.h"

@implementation TFRecommendCategory


-(NSMutableArray *)users{
    if(!_users){
        _users=[NSMutableArray array];
    
    }
    return _users;

}

@end
