//
//  TFRecommendTagsViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/31.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFRecommendTagsViewController.h"
#import "AFNetworking.h"
#import  "SVProgressHUD.h"
#import "MJExtension.h"
#import "TFRecommendTag.h"
#import "TFRecommendTagCell.h"

@interface TFRecommendTagsViewController ()

/** 推荐订阅标签数组 */
@property (nonatomic,strong) NSArray *tags;

@end


static NSString *const recommendTagId=@"tag";

@implementation TFRecommendTagsViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self setupTabelView];
    
    [self loadTags];

}

/**
 *初始化TabelView
 */
-(void)setupTabelView{
    self.title=@"推荐标签";
    self.tableView.rowHeight       = 70;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = TFGlobalBg;

    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:recommendTagId];

    //显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
}


/**
 *加载tableView中的数据
 */
-(void)loadTags{

    //发送请求给服务器,设置请求参数,两个必选的请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"tag_recommend ";
    params[@"action"]=@"sub";
    params[@"c"]=@"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //服务器返回的json数据
        self.tags=[TFRecommendTag objectArrayWithKeyValuesArray:responseObject];

        //刷新数据
        [self.tableView reloadData];


        TFLog(@"%@",responseObject);
        TFLog(@"推荐标签列表---网络请求成功!");
        //隐藏指示器
        [SVProgressHUD dismiss];


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TFLog(@"推荐标签列表---网络请求失败!");
        //指示器显示失败信息
        [SVProgressHUD showErrorWithStatus:@"推荐标签列表---网络请求失败!"];
    }];
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TFRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendTagId forIndexPath:indexPath];
    
    cell.recommendTag=self.tags[indexPath.row];
    
    return cell;
}

@end