//
//  TFMeFooterView.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/8.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFMeFooterView.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UIButton+WebCache.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "TFSquare.h"
#import "TFVerticalButton.h"
#import "TFSquareButton.h"
#import "TFWebViewController.h"

@implementation TFMeFooterView



-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self=[super initWithFrame:frame]){
        
        
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        params[@"a"]=@"square";
        params[@"c"]=@"topic";

    
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
            
            NSArray *squares=[TFSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            //创建方块
            [self creatSquare:squares];
            
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
         
            //提示失败
            [SVProgressHUD showErrorWithStatus:@"加载最新的数据失败"];
          
        }];
    
    
    }



    return self;

}




-(void)creatSquare:(NSArray *)squares{

    //一行最多四列
    int maxCols=6;
    //高度与宽度
    CGFloat buttonW=TFScreenW/maxCols;
    CGFloat buttonH= buttonW+30;
    
    
    //出去重复的按钮
    NSMutableArray *arry=[NSMutableArray array];
    [arry addObject:squares[0]];
    
    for(int i=0;i<squares.count;i++){
        for(int j=0;j<arry.count;j++){
            if([arry[j] name]==[squares[i] name])
                break;
            if(j==arry.count-1){
                [arry addObject:squares[i]];
            }
        }
    }
    
    
    for(int i=0;i<arry.count;i++){
        
       
        
        //创建按钮并给按钮模型数据
        TFSquareButton *button=[TFSquareButton buttonWithType:UIButtonTypeCustom];
        button.square=arry[i];
        
        //监听按钮的点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        //将按钮加入到父控件中
        [self addSubview:button];
        
        //计算按钮的frame
        int col=i%maxCols;
        int row=i/maxCols;
        
        button.x=buttonW*col;
        button.y=buttonH*row;
        button.width=buttonW;
        button.height=buttonH;
    
        
        TFLog(@"%zd~~~~~%@",i,button.square.name);
    }
    
    
    //计算整个footer的高度
//    NSInteger rowss=(squares.count+maxCols-1)/maxCols;
//    TFLog(@"%zd",rowss);
    NSInteger rows=squares.count/maxCols;
    if(squares.count%maxCols) rows++;
    self.height=buttonH*rows;

    [self setNeedsDisplay];




}


-(void)buttonClick:(TFSquareButton *)button{


    TFWebViewController *web=[[TFWebViewController alloc]init];
    web.url=button.square.url;
    web.title=button.square.name;
    
    
    //取出当前的导航控制器
    UITabBarController *tabBarVc=[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navVc=(UINavigationController *)tabBarVc.selectedViewController;
    [navVc pushViewController:web animated:YES];
    
    


}





//设置背景图片
-(void)drawRect:(CGRect)rect{


    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
    


}


@end
