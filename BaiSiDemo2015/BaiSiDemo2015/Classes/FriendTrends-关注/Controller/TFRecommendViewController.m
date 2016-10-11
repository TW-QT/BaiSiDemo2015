//
//  TFRecommendViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/30.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "TFRecommendCategoryCell.h"
#import "TFRecommendCategory.h"
#import "MJExtension.h"
#import "TFRecommendUser.h"
#import "TFRecommendUserCell.h"
#import "MJRefresh.h"


#define TFSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface TFRecommendViewController ()<UITableViewDataSource,UITableViewDelegate >



/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

/** 左边的类别数据 */
@property (nonatomic,strong) NSArray *categories;

/** 右边的推荐用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTabelView;
//** 请求参数 */
@property (nonatomic,strong) NSMutableDictionary   *params;

/** AFNetworking的请求管理者 */
@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

static NSString *const TFCategoryId=@"category";
static NSString *const TFUserId=@"user";




@implementation TFRecommendViewController


-(AFHTTPSessionManager *)manager{

    if(!_manager)
        _manager=[AFHTTPSessionManager manager];
    return _manager;

}



- (void)viewDidLoad {
    [super viewDidLoad];
    //控件的初始化
    [self setupTabelView];
    
    //添加刷新控件
    [self setupRefresh];
    
    
    //显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    
    //加载左侧的数据
    [self loadCategories];
    
    
}


/**
 *加载左侧的数据
 */
-(void)loadCategories{
    //发送网络请求给服务器,使用第三方框架AFNetworking
    //设置请求参数,两个必选的请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"category";
    params[@"c"]=@"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //服务器返回的json数据
        self.categories=[TFRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.categoryTableView reloadData];
        //默认选中左边的首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //刷新右边表格
        [self.userTabelView.header beginRefreshing];
        
        
        TFLog(@"推荐关注---网络请求成功!");
        
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        TFLog(@"推荐关注---网络请求失败!");
        //指示器显示失败信息
        [SVProgressHUD showErrorWithStatus:@"推荐关注---网络请求失败!"];
    }];



}


-(void)setupTabelView{
    //注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:TFCategoryId];
    
    [self.userTabelView  registerNib:[UINib nibWithNibName:NSStringFromClass([TFRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:TFUserId];
    
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.categoryTableView.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTabelView.contentInset=self.categoryTableView.contentInset;
    self.userTabelView.rowHeight=70;
    
    // 设置标题为"推荐关注"
    self.title=@"推荐关注";
    //设置统一的控制器背景色
    self.view.backgroundColor=TFGlobalBg;

}

/**
 *添加刷新控件
 */
-(void)setupRefresh{
    
    //设置header,以及header中的方法实现网络数据的请求.
    self.userTabelView.header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    //设置footer,以及header中的方法实现网络数据的请求.
    self.userTabelView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTabelView.footer.hidden=YES;
}

/**
 *加载更多的数据,此方法是由MJRefresh中的footer设置时决定了当出现footer时会自动被调用.
 */
-(void)loadMoreUsers{
    TFLog(@"进入上拉刷新状态");
    
    TFRecommendCategory *category=TFSelectedCategory;
    
    
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"list";
    params[@"c"]=@"subscribe";
    params[@"category_id"]=@(category.id);
    params[@"page"]=@(++category.currentPage);
    self.params=params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典数组-->模型数组
        NSArray *users=[TFRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加当前类别到对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        //处理不需要的请求,不是最后一次请求
        if(_params!=params) return;
        
        
        //刷新右边的用户数据
        [self.userTabelView reloadData];
 
        
        //检查footer的状态,结束底部的刷新
        [self checkFooterStatus];
        
        TFLog(@"推荐关注右边---网络请求成功!");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //处理不需要的请求
        if(_params!=params) return;
        
        
        //提示失败
        [SVProgressHUD showErrorWithStatus:@"加载最新的数据失败"];
        //让底部控件结束刷新
        [self.userTabelView.footer endRefreshing];
        TFLog(@"推荐关注右边---网络请求失败!");
    }];
}





#pragma mark - 加载最新的用户数据
-(void)loadNewUsers{

    TFLogFunc;
    
    TFRecommendCategory *c=TFSelectedCategory;
    
    //设置当前页码为1
    c.currentPage=1;
    //模拟网速慢
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //发送请求给服务器,加载右边的数据,设置请求参数,两个必选的请求参数
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        params[@"a"]=@"list";
        params[@"c"]=@"subscribe";
        params[@"category_id"]=@(c.id);
        params[@"page"]=@(c.currentPage);
        self.params=params;
    
        [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //字典数组-->模型数组
            NSArray *users=[TFRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            //清除之前的所有旧数据
            [c.users removeAllObjects];
            
            //添加当前类别到对应的用户数组中
            [c.users addObjectsFromArray:users];
            //保存有用数据
            c.total=[responseObject[@"total"] integerValue];
            
            //处理不需要的请求,不是最后一次请求
            if(_params!=params) return;
    
            //刷新右边的用户数据
            [self.userTabelView reloadData];
            
            
            
            //结束刷新,头部结束刷新
            [self.userTabelView.header endRefreshing];
    
    
            
            //检查footer的状态
            [self checkFooterStatus];
    
    
    
            TFLog(@"%@",responseObject);
            TFLog(@"推荐关注右边---网络请求成功!");
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            //处理不需要的请求
            if(_params!=params) return;
            //提示失败
            [SVProgressHUD showErrorWithStatus:@"加载最新的数据失败"];
            //结束刷新
            [self.userTabelView.header endRefreshing];
            
            
            TFLog(@"推荐关注右边---网络请求失败!");
        }];
//    });//模拟网速慢
}
/**
 *时刻检查footer的状态
 */
-(void)checkFooterStatus{

    TFRecommendCategory *c=TFSelectedCategory;
    if(c.users.count==c.total){
        //全部加载完毕,提醒用户没有更多数据
        [self.userTabelView.footer noticeNoMoreData];
    }else{
        //还没加载完毕,让底部控件结束刷新
        [self.userTabelView.footer endRefreshing];
    }

}





//数据源的方法
#pragma mark - <UITableViewDataSource>


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView==self.categoryTableView){
        
        //左边的分类表格
        return self.categories.count ;
    }else{
        //右边的用户表格
        TFRecommendCategory *c=TFSelectedCategory;
        
        NSInteger count=c.users.count;
        //每次刷新右边的数据时都控制右边的footer的显示或者隐藏
        self.userTabelView.footer.hidden=(count==0);
        
        //检查footer的状态
        [self checkFooterStatus];
        
        return count;
    }

    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView==self.categoryTableView){
        //左边的类别表格
        TFRecommendCategoryCell *cell=[tableView dequeueReusableCellWithIdentifier:TFCategoryId];
        
        
        //设置cell模型中的数据
        cell.category=self.categories[indexPath.row];
        
        return cell;
    
    
    }else{
        //右边的用户表格
        TFRecommendUserCell *cell=[tableView dequeueReusableCellWithIdentifier:TFUserId];

        //设置cell模型中的数据
        cell.user=[TFSelectedCategory users][indexPath.row];
        return cell;
    }
}



//代理方法
#pragma mark - <UITableViewDelegate>

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //结束刷新
    [self.userTabelView.header endRefreshing];
    [self.userTabelView.footer endRefreshing];
    
    
    //获取选中的左边的行数中的cell中的内容
    TFRecommendCategory *c=self.categories[indexPath.row];
    TFLog(@"%@",c.name);
    
    
    //结束之前的刷新
    [self.userTabelView.footer endRefreshing];
    
    
    
    
    if(c.users.count!=0){
        //显示曾经的数据,避免重复发送请求,解决问题1,把分类的右边的用户数据加到类别模型的数据中
        [self.userTabelView reloadData];
    
    }else{
        //赶紧刷新右边表格数据,以免显示旧的数据给用户造成假象
        [self.userTabelView reloadData];
        
        
        //进入下拉刷新状态,loadNewUsers
        [self.userTabelView.header beginRefreshing];
    }
}

/**
 *1.重复发送请求
 *2.目前只能显示1页数据
 *3.网络慢是带来的细节问题
 */


#pragma mark - 控制器的销毁

-(void)dealloc{
    
    //停止所有的操作
    [self.manager.operationQueue cancelAllOperations];

}


@end



//左边类别选中的模型
//TFRecommendCategory *c= self.categories[self.categoryTableView.indexPathForSelectedRow.row];
