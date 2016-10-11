//
//  TFTabBar.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/28.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFTabBar.h"
#import "TFPublishViewController.h"

@interface TFTabBar()
/** 发布按钮 */
@property (nonatomic,strong) UIButton *publishButton;
@end

@implementation TFTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        //设置tabBar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        //添加中间的加号按钮
        UIButton *publishButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton=publishButton;
    }
    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //是否添加监听器
    static BOOL added=NO;
    
    //设置发布按钮的frame
    self.publishButton.size=self.publishButton.currentBackgroundImage.size;
    self.publishButton.center=CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
   

    //设置其他按钮的位置
    CGFloat buttonY=0;
    CGFloat buttonW=self.frame.size.width/5.0;
    CGFloat buttonH=self.frame.size.height;
    NSInteger index=0;
    for (UIControl *button in self.subviews) {
        //设置UITabBarButton的frame
        if(![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        //计算按钮的X值
        CGFloat buttonX=buttonW *((index>1)?(index+1):index);
        button.frame=CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
        
        
        //监听按钮的点击
        if(added==NO)
        [button addTarget:self action:@selector(tabBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    added=YES;
}


-(void)tabBarButtonClick{

    //发一个通知
    [TFNotoiceCenter postNotificationName:TFTabBarDidSelectedNotification object:nil userInfo:nil];

}



-(void)publishButtonClick{


    TFPublishViewController *publishVc=[[TFPublishViewController alloc]init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVc animated:NO completion:nil];


}

@end
