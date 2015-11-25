//
//  LRDQWhereViewController.h
//  LRDQSender
//
//  Created by neuedu on 15/9/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRDQWhereViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *myThingsLable;
@property (weak, nonatomic) IBOutlet UILabel *personLable;
@property (weak, nonatomic) IBOutlet UILabel *whereLable;
@property (weak, nonatomic) IBOutlet UILabel *telNubLable;
@property (weak, nonatomic) IBOutlet UILabel *leaveMessageLable;
@property (weak, nonatomic) IBOutlet UITextField *myThings;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *thingsPlace;
@property (weak, nonatomic) IBOutlet UITextField *telNum;
@property (weak, nonatomic) IBOutlet UITextView *leaveMessage;


@end
