//
//  AppDelegate.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/28.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "AppDelegate.h"
#import "TFTabBarController.h"
#import "TFPushGuideView.h"
#import "TFTopWindow.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1.创建窗口
    self.window=[[UIWindow alloc]init];//创建一个空的窗口
    self.window.frame=[UIScreen mainScreen].bounds;//设置窗口的尺寸
    //2.设置窗口的跟控制器
    //2.0初始化一个tabBarController
    TFTabBarController *tabBarController=[[TFTabBarController alloc]init];
    self.window.rootViewController=tabBarController;//设置tabBarController为跟控制器
    tabBarController.delegate=self;
    
    
    //3.显示窗口
    [self.window makeKeyAndVisible];
    
    //4.显示推送指南
    [TFPushGuideView show];
    
    
    
    
    
       
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //添加一个window.回滚
    [TFTopWindow show];
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -<UITabBarControllerDelegate>
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    //发出通知
//    NSMutableDictionary *userInfo=[NSMutableDictionary dictionary];
//    userInfo[TFSelectedControllerKey]=viewController;
//    userInfo[TFSelectedControllerIndexKey]=@(tabBarController.selectedIndex);
    
    
    [TFNotoiceCenter postNotificationName:TFTabBarDidSelectedNotification object:nil userInfo:nil];
    
    
//    TFLog(@"%@",viewController);
    
}

@end
