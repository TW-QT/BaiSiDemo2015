//
//  UIImageView+TFExtentsion.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/8.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "UIImageView+TFExtentsion.h"
#import "UIImageView+WebCache.h"


@implementation UIImageView (TFExtentsion)

-(void)setCircleHeader:(NSString *)url{
    
    UIImage *placeholder=[[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.image=image?[image circleImage]:placeholder;
    }];

    

}

@end
