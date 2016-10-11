//
//  UIImage+TFExtension.m
//
//  Created by 陶飞 on 15/6/8.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "UIImage+TFExtension.h"

@implementation UIImage (TFExtension)



/**
 *圆形图片
 *
 */
-(UIImage *)circleImage{
    
    //开启一个透明的图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //添加一个圆
    CGRect rect=CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    //裁剪
    CGContextClip(ctx);
    //将图片画上去
    [self drawInRect:rect];
    
    
    //从图形上下文中获取要现实的圆形图片
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    //结束图形上下文
    UIGraphicsEndImageContext();
    

    
    return image;

}


@end
