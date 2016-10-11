//
//  TFWebViewController.m
//  101-百思不得姐
//
//  Created by 陶飞 on 15/6/9.
//  Copyright © 2015年 taofei. All rights reserved.
//

#import "TFWebViewController.h"
#import "NJKWebViewProgress.h"

@interface TFWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
/** 进度代理对象 */
@property (nonatomic,strong) NJKWebViewProgress  *progressDelegate;
@end

@implementation TFWebViewController
- (IBAction)refresh:(id)sender {
    
    [self.webView reload];
}
- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressDelegate=[[NJKWebViewProgress alloc]init];
    self.webView.delegate=self.progressDelegate;
    __weak typeof(self) weakSelf=self;
    self.progressDelegate.progressBlock=^(float progress){
        TFLog(@"%f",progress);
        weakSelf.progressView.progress=progress;
        weakSelf.progressView.hidden=(progress==1.0);
    
    };
    self.progressDelegate.webViewProxyDelegate=self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}



#pragma mark -<UIWebViewDelegate>
/**
 *监听webView加载完成后要进行的处理
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.goBackItem.enabled=self.webView.canGoBack;
    self.goForwardItem.enabled=self.webView.canGoForward;



}

@end
