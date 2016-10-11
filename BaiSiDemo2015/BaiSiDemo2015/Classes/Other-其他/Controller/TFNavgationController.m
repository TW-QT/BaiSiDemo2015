//
//  TFNavgationController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/29.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFNavgationController.h"

@interface TFNavgationController ()

@end

@implementation TFNavgationController



+(void)initialize{
    //设置导航控制器的背景图片,appearance
    //UINavigationBar *bar=[UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


/**
 *在这个方法中拦截所有push进来的控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    
    
    //如果push的子控制器>1,此时设置左边的item
    if(self.childViewControllers.count>0){
    
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button sizeToFit];//按钮的尺寸跟虽按钮的内容变化
        
        //设置内容向左偏移,这样看起来更加美观,没有了之前很大的间距
        button.contentEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
        //让按钮中的所有内容左对齐
        button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
        //隐藏tabBar,在push的时候,不要写在if外面
        viewController.hidesBottomBarWhenPushed=YES;
    
    }
    //这句的push放在后面,让viewController可以覆盖上面的设置
    [super pushViewController:viewController animated:animated];

}



-(void)back{

    [self popViewControllerAnimated:YES];

}
@end
