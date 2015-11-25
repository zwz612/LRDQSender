//
//  LRDQMymessageViewController.h
//  LRDQSender
//
//  Created by neuedu on 15/11/4.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRDQMymessageTableViewCell.h"
@interface LRDQMymessageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,LRDQMymessageTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)Mysendbtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *MysendList;

@property (weak, nonatomic) IBOutlet UIButton *MycatchList;
- (IBAction)Mycatchbtn:(UIButton *)sender;

@end
