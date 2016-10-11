//
//  TFNewViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/28.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFNewViewController.h"

@interface TFNewViewController ()

@end

@implementation TFNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏的标题
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //统一设置新帖控制器view的背景色
    self.view.backgroundColor=TFGlobalBg;
    
    
}



-(void)tagClick{
    TFLogFunc;
    
    
    
}


@end
