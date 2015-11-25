
//
//  LRDQMymessageViewController.m
//  LRDQSender
//
//  Created by neuedu on 15/11/4.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQMymessageViewController.h"
#import "LRDQMymessageTableViewCell.h"
#import "CoreDataMngTool.h"
#import "LRDQHomeMsgFrameModel.h"
#import "LRDQHomeTableViewCell.h"
#import "RDVTabBarController.h"
#import <Parse/Parse.h>

#import "LRDQGetWebList.h"


typedef enum{
    eMysendLister = 0,
    eMycatchLister,
    
}eMymessage;
@interface LRDQMymessageViewController ()
@property(strong,nonatomic)NSMutableArray*lists;
@property (assign, nonatomic) eMymessage eMymessageSel;
@property(strong ,nonatomic)NSArray * cellContents;

@end

@implementation LRDQMymessageViewController
-(NSMutableArray *)lists
{
    if (_lists==nil) {
        _lists=[NSMutableArray array];
        switch (_eMymessageSel) {
            case eMysendLister:{
               _cellContents=[CoreDataMngTool shareCoreDatamngTool].msgList;//1109
            
            }break;
            case eMycatchLister:{
                _cellContents=[CoreDataMngTool shareCoreDatamngTool].catchMsg;
            }break;
            default:
                break;
        }
    
        for (int i=0; i<_cellContents.count; i++)
        {
            LRDQHomeMsgModel * msgModel=_cellContents[i];
            LRDQHomeMsgFrameModel * msgFrameModel=[LRDQHomeMsgFrameModel LRDQHomeMsgFrameModel:msgModel];
            [_lists addObject:msgFrameModel];
            
        }
        
    }
    
    return _lists;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[self rdv_tabBarController]setTabBarHidden:YES animated:YES];
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController]setTabBarHidden:NO animated:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self Mysendbtn:_MysendList];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lists.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LRDQMymessageTableViewCell * cell=[LRDQMymessageTableViewCell LRDQMymessageTableViewCellWithTableView:tableView];
    LRDQHomeMsgFrameModel*frameModel=self.lists[indexPath.row];
    cell.msgFrameModel = frameModel;
    switch (_eMymessageSel) {
        case eMysendLister:
            cell.makeSure.hidden =NO;
            cell.getUser.hidden  = NO;
            break;
        case eMycatchLister:
            cell.makeSure.hidden =YES;
            cell.getUser.hidden= YES;
            break;
        default:
            break;
    }
    cell.delegate=self;
    cell.msgFrameModel=frameModel;
    
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LRDQHomeMsgFrameModel * msgFrameModel=self.lists[indexPath.row];
    return msgFrameModel.cellHeight;
}

- (IBAction)Mycatchbtn:(UIButton *)sender {
    sender.selected=YES;
    _MysendList.selected=NO;
    _eMymessageSel = eMycatchLister;
    _lists=nil;
    [self.tableView reloadData];
    
}
- (IBAction)Mysendbtn:(UIButton *)sender {
    sender.selected=YES;
    _MycatchList.selected=NO;
    _eMymessageSel = eMysendLister;
    _lists=nil;
    [self.tableView reloadData];
}
-(void)messageCell:(LRDQMymessageTableViewCell *)messageCell makeSureClicked:(UIButton *)makeSure{
    messageCell.msgFrameModel.msgModel.finish = @"1";
    PFQuery * query = [PFQuery queryWithClassName:@"LRDQLists"];
    [query whereKey:@"tel" equalTo:messageCell.msgFrameModel.msgModel.tel];
    [query whereKey:@"desc" equalTo:messageCell.msgFrameModel.msgModel.desc];
    [query findObjectsInBackgroundWithBlock:^(NSArray * objects,NSError * error){
        if (!error) {
            for (PFObject * wallObject in [[NSArray alloc]initWithArray:objects]) {
                dispatch_queue_t asynQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_async(asynQueue, ^{
                    messageCell.msgFrameModel.msgModel.finish = @"1";
                    [wallObject setObject:messageCell.msgFrameModel.msgModel.finish forKey:@"finish"];
                    [wallObject saveInBackground];
                    [wallObject fetch];
                });
            }
            
        }else{
            NSString * errorString = [[error userInfo ]objectForKey:@"error"];
            NSLog(@"error:%@",errorString);
        }
    }];
    [self.tableView reloadData];
}

@end
