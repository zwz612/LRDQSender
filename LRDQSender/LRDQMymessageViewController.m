
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
                _cellContents=[CoreDataMngTool mycatchList];
                
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


///*-------1111+＋＋＋＋＋删除*/
//
//0922.10 订单删除
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_eMymessageSel ==eMysendLister ) {
        return YES;//可以编辑
    }else{
        return NO;
    }
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    LRDQHomeMsgFrameModel * msgframeModel = self.lists[indexPath.row];

    [CoreDataMngTool deleteMsg:msgframeModel.msgModel];
    _lists = nil;
    
    PFQuery * query = [PFQuery queryWithClassName:@"LRDQLists"];
       [query whereKey:@"loginTel" equalTo:[CoreDataMngTool shareCoreDatamngTool].curTel];
//    [query whereKey:@"tel" equalTo:msgframeModel.msgModel.tel];
//    [query whereKey:@"desc" equalTo:msgframeModel.msgModel.desc];
    [query findObjectsInBackgroundWithBlock:^(NSArray * objects,NSError * error){
        if (!error) {
            for (PFObject * wallObject in [[NSArray alloc]initWithArray:objects]) {
//                dispatch_queue_t asynQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//                dispatch_async(asynQueue, ^{
//
//                    [wallObject removeObjectForKey:@"LRDQLists"];
//                    //[wallObject deleteInBackground];
//                    //[wallObject saveInBackground];
//                    [wallObject fetch];
//                });
                [wallObject delete];
                
            }
            
        }else{
            NSString * errorString = [[error userInfo ]objectForKey:@"error"];
            NSLog(@"error:%@",errorString);
        }
    }];
    
    
    [self.tableView reloadData];
    
}





@end
