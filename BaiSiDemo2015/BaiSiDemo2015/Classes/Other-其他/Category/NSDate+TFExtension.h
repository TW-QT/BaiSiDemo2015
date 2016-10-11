//
//  NSDate+TFExtension.h
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/1.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TFExtension)
/**
 *比较from和self的时间差
 */
-(NSDateComponents *)deltaFrom:(NSDate *)from;


/**
 *判断是否是今年
 */
-(BOOL)isThisYear;



/**
 *判断是否是今天
 */
-(BOOL)isToday;



/**
 *判断是否是昨天
 */
-(BOOL)isYesterday;

@end
