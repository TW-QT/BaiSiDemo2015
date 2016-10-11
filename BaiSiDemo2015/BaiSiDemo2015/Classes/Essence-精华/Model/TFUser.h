//
//  TFUser.h
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/4.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFUser : NSObject

/** 用户名 */
@property (nonatomic,copy) NSString *username;
/** 性别 */
@property (nonatomic,copy) NSString *sex;
/** 头像 */
@property (nonatomic,copy) NSString *profile_image;

@end
