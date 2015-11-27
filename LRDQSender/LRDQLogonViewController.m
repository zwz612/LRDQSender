//
//  LRDQLogonViewController.m
//  LRDQSender
//
//  Created by neuedu on 15/9/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQLogonViewController.h"
#import "LRDQTableViewController.h"
#import "LRDQLogonAndSignUpViewController.h"
#import <RDVTabBarItem.h>
#import <RDVTabBarController.h>
#import <Parse/Parse.h>
#import "LRDQTBController.h"
#import "FlatUIKit.h"
#import "CoreDataMngTool.h"
#import "PFUserTool.h"
#import "MBProgressHUD+MoreExtension.h"
@interface LRDQLogonViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logon;
@property (weak, nonatomic) IBOutlet UILabel *tel;
@property (weak, nonatomic) IBOutlet UILabel *password;
@property (weak, nonatomic) IBOutlet UITextField *telnumber;
@property (weak, nonatomic) IBOutlet UITextField *passwordCount;
- (IBAction)logon:(UIButton *)sender;
- (IBAction)back:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *remember;
@property (weak, nonatomic) FUISwitch *onSwitch;

@property(strong,nonatomic)NSMutableArray * lists;

@end

@implementation LRDQLogonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    _logon.layer.cornerRadius=10.f;
    NSString* filepath = [docPath stringByAppendingPathComponent:@"userinfo.plist"];
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:filepath];
    _telnumber.text = [dict objectForKey:@"tel"];
    _passwordCount.text = [dict objectForKey:@"password"];
    
    [self addSwitchButton];
    
}
#pragma 添加switch按钮
-(void)addSwitchButton{
    
    FUISwitch*onSwitch=[[FUISwitch alloc]init];
    _onSwitch=onSwitch;
    onSwitch.onColor = [UIColor turquoiseColor];
    onSwitch.offColor = [UIColor cloudsColor];
    onSwitch.onBackgroundColor = [UIColor midnightBlueColor];
    onSwitch.offBackgroundColor = [UIColor silverColor];
    onSwitch.offLabel.font = [UIFont boldFlatFontOfSize:14];
    onSwitch.onLabel.font = [UIFont boldFlatFontOfSize:14];
    onSwitch.frame=CGRectMake(_remember.right+10.f, _remember.top, 60.f, 30.f);
    [self.view addSubview:onSwitch];
    [onSwitch addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchDown];
    NSNumber* passOn = [[NSUserDefaults standardUserDefaults] objectForKey:@"passOnKey"];
    [onSwitch setOn:[passOn boolValue]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_telnumber endEditing:YES];
    [_passwordCount endEditing:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [_telnumber endEditing:YES];
    [_passwordCount endEditing:YES];
    self.navigationController.navigationBar.hidden=NO;
    
}
- (IBAction)logon:(UIButton *)sender {
    MBProgressHUD*hud=[MBProgressHUD showHUDAddedTo:self.view LabelText:@"拼命加载中。。。" animated:YES];
    hud.animationType=MBProgressHUDAnimationZoomIn;

        
    dispatch_queue_t asynQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(asynQueue, ^{
         LRDQTBController*tabarVC=[LRDQTBController TBController];
        //创建新的线程
        if (_telnumber.text.length !=0 && _passwordCount.text.length != 0) {
            
            [PFUserTool sharedUser].userName=_telnumber.text;
#pragma Mark 记住每次登录的账号密码
            if (_onSwitch.isOn) {
                //记住用户名密码
                NSDictionary* dict = @{@"tel": _telnumber.text,
                                       @"password": _passwordCount.text};
                NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                NSString* filepath = [docPath stringByAppendingPathComponent:@"userinfo.plist"];
                [CoreDataMngTool shareCoreDatamngTool].curTel = _telnumber.text;//1109
                [dict writeToFile:filepath atomically:YES];
                
            }else{
                NSDictionary* dict = @{@"tel": @"",
                                       @"password": @""};
                NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                NSString* filepath = [docPath stringByAppendingPathComponent:@"userinfo.plist"];
                [dict writeToFile:filepath atomically:YES];
            }
            
        }
        
        //网络账号登录
        [PFUser logInWithUsernameInBackground:self.telnumber.text password:self.passwordCount.text block:^(PFUser *user,NSError * error){
            if (user) {
                [UIApplication sharedApplication].keyWindow.rootViewController = tabarVC.TBController;
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }else{
                NSString * errorString = [[ error userInfo]objectForKey:@"error"];
                UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"error" message:errorString delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alertView show];
                hud.hidden = YES;
            }
        }];

    });
}
- (IBAction)back:(UIButton*)sender{
    UIStoryboard*stord=[UIStoryboard storyboardWithName:@"LRDQLogonAndSignUpStoryBoard" bundle:nil];
    LRDQLogonAndSignUpViewController*vc=[stord instantiateViewControllerWithIdentifier:@"LogonAndSIgnUPID"];
    
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:vc];
    [UIApplication sharedApplication].keyWindow.rootViewController
    =nav;
}
#pragma switch按钮的响应函数
- (void)switchClick:(UISwitch *)sender {
    //纪录按钮的选中状态 使用偏好进行保存
    NSUserDefaults* deafult = [NSUserDefaults standardUserDefaults];
    [deafult setObject:[NSNumber numberWithBool:!sender.isOn]forKey:@"passOnKey"];
    [deafult synchronize];
    if (!sender.isOn) {
        NSDictionary* dict = @{@"tel": @"",
                               @"password": @""};
        NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString* filepath = [docPath stringByAppendingPathComponent:@"userinfo.plist"];
        [dict writeToFile:filepath atomically:YES];
    }else{
        //记住用户名密码
        NSDictionary* dict = @{@"tel": _telnumber.text,
                               @"password": _passwordCount.text};
        NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString* filepath = [docPath stringByAppendingPathComponent:@"userinfo.plist"];
        [dict writeToFile:filepath atomically:YES];
    }
}

@end
