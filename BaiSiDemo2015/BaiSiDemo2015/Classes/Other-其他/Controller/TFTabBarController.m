//
//  TFTabBarController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/28.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFTabBarController.h"
#import "TFEssenceViewController.h"
#import "TFNewViewController.h"
#import "TFFriendTrendsViewController.h"
#import "TFMeViewController.h"
#import "TFTabBar.h"
#import "TFNavgationController.h"

@interface TFTabBarController ()

@end

@implementation TFTabBarController

+(void)initialize{
    // Do any additional setup after loading the view.
    //    不要渲染成蓝色
    //    UIImage *image=[UIImage imageNamed:@"tabBar_essence_click_icon"];
    //    image=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    vc01.tabBarItem.selectedImage=image;
    
    //设置文字颜色的代码------------------------------------------------------------------------------------
    NSMutableDictionary *atrrs=[NSMutableDictionary dictionary];
    atrrs[NSFontAttributeName]=[UIFont systemFontOfSize:12];//字体保持一致
    atrrs[NSForegroundColorAttributeName]=[UIColor grayColor];
    
    NSMutableDictionary *selectedAtrrs=[NSMutableDictionary dictionary];
    selectedAtrrs[NSFontAttributeName]=atrrs[NSFontAttributeName];//字体保持一致
    selectedAtrrs[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    
    
    //设置UITabBarItem的appearance,通过appearance统一设置所有UITabBarItem的文字属性
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:atrrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAtrrs forState:UIControlStateSelected];
    //设置文字颜色的代码------------------------------------------------------------------------------------


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    
    [self setupChildVc:[[TFEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildVc:[[TFNewViewController  alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildVc:[[TFFriendTrendsViewController  alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVc:[[TFMeViewController  alloc]initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    
    //更换tabBar,readOnly,此时使用KVC
    [self setValue:[[TFTabBar alloc]init] forKey:@"tabBar"];
    
}
 
///**
// *设置tabBar中的item的位置,view即将显示
// */
//-(void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//
////    NSLog(@"%@",self.tabBar.subviews);
//    
//    for (UIView *button in self.tabBar.subviews) {
//
//    }
//}
//
//
//-(void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//
//
//
//}




/**
 *初始化子控制器
 */
-(void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置文字好图片

    vc.tabBarItem.title=title;//title参数
    vc.tabBarItem.image=[UIImage imageNamed:image];//未选中的图片
    vc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImage];//选中时的图片
    
    //不要在这里设置背景色,在这里设置背景色会导致view会被提前创建
    
    //包装一个导航控制器
    TFNavgationController *nav=[[TFNavgationController alloc]initWithRootViewController:vc];
    
    //添加导航控制器为子控制器
    [self addChildViewController:nav];

}



@end
