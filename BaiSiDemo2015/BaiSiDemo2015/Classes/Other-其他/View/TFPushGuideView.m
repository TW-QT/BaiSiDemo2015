//
//  TFPushGuideView.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/31.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFPushGuideView.h"

@implementation TFPushGuideView

//将pushGuideView移除
- (IBAction)closePushGuideView {

    [self removeFromSuperview];
}


+(instancetype)guideView{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];

}

+(void)show{

    //当第一次打开新版本时显示推送指导
    NSString *key=@"CFBundleShortVersionString";
    //获得当前的软件版本号
    NSString *currentVersion= [NSBundle mainBundle].infoDictionary[key];
    NSString *sanboxVersion=[[NSUserDefaults standardUserDefaults] stringForKey:key];
    if(![currentVersion isEqualToString:sanboxVersion]){
        
        //获取Window
        UIWindow *window=[[UIApplication sharedApplication] keyWindow];
        
        TFPushGuideView *pushGuideView=[TFPushGuideView guideView];
        pushGuideView.frame=window.bounds;
        [window addSubview:pushGuideView];
        //存储版本号,并马上存进去
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }


}

@end
