//
//  TFTopicViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/1.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFTopicViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "TFTopic.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "TFTopicCell.h"
#import "TFCommentViewController.h"
#import "TFNewViewController.h"
#import "TFEssenceViewController.h"

@interface TFTopicViewController ()

/** 帖子数据 */
@property (nonatomic,strong) NSMutableArray *topics;
/** 当前的页码 */
@property (nonatomic,assign) NSInteger page;
/** 当加载下一页时需要这个参数  */
@property (nonatomic,strong) NSString *maxtime;
/** 上一次的请求参数 */
@property (nonatomic,strong) NSDictionary *params;
/** 上次选中的tabBar中控制器的索引 */
@property (nonatomic,assign) NSInteger lastSelectedViewControllerIndex;

@end

@implementation TFTopicViewController



-(NSMutableArray *)topics{
    if(!_topics){
        _topics=[NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化表格
    [self setupTabelView];
    
    //添加刷新控件
    [self setupRefresher];
    
    //加载段子数据
    [self loadNewTopics];
    
    
}

static NSString *const TFTopicCellId=@"topic";

-(void)setupTabelView{
    //设置内间距
    CGFloat bottom=self.tabBarController.tabBar.height;
    CGFloat top=TFtitlesViewH+TFtitlesViewY;
    self.tableView.contentInset=UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets=self.tableView.contentInset;
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor clearColor];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFTopicCell class]) bundle:nil] forCellReuseIdentifier:TFTopicCellId];
    
    //监听tabBar点击的通知
    [TFNotoiceCenter addObserver:self selector:@selector(tabBarSelected) name:TFTabBarDidSelectedNotification object:nil];
    
}
/**
 *监听tabBar点击的通知后的方法
 */
-(void)tabBarSelected{
    

    
    
    //选中的不是精华,选中的不是当前的导航控制器,直接返回
//    if(self.tabBarController.selectedViewController!=self.navigationController) return;
    
    //如果不是连续选中两次的话也直接返回,如果是连续点中两次就刷新
    if(self.lastSelectedViewControllerIndex==self.tabBarController.selectedIndex&&
       self.view.isShowingOnKeyWindow)
        
        [self.tableView.header beginRefreshing];
 
    self.lastSelectedViewControllerIndex=self.tabBarController.selectedIndex;
    
//    TFLogFunc;



}


-(NSString *)a{
    
    
    return [self.parentViewController isKindOfClass:[TFNewViewController class]]?@"newlist":@"list";


}




#pragma mark - 添加刷新控件
/**
 *添加刷新控件
 */
-(void)setupRefresher{
    
    self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动改变透明度
    self.tableView.header.autoChangeAlpha=YES;
    self.tableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];

    [self.tableView.header beginRefreshing];
    
}


#pragma mark - 数据处理,加载新的段子数据
/**
 *加载新的段子数据
 */
-(void)loadNewTopics{
    
    //开始下来刷新,先结束上拉刷新
    [self.tableView.footer endRefreshing];
    
    
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=[self a];
    params[@"c"]=@"data";
    params[@"type"]=@(self.type);
    self.params=params;
    
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(self.params!=params) return ;
        
        //存储maxtime
        self.maxtime=responseObject[@"info"][@"maxtime"];
        
        //字典数组----->模型数组
        self.topics=[TFTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.footer endRefreshing];
        //结束刷新
        [self.tableView.header endRefreshing];
        
        //初始化页码
        self.page=0;
        
        TFLog(@"网络请求成功!");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.params!=params) return ;
        //提示失败
        [SVProgressHUD showErrorWithStatus:@"加载最新的数据失败"];
        TFLog(@"网络请求失败!");
        //结束刷新
        [self.tableView.footer endRefreshing];
        //结束刷新
        [self.tableView.header endRefreshing];
    }];
}

#pragma mark - 加载更多的topic数据
/**
 *加载更多的topic数据
 */
-(void)loadMoreTopics{
    
    
    //要上拉刷新,先结束下来刷新
    [self.tableView.header endRefreshing];
    
    self.page++;
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=[self a];
    params[@"c"]=@"data";
    params[@"type"]=@(self.type);
    params[@"page"]=@(self.page);
    params[@"maxtime"]=self.maxtime;
    self.params=params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(self.params!=params) return ;
        
        //存储maxtime
        self.maxtime=responseObject[@"info"][@"maxtime"];
        
        //字典数组----->模型数组
        NSArray *newTopics =[TFTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        

        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.footer endRefreshing];
        
        TFLog(@"网络请求成功!");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(self.params!=params) return ;
        //提示失败
        [SVProgressHUD showErrorWithStatus:@"加载最新的数据失败"];
        TFLog(@"网络请求失败!");
        //结束刷新
        [self.tableView.footer endRefreshing];
        self.page--;
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.footer.hidden=(self.topics.count==0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获取cell
    TFTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TFTopicCellId];
    
    //cell设置模型数据
    cell.topic=self.topics[indexPath.row];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取出帖子模型
    TFTopic *topic=self.topics[indexPath.row];

    return topic.cellH;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    TFCommentViewController *commentVc=[[TFCommentViewController alloc]init];
    commentVc.topic=self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
    
    TFLogFunc;

}

@end
