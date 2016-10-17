//
//  TFCommentViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/4.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFCommentViewController.h"
#import "TFTopicCell.h"
#import "TFTopic.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "TFComment.h"
#import "MJExtension.h"
#import "TFCommentCell.h"
  


static NSString *const commentCellId=@"comment";

@interface TFCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 工具条与底部的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarToBottom;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 热评 */
@property (nonatomic,strong) NSArray *hotComment;
/** 最新评论 */
@property (nonatomic,strong) NSMutableArray *latestComments;

/** 保存的saved_top_cmt */
@property (nonatomic,strong) NSArray *saved_top_cmt;

/** 当前的页码 */
@property (nonatomic,assign) NSInteger page;

/** AFHTTPSessionManager */
@property (nonatomic,strong) AFHTTPSessionManager *manage;


@end

@implementation TFCommentViewController

-(AFHTTPSessionManager *)manage{
    
    if(!_manage){
    
        _manage=[AFHTTPSessionManager manager];
    }
    return _manage;

}


-(NSMutableArray *)latestComments{

    if(!_latestComments){
        NSMutableArray *latestComments=[[NSMutableArray alloc]init];
        _latestComments=latestComments;
    
    }
    return _latestComments;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 基本的设置 */
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupReresh];
    
   
}

/** 基本的设置 */
-(void)setupBasic{
    
    
    
    self.title=@"评论";
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:self action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    
    //cell的高度设置
    self.tableView.estimatedRowHeight=44;
    //每一行的高度自动计算
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    
    //背景色
    self.tableView.backgroundColor=TFGlobalBg;
    
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TFCommentCell class]) bundle:nil] forCellReuseIdentifier:commentCellId];
    
    //去掉分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //内边距
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 10, 0);
    

}


-(void)setupHeader{
    //设置header
    UIView *header=[[UIView alloc]init];
    
    
    
    //清空top_cmt
    if(self.topic.top_cmt.count){
        self.saved_top_cmt=self.topic.top_cmt;
        self.topic.top_cmt=nil;
        [self.topic setValue:@0 forKey:@"cellH"];
    
    }
    
    
    //设置cell
    TFTopicCell *cell=[TFTopicCell cell];
    cell.topic=self.topic;
    cell.size=CGSizeMake(TFScreenW, self.topic.cellH);
    [header addSubview:cell];
    
    //header的高度
    header.height=cell.height+20;

    //包装一层
    self.tableView.tableHeaderView=header;
    
//    TFTopicCell *cell=[TFTopicCell cell];
//    cell.topic=self.topic;
//    cell.height=self.topic.cellH;
//    self.tableView.tableHeaderView=cell;

}


-(void)setupReresh{
    
    
    self.tableView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];


    [self.tableView.header beginRefreshing];
    
    
    self.tableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
    self.tableView.footer.hidden=YES;

}

-(void)loadNewComment{
    
    //取消之前的所有请求
    [self.manage.tasks makeObjectsPerformSelector:@selector(cancel)];

    
    //设置请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"dataList";
    params[@"c"]=@"comment";
    params[@"data_id"]=self.topic.ID;
    params[@"hot"]=@"1";
    
    //傻逼了啊,没有写服务器的地址
    [self.manage GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *  task, id   responseObject) {
        
        
        //如果返回的是不是字典,说明没有数据
        if(![responseObject isKindOfClass:[NSDictionary class]]){
            
            [self.tableView.header endRefreshing];
            return ;
        }
        
        //最热评论
        self.hotComment=[TFComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
        self.latestComments=[TFComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //页码处理
        self.page=1;
        
        //刷新表格数据
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
        //控制footer的状态
        NSInteger total=[responseObject[@"total"] integerValue];
        if(total<=self.latestComments.count){//全部加载完成
//            [self.tableView.footer noticeNoMoreData];
            self.tableView.footer.hidden=YES;
        
        }else{//没有加载完全部
        
        self.tableView.footer.hidden=NO;
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.header endRefreshing];
    }];
}
/** 加载更多的数据 */
-(void)loadMoreComments{
    
    //取消之前的所有请求
    [self.manage.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //页码
    NSInteger page=self.page+1;
    
    
    //设置请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"a"]=@"dataList";
    params[@"c"]=@"comment";
    params[@"data_id"]=self.topic.ID;
    params[@"page"]=@(page);
    TFComment *cmt=[self.latestComments lastObject];
    params[@"lastcid"]=cmt.ID;
    
    //傻逼了啊,没有写服务器的地址
    [self.manage GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
        
        
        //如果返回的是不是字典,说明没有数据
        if(![responseObject isKindOfClass:[NSDictionary class]]){
        
            [self.tableView.header endRefreshing];
            
            return ;
        }

        //最新评论
        NSArray *newCommet=[TFComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newCommet];
        
        //页码处理
        self.page=page;
        
        //刷新表格数据
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];

        
        //控制footer的状态
        NSInteger total=[responseObject[@"total"] integerValue];
        if(total<=self.latestComments.count){//全部加载完成
            self.tableView.footer.hidden=YES;
        }else{//没有加载完全部
            
            self.tableView.footer.hidden=NO;
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.footer endRefreshing];
    }];




}

-(void)keyboardWillChangeFrame:(NSNotification *)notice{
    
    //键盘frame改变时调用此函数
    CGRect frame=[notice.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    //修改底部的约束
    self.toolBarToBottom.constant = TFScreenH-frame.origin.y;

    //动画的时间
    CGFloat duration=[notice.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    //动画
    [UIView animateWithDuration:duration animations:^{

        [self.view layoutIfNeeded];
    }];


}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //回复帖子的top_cmt
    if(_saved_top_cmt.count){

        self.topic.top_cmt = _saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellH"];
    }


    [self.manage invalidateSessionCancelingTasks:YES];

}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.view endEditing:YES];
    
    
}
/** 返回第section组的所有评论数组 */
-(NSArray *)commentsInSection:(NSInteger)section{

    if(section==0){
        return  self.hotComment.count?self.hotComment:self.latestComments;
    }
    return self.latestComments;
}

//-(TFCommentCell *)commentCellInSection:

#pragma mark - <UITableViewDataSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger hotComments    = self.hotComment.count;
    NSInteger latestComments = self.latestComments.count;

    tableView.footer.hidden=(latestComments==0);

    if(hotComments) return 2;//有最热,最新评论
    if(latestComments) return 1;
    return 0;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    NSInteger hotComments    = self.hotComment.count;
    NSInteger latestComments = self.latestComments.count;
    if(section==0)
        return hotComments?hotComments:latestComments;

    return latestComments;

}


//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    NSInteger hotComments=self.hotComment.count;
//    if(section==0)
//        return hotComments?@"最热评论":@"最新评论";
//
//    return @"最新评论";
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //创建头部
    UIView *header=[[UIView alloc]init];
    header.backgroundColor=TFGlobalBg;
    
    //创建label
    UILabel *label=[[UILabel alloc]init];
    label.backgroundColor  = TFGlobalBg;
    label.textColor        = TFRGBColor(67, 67, 67);
    label.width            = 200;
    label.x                = 20;
    label.font=[UIFont systemFontOfSize:14];
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    NSInteger hotComments  = self.hotComment.count;
    
    //将label加入到头部中
    [header addSubview:label];


    //设置文字
    if(section==0){
        label.text = hotComments?@"最热评论":@"最新评论";
    }else{
        label.text=@"最新评论";

    }
    
    return header;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TFCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:commentCellId];
    
    
    TFComment *comment=[self commentsInSection:indexPath.section][indexPath.row];
    

    cell.comment=comment;

    
    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    

    UIMenuController *menu=[UIMenuController sharedMenuController];

    TFCommentCell *cell=(TFCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell becomeFirstResponder];
    UIMenuItem *ding=[[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem *replay=[[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(replay:)];
    UIMenuItem *repost=[[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(repost:)];
    menu.menuItems=@[ding,replay,repost];
    CGRect rect = CGRectMake(0, cell.height*0.5, cell.width, cell.height*0.5);
    [menu setTargetRect:rect inView:cell];
    [menu setMenuVisible:YES animated:YES];
    
    
    TFLogFunc;
    
}

-(void)ding:(UIMenuItem *)menuItem{
    TFLogFunc;

}
-(void)replay:(UIMenuItem *)menuItem{
    TFLogFunc;
    
}
-(void)repost:(UIMenuItem *)menuItem{
    TFLogFunc;
    
}
-(BOOL)becomeFirstResponder{

    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return NO;
}


@end
