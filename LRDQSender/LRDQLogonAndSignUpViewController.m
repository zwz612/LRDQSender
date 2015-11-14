//
//  LRDQLogonAndSignUpViewController.m
//  LRDQSender
//
//  Created by neuedu on 15/9/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQLogonAndSignUpViewController.h"
#import "LRDQTableViewController.h"
#import "LRDQLogonViewController.h"
#import <RDVTabBarItem.h>
#import <RDVTabBarController.h>



@interface LRDQLogonAndSignUpViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage1;
- (IBAction)logon:(UIButton *)sender;
- (IBAction)signUp:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *logon;
@property (weak, nonatomic) IBOutlet UIButton *signUp;

@end

@implementation LRDQLogonAndSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _logon.layer.cornerRadius=10.f;
    _signUp.layer.cornerRadius=10.f;
}
-(BOOL)prefersStatusBarHidden{
    
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=NO;
}

- (IBAction)logon:(UIButton *)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"LRDQLogonStoryBoard" bundle:nil];
    
    LRDQLogonViewController*logonVC=[storyboard instantiateViewControllerWithIdentifier:@"LogonID"];
    ;
    [self.navigationController pushViewController:logonVC animated:YES];
//    [self.navigationController presentViewController:logonVC animated:NO completion:^{
//        
//    }];
}

- (IBAction)signUp:(UIButton *)sender {
    
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"LRDQSIgnUpStoryBoard" bundle:nil];
    LRDQTableViewController*homeVC=[storyboard instantiateViewControllerWithIdentifier:@"SIgnUpID"];
    
    [self.navigationController pushViewController :homeVC animated:YES];
}
@end
