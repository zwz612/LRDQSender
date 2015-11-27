//
//  LRDQAboutSoftViewController.m
//  LRDQSender
//
//  Created by neuedu on 15/9/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQAboutSoftViewController.h"
#import "RDVTabBarController.h"
@interface LRDQAboutSoftViewController ()

@end

@implementation LRDQAboutSoftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [[self rdv_tabBarController]setTabBarHidden:YES animated:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [[self rdv_tabBarController]setTabBarHidden:NO animated:YES];
    
}
@end
