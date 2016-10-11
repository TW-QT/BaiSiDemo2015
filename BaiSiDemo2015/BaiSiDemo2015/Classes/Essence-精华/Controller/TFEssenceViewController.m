//
//  TFEssenceViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/5/28.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFEssenceViewController.h"
#import "TFRecommendTagsViewController.h"
#import "TFTopicViewController.h"

@interface TFEssenceViewController ()<UIScrollViewDelegate>

/** 标签栏底部的红色指示器 */
@property (nonatomic,weak) UIView *indicatorView;

/** 当前选中的按钮 */
@property (nonatomic,strong) UIButton *selectedButton;

/** 底部的所有内容,contentView */
@property (nonatomic,weak) UIScrollView *contentView;

/** 顶部的标签栏,titleView */
@property (nonatomic,weak) UIView *titleView;

@end

@implementation TFEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
    
    //初始化子控制器
    [self setupChildVces];
    
    
    //设置顶部的标签栏
    [self setupTitlesView];
    
    //设置底部的scrollView
    [self setupContentScrollView];
    
    
}


-(void)setupNav{
    
    //设置导航栏的标题
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //统一设置精华控制器view的背景色
    self.view.backgroundColor=TFGlobalBg;


}


-(void)setupTitlesView{
    
//    TFLogFunc;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    //标签栏整体
    UIView *titlesView=[[UIView alloc]init];
    titlesView.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    titlesView.width=self.view.width;
    titlesView.height=TFtitlesViewH;
    titlesView.y=TFtitlesViewY;
    [self.view addSubview:titlesView];
    self.titleView=titlesView;
    
    
    
    //底部的红色指示器
    UIView *indicatorView=[[UIView alloc]init];
    indicatorView.backgroundColor=[UIColor redColor];
    indicatorView.height=2;
    indicatorView.tag=-1;
    indicatorView.y=titlesView.height-indicatorView.height;
    [titlesView addSubview:indicatorView];
    self.indicatorView=indicatorView;
    
    //内部子标签栏
    NSInteger count=self.childViewControllers.count;
    CGFloat width=titlesView.width/count;
    CGFloat height=titlesView.height;
    for(int i=0;i<count;i++){
        UIButton *button=[[UIButton alloc]init];
        button.tag=i;
        button.height=height;
        button.width=width;
        button.x=i*width;
        button.titleLabel.font=[UIFont systemFontOfSize:14];
        UIViewController *vc=self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button layoutIfNeeded];//对按钮强制布局//[button sizeToFit];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        //默认点击了第一个按钮
        if(i==0){
        //[self titleClick:button];
            button.enabled=NO;
            self.selectedButton=button;
            self.indicatorView.width=button.titleLabel.width;
            self.indicatorView.centerX=button.centerX;
        }
    }
    [titlesView addSubview:indicatorView];
}

-(void)setupContentScrollView{
    
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UIScrollView *contentView=[[UIScrollView alloc]init];
    contentView.frame=self.view.bounds;
    contentView.delegate=self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize=CGSizeMake(contentView.width*self.childViewControllers.count, 0);
    self.contentView=contentView;

//    TFLogFunc;
    // 添加第一个控制器的view
    [self scrollViewDidEndDecelerating:contentView];
}

/**
 *初始化子控制器
 */
-(void)setupChildVces{
    
    TFTopicViewController *all=[[TFTopicViewController alloc]init];
    //    //此处是bug
    //    all.view.backgroundColor=TFGlobalBg;
    all.title=@"全部";
    all.type=TFTopicTypeAll;
    [self addChildViewController:all];
    
    TFTopicViewController *voice=[[TFTopicViewController alloc]init];
//    //此处是bug
//    voice.view.backgroundColor=TFGlobalBg;
    voice.title=@"声音";
    voice.type=TFTopicTypeVoice;
    [self addChildViewController:voice];
    
    TFTopicViewController *word=[[TFTopicViewController alloc]init];
//    //此处是bug
//    word.view.backgroundColor=TFGlobalBg;
    word.title=@"段子";
    word.type=TFTopicTypeWord;
    [self addChildViewController:word];
    
  
    
    TFTopicViewController *video=[[TFTopicViewController alloc]init];
//    //此处是bug
//    video.view.backgroundColor=TFGlobalBg;
    video.title=@"视频";
    video.type=TFTopicTypeVideo;
    [self addChildViewController:video];
    
    
    
    TFTopicViewController *picture=[[TFTopicViewController alloc]init];
//    //此处是bug
//    picture.view.backgroundColor=TFGlobalBg;
    picture.title=@"图片";
    picture.type=TFTopicTypePicture;
    [self addChildViewController:picture];
    
    
    
    

//    TFLogFunc;

}

-(void)titleClick:(UIButton *)button{
    
    //修改按钮状态
    self.selectedButton.enabled=YES;
    button.enabled =NO;
    self.selectedButton=button;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width=button.titleLabel.width;
        self.indicatorView.centerX=button.centerX;
    }];
    
    
    //滚动,切换子控制器
    CGPoint offset=self.contentView.contentOffset;
    offset.x=button.tag*self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
//    TFLogFunc;
}


-(void)tagClick{
//    TFLogFunc;
    TFRecommendTagsViewController *tags=[[TFRecommendTagsViewController alloc]init];
    
    [self.navigationController pushViewController:tags animated:YES];
}


#pragma mark -<UIScrollViewDelegate>

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //当前的索引
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    
    //取出子控制器
    TFTopicViewController *vc=self.childViewControllers[index];
    

    //修复bug
    [vc loadNewTopics];
    vc.view.backgroundColor=TFGlobalBg;
    
    
    vc.view.x=scrollView.contentOffset.x;
    vc.view.y=0;
    vc.view.height=scrollView.height;
    
    
    //添加子控制器的view
    [scrollView addSubview:vc.view];
    
//    TFLogFunc;
    
    
    

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
//    TFLogFunc;
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titleView.subviews[index]];
    
}


@end
