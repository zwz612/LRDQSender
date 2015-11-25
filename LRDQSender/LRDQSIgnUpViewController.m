//
//  LRDQSIgnUpViewController.m
//  LRDQSender
//
//  Created by neuedu on 15/9/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQSIgnUpViewController.h"
#import "LRDQLogonAndSignUpViewController.h"
#import <RDVTabBarController.h>
#import <RDVTabBarItem.h>
#import "LRDQTableViewController.h"
#import <Parse/Parse.h>
#import "LRDQLogonViewController.h"
#import "NSString+MoreExtentions.h"
#import <RDVTabBarItem.h>
#import <RDVTabBarController.h>
#import "LRDQTBController.h"
#import "LRDQwelViewController.h"
#import "VersionSingletonTool.h"
#import "PFUserTool.h"
@interface LRDQSIgnUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *telNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPassword;
@property (weak, nonatomic) IBOutlet UIButton *signUp;

@end

@implementation LRDQSIgnUpViewController
- (IBAction)signUp:(UIButton *)sender {
    
    
    dispatch_queue_t asynQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(asynQueue, ^{
        //增加Tarbar
        LRDQTBController*tabarVC=[LRDQTBController TBController];

        //创建新的线程
        //网络注册
        if (![_telNumTextField.text validatePhoneNumber]) {
            UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"输入的不是手机号" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            if ([_againPassword.text isEqualToString: _passwordTextField.text]&&_againPassword.text.length == _passwordTextField.text.length){
                
                PFUser * user = [PFUser user];
                user.username = self.telNumTextField.text;
                [PFUserTool sharedUser].userName=user.username;
                user.password = self.passwordTextField.text;
               
                [user signUpInBackgroundWithBlock:^(BOOL succeeded,NSError * error){
                    PFObject * LRDQMessage = [PFObject objectWithClassName:@"LRDQMessages"];

                    if (!error){
                        
                        [LRDQMessage setObject:self.nameTextField.text forKey:@"name"];
                        [LRDQMessage setObject:[PFUser currentUser].username forKey:@"telNum"];
                        
                        [UIApplication sharedApplication].keyWindow.rootViewController = tabarVC.TBController;
                        [self dismissViewControllerAnimated:YES completion:^{
                            
                        }];
                        
                        
                        
                    }else{
                        NSString * errorString = [[ error userInfo]objectForKey:@"error"];
                        UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"error" message:errorString delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                }];
            }else{
                UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不一致" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
    });
}
-(void)viewWillDisappear:(BOOL)animated{
 self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"注册界面";
    _signUp.layer.cornerRadius=10.f;
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:103.f/255.f green:210.f/255.f blue:243.f/255.f alpha:1];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_nameTextField endEditing:YES];
    [_telNumTextField endEditing:YES];
    [_passwordTextField endEditing:YES];
    [_againPassword endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
