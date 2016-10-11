//
//  TFMeViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/28.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFMeViewController.h"
#import "TFMineCell.h"
#import "TFMeFooterView.h"



@interface TFMeViewController ()

@end

@implementation TFMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //设置tableView
    [self setupTabelView];
    
    
    //设置footerView
    self.tableView.tableFooterView=[[TFMeFooterView alloc]init];
    
    
}
-(void)setupNav{
    //设置导航栏的标题
    self.navigationItem.title=@"我的";
    
    //设置导航栏右边的按钮
    UIBarButtonItem *settingItem=[UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingItemClick)];
    
    UIBarButtonItem *moonItem=[UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonItemClick)];
    
    self.navigationItem.rightBarButtonItems=@[settingItem,moonItem];
}


/**
 *设置tableView
 */
-(void)setupTabelView{
    
    //统一设置我控制器view的背景色
    self.tableView.backgroundColor=TFGlobalBg;
    [self.tableView registerClass:[TFMineCell class] forCellReuseIdentifier:@"meCell"];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight=0;
    self.tableView.sectionFooterHeight=10;
    self.tableView.contentInset=UIEdgeInsetsMake(-25, 0, 0, 0);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)settingItemClick{

    TFLogFunc;
}

-(void)moonItemClick{
    TFLogFunc;
}


#pragma mark -<数据源方法>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 1;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;

}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TFMineCell *cell=[tableView dequeueReusableCellWithIdentifier:@"meCell"];
//    if(cell==nil){
//    
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"meCell"];
//    
//    
//    }
    if(indexPath.section==0){
    cell.textLabel.text=@"登录/注册";
        cell.imageView.image=[UIImage imageNamed:@"mine_icon_nearby"];
    
    }else if(indexPath.section==1){
        cell.textLabel.text=@"离线下载";
    }


    return cell;


}









@end
