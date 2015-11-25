//
//  LRDQWhereViewController.m
//  LRDQSender
//
//  Created by neuedu on 15/9/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQWhereViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+MoreExtentions.h"
#import "UIView+Extension.h"
#define kLMFont [UIFont systemFontOfSize:15.f ]
#define kMargin 8.f
#import <RDVTabBarController.h>
#import "MBProgressHUD+MoreExtension.h"
@interface LRDQWhereViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LRDQWhereViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL*logonURL=[NSURL URLWithString:@"http://www.kuaidi100.com"];
    NSURLRequest*request=[NSURLRequest requestWithURL:logonURL];
    [_webView loadRequest:request];
    //加载转圈圈
    MBProgressHUD*hud=[MBProgressHUD showHUDAddedTo:self.view LabelText:@"拼命加载中。。。" animated:YES];
    hud.animationType=MBProgressHUDAnimationZoomIn;

    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController]setTabBarHidden:YES animated:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [[self rdv_tabBarController]setTabBarHidden:NO animated:NO];
    
}
//-(void)viewDidDisappear:(BOOL)animated{
//    _webView.delegate = nil;
//    [_webView loadHTMLString:@"" baseURL:nil];
//    [_webView stopLoading];
//    [_webView removeFromSuperview];
//    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    [_webView removeFromSuperview];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
