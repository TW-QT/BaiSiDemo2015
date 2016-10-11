//
//  TFFriendTrendsViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 16/5/28.
//  Copyright © 2016年 taofei. All rights reserved.
//

#import "TFFriendTrendsViewController.h"
#import "TFRecommendViewController.h"
#import "TFLoginRegisteViewController.h"

@interface TFFriendTrendsViewController ()


@end

@implementation TFFriendTrendsViewController


/**
 *注册登录
 */
- (IBAction)loginRegister:(id)sender {
    
    
    TFLoginRegisteViewController  *login=[[TFLoginRegisteViewController alloc]init];
    
    [self presentViewController:login animated:YES completion:nil];
    
    TFLogFunc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏的标题
    self.navigationItem.title=@"我的关注";
    
    //利用分类,设置导航栏左边的按钮,给左边的按钮添加点击事件
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsButtonClick)];
    
    //统一设置关注控制器view的背景色
    self.view.backgroundColor=TFGlobalBg;

}



-(void)friendsButtonClick{

    TFLogFunc;
    //push推荐关注控制器 
    TFRecommendViewController *recommendVc=[[TFRecommendViewController alloc]init];
    [self.navigationController pushViewController:recommendVc animated:YES];
    
    
}



@end
