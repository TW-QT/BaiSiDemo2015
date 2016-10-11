//
//  TFTopWindow.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/8.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFTopWindow.h"

@implementation TFTopWindow

static UIWindow *window_;

+(void)initialize{

    window_=[[UIWindow alloc]init];
    window_.frame=CGRectMake(0, 0, TFScreenW, 20);
    window_.windowLevel=UIWindowLevelAlert;
//    window_.backgroundColor=[UIColor yellowColor];
    window_.backgroundColor=[UIColor clearColor];
    window_.rootViewController=[[UIViewController alloc]init];
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)] ];

}


+(void)show{

    
    window_.hidden=NO;

}

+(void)windowClick{
    
    TFLogFunc;

    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    
    [self searchScrollViewInView:window];

}

+(void)searchScrollViewInView:(UIView *)superView{
    for (UIScrollView *subiew in superView.subviews) {
        //得到subview在窗口中得frame
        CGRect newRect=[subiew.superview convertRect:subiew.frame toView:nil];
        //window的bounds
        CGRect windowbounds=[UIApplication sharedApplication].keyWindow.bounds;
        
        BOOL isShowOnWindow=(subiew.window)&&(!subiew.isHidden)&&(subiew.alpha>0.01)&&(CGRectIntersectsRect(newRect, windowbounds));
        
        
        
        if([subiew isKindOfClass:[UIScrollView class]]&&isShowOnWindow){
            CGPoint offset=subiew.contentOffset;
            offset.y=-subiew.contentInset.top;
            [subiew setContentOffset:offset animated:YES];
            
        }
        //继续查找子控件
        [self searchScrollViewInView:subiew];
    }

}

@end
