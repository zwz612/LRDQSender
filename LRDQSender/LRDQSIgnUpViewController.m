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
#import <SMS_SDK/SMSSDK.h>
@interface LRDQSIgnUpViewController ()
{
    NSTimer* _timer1;
    NSTimer* _timer2;
    
}



@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *telNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *againPassword;
@property(nonatomic,strong)  UILabel* timeLabel;
@property(nonatomic,strong)  UIButton* repeatSMSBtn;

- (IBAction)signUp:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *signUp;
@property (weak, nonatomic) IBOutlet UIButton *getCode;
- (IBAction)getCode:(UIButton *)sender;

@end
@implementation LRDQSIgnUpViewController
- (IBAction)signUp:(UIButton *)sender {
    

        //网络注册
        if (![_telNumTextField.text validatePhoneNumber]||_telNumTextField.text.length==0||_codeTextField.text.length!=4||_passwordTextField.text.length==0||_againPassword.text.length==0) {
            UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"输入信息有误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            if ([_againPassword.text isEqualToString: _passwordTextField.text]&&_againPassword.text.length == _passwordTextField.text.length){
                
                [SMSSDK commitVerificationCode:_codeTextField.text phoneNumber:_telNumTextField.text zone:@"86" result:^(NSError *error) {
                    if (error)
                    {UIAlertView* alert1 =[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"验证界面", nil)message:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"commitVerificationCode"]]
                delegate:self cancelButtonTitle:NSLocalizedString(@"确认", nil)
                otherButtonTitles:nil, nil];
                        [alert1 show];
                        
                    }
                    else{
                        PFUser * user = [PFUser user];
                        user.username = self.telNumTextField.text;
                        [PFUserTool sharedUser].userName=user.username;
                        user.password = self.passwordTextField.text;
                        
                        [user signUpInBackgroundWithBlock:^(BOOL succeeded,NSError * error){
                            PFObject * LRDQMessage = [PFObject objectWithClassName:@"LRDQMessages"];
                            
                            if (!error){
                                
                                [LRDQMessage setObject:[PFUser currentUser].username forKey:@"telNum"];
                                UIStoryboard*stord=[UIStoryboard storyboardWithName:@"LRDQLogonStoryBoard" bundle:nil];
                                LRDQLogonViewController*logonVC=[stord instantiateViewControllerWithIdentifier:@"LogonID"];
                                [UIApplication sharedApplication].keyWindow.rootViewController =logonVC ;
                                //                        [self dismissViewControllerAnimated:YES completion:^{
                                //
                                //                        }];
                            }else{
                                NSString * errorString = [[ error userInfo]objectForKey:@"error"];
                                UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"error" message:errorString delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                                [alertView show];
                            }
                        }];
                    }
                    
                }];
                
            }else{
                UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码不一致" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"注册界面";
    _signUp.layer.cornerRadius=10.f;
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:103.f/255.f green:210.f/255.f blue:243.f/255.f alpha:1];
 
    count=0;
    
}
static int count=0;
-(void)updateTime
{
    count++;
    if (count >= 60)
    {   _getCode.enabled=YES;
        count=0;
        [_timer2 invalidate];
        [_getCode setTitle:@"获取验证码" forState:UIControlStateNormal];

        return;
    }
    NSString*string=[NSString stringWithFormat:@"剩余%d秒",60-count];
    [_getCode setTitle:string forState:UIControlStateNormal];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_telNumTextField endEditing:YES];
    [_codeTextField endEditing:YES];
    [_passwordTextField endEditing:YES];
    [_againPassword endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)getCode:(UIButton *)sender {
    if (![_telNumTextField.text validatePhoneNumber]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"您的手机号输入不正确，请重新输入" delegate:self cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil];
        [alert show];

    }
    else{
    
    NSString* str = [NSString stringWithFormat:@"将发送验证码到:%@ ",_telNumTextField.text];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:str delegate:self cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确认", nil];
    [alert show];
    
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex){
        NSTimer* timer2 = [NSTimer scheduledTimerWithTimeInterval:1
                                                           target:self
                                                         selector:@selector(updateTime)
                                                         userInfo:nil
                                                          repeats:YES];
        
        _timer2 = timer2;
        _getCode.enabled=NO;
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_telNumTextField.text zone:@"86"customIdentifier:nil
                                     result:^(NSError *error)
         {
             if (!error)
             {
                 
                 NSLog(@"验证码发送成功");
                 
             }
             else
             {
                 UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                                 message:[NSString stringWithFormat:@"错误描述：%@",[error.userInfo objectForKey:@"getVerificationCode"]]
                                                                delegate:self cancelButtonTitle:NSLocalizedString(@"确认", nil)otherButtonTitles:nil, nil];
                 [alert show];
             }
             
         }];
        
    }
}
@end

