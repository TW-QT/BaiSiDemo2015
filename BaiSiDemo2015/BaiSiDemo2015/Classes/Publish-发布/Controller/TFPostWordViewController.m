//
//  TFPostWordViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/9.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFPostWordViewController.h"
#import "TFPlaceholdTextView.h"

@interface TFPostWordViewController ()

@end

@implementation TFPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"发表文字";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancle)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
    
    
    [self setupTextView];
    
    
}
-(void)setupTextView{
    
    TFPlaceholdTextView *textView=[[TFPlaceholdTextView alloc]init];
    textView.frame=self.view.bounds;
    [self.view addSubview:textView];

}

-(void)cancle{

    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)post{

    TFLogFunc;
}


@end
