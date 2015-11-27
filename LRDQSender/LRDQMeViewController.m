//
//  LRDQMeViewController.m
//  LRDQSender
//
//  Created by neuedu on 15/9/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQMeViewController.h"
#import "LRDQWhereViewController.h"
#import "LRDQAboutSoftViewController.h"
#import "LRDQCheckFreshViewController.h"
#import "LRDQLogonViewController.h"
#import <RDVTabBarController.h>
#import <FlatUIKit.h>
#import "LRDQTBController.h"
#import <Parse/Parse.h>
#import "PFUserTool.h"
#define kCommentH 44.f
#define kMargin 10.f
#define HeightRatio 240.f/667.f
#define margin 35.f

@interface LRDQMeViewController ()

@end

@implementation LRDQMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    
    UIView * view =[[UIView alloc]init];
    [self.view addSubview:view];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:103.f/255.f green:210.f/255.f blue:243.f/255.f alpha:1];
    
    [self addSubviews];
}
-(void)viewWillDisappear:(BOOL)animated{
    LRDQTBController*tabarvc=[LRDQTBController TBController];
    [tabarvc setHidesBottomBarWhenPushed:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)addSubviews{
    UIImageView*backgroundView=[[UIImageView alloc]init];
    backgroundView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HeightRatio*[UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:backgroundView];
    [backgroundView setImage:[UIImage imageNamed:@"back"]];
    
    UIImageView*icon=[[UIImageView alloc]init];
    [backgroundView addSubview:icon];
    [icon setImage:[UIImage imageNamed:@"lan"]];
    icon.center=CGPointMake(backgroundView.center.x, backgroundView.center.y+25.f);
    icon.bounds=CGRectMake(0, 0, 60.f, 60.f);
    
    UILabel*telnum=[[UILabel alloc]init];
    telnum.frame=CGRectMake(0, CGRectGetMaxY(icon.frame), [UIScreen mainScreen].bounds.size.width, 44.f);
    telnum.text=[PFUserTool sharedUser].userName;
    telnum.textAlignment=NSTextAlignmentCenter;
    [backgroundView addSubview:telnum];
    
    FUIButton * myMessage = [[FUIButton alloc]init];
    myMessage.buttonColor = [UIColor peterRiverColor];
    myMessage.shadowColor = [UIColor belizeHoleColor];
    myMessage.shadowHeight = 5.0f;
    myMessage.cornerRadius = 6.0f;
    myMessage.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [myMessage setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [myMessage setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    myMessage.frame = CGRectMake(kMargin, HeightRatio*[UIScreen mainScreen].bounds.size.height+2.f, [UIScreen mainScreen].bounds.size.width-kMargin*2, kCommentH);
    [myMessage setTitle:@"订单信息" forState:UIControlStateNormal];
    [self.view addSubview:myMessage];
    [myMessage addTarget:self action:@selector(MymessageClick) forControlEvents:UIControlEventTouchUpInside];
    

    FUIButton * whereThings = [[FUIButton alloc]init];
    whereThings.frame =CGRectMake(kMargin, CGRectGetMaxY(myMessage.frame)+kMargin,myMessage.frame.size.width, kCommentH);
    [whereThings setTitle:@"查询物流" forState:UIControlStateNormal];
    whereThings.buttonColor = [UIColor concreteColor];
    whereThings.shadowColor = [UIColor asbestosColor];
    whereThings.shadowHeight = 5.0f;
    whereThings.cornerRadius = 6.0f;
    whereThings.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [whereThings setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [whereThings setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.view addSubview:whereThings];
    [whereThings addTarget:self action:@selector(WhereThingsClick) forControlEvents:UIControlEventTouchUpInside];

    FUIButton * aboutSoft = [[FUIButton alloc]init];
    aboutSoft.frame = CGRectMake(kMargin, CGRectGetMaxY(whereThings.frame)+kMargin, myMessage.frame.size.width, kCommentH);
    aboutSoft.buttonColor = [UIColor turquoiseColor];
    aboutSoft.shadowColor = [UIColor greenSeaColor];
    aboutSoft.shadowHeight = 5.0f;
    aboutSoft.cornerRadius = 6.0f;
    aboutSoft.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [aboutSoft setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [aboutSoft setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [aboutSoft setTitle:@"关于软件" forState:UIControlStateNormal];
        [self.view addSubview:aboutSoft];
    [aboutSoft addTarget:self action:@selector(AboutsoftClick) forControlEvents:UIControlEventTouchUpInside];
    
    FUIButton * exit = [[FUIButton alloc]init];
    exit.frame = CGRectMake(kMargin, CGRectGetMaxY(aboutSoft.frame)+kMargin, myMessage.frame.size.width, kCommentH);
    exit.buttonColor = [UIColor wetAsphaltColor];
    exit.shadowColor = [UIColor midnightBlueColor];
    exit.shadowHeight = 5.0f;
    exit.cornerRadius = 6.0f;
    exit.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [exit setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [exit setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [exit setTitle:@"切换账号" forState:UIControlStateNormal];
    [self.view addSubview:exit];
    [exit addTarget:self action:@selector(exitClick) forControlEvents:UIControlEventTouchUpInside];


}
//我的信息
-(void)MymessageClick{
    [self performSegueWithIdentifier:@"toMymessage" sender:nil];
}
//查询物流
-(void)WhereThingsClick{
    [self performSegueWithIdentifier:@"toWhere" sender:nil];
}
-(void)AboutsoftClick{
    [self performSegueWithIdentifier:@"toSoft" sender:nil];
}

//退出登录
-(void)exitClick{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"LRDQLogonStoryBoard" bundle:nil];
    LRDQLogonViewController * logonVC = [storyboard instantiateViewControllerWithIdentifier:@"LogonID"];
    [self.navigationController presentViewController:logonVC animated:YES completion:^{
        
    }];
    [PFUser logOut];  
}
@end
