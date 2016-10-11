//
//  TFPublishViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/3.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFPublishViewController.h"
#import "TFVerticalButton.h"
#import "TFPostWordViewController.h"
#import "TFNavgationController.h"
//#import "POP.h"
//#import "POPSpringAnimation.h"
@interface TFPublishViewController ()


@end

@implementation TFPublishViewController

/**取消发布**/
- (IBAction)cancelClick:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //添加标语
    UIImageView *sloganView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    sloganView.y=TFScreenH*0.2;
    sloganView.centerX=TFScreenW*0.5;
    
    
    //添加中间的6个按钮
    int maxCols=3;
    CGFloat buttonW=72;
    CGFloat buttonH=buttonW+30;
    CGFloat buttonStartX=(TFScreenW-maxCols*buttonW)/(maxCols+1);
    CGFloat buttonStartY=(TFScreenH-2*buttonH)/2.0;
    
    
    
    
    //数据
    NSArray *images=@[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles=@[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    
    for (int i=0;i<images.count;i++){
        TFVerticalButton *button=[[TFVerticalButton alloc]init];
        
        //设置内容
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i;
        
        //设置frame
        button.width=buttonW;
        button.height=buttonH;
        int row=i/maxCols;
        int col=i%maxCols;
        button.x=buttonStartX+col*(buttonW+buttonStartX);
        button.y=buttonStartY+row*buttonH;
        
        //设置动画
//        POPSpringAnimation *animation=[POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        
        
        [self.view addSubview:button];
    }
}

-(void)buttonClick:(TFVerticalButton *)button{

    if(button.tag==2){
        //发段子
        TFLog(@"%@",button.titleLabel.text);
        UIViewController *root=[UIApplication sharedApplication].keyWindow.rootViewController;
        
        TFPostWordViewController *postWord=[[TFPostWordViewController alloc]init];
        postWord.view.backgroundColor=TFGlobalBg;
        TFNavgationController *nav=[[TFNavgationController alloc]initWithRootViewController:postWord];
        
        
        [self dismissViewControllerAnimated:NO completion:nil];
        [root presentViewController:nav animated:YES completion:nil];
        
    
    
    }

    
}
@end
