//
//  TFLoginRegisteViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/31.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFLoginRegisteViewController.h"

@interface TFLoginRegisteViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation TFLoginRegisteViewController


/**
 *返回
 */
- (IBAction)back:(id)sender {
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
}





/**
 *点击注册账号按钮,或者登陆按钮
 */
- (IBAction)showLoginOrRegist:(UIButton *)button {
    //退出键盘
    [self.view endEditing:YES];
    
    
    if(self.loginViewLeftMargin.constant==0){
        self.loginViewLeftMargin.constant-=self.view.width;
        [button setTitle:@"已有账号?" forState:UIControlStateNormal];
    }else{
        self.loginViewLeftMargin.constant+=self.view.width;
        [button setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    
    [self.view insertSubview:self.bgImageView atIndex:0];
    
    //设置登录按钮的圆角
    self.loginButton.layer.cornerRadius=5;
    self.loginButton.layer.masksToBounds=YES;
    
    
    //NSAttributedString带有属性的文字:富文本
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
    
    NSMutableAttributedString *placeholder=[[NSMutableAttributedString alloc]initWithString:@"手机号" attributes:attrs];
    
    self.phoneTextField.attributedPlaceholder=placeholder;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 *设置状态栏的颜色
 */
//-(UIStatusBarStyle)preferredStatusBarStyle{
//
//    return UIStatusBarStyleLightContent;
//}


@end
