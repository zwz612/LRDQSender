//
//  LRDQTableViewController.m
//  LRDQSender
//
//  Created by neuedu on 15/9/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQTableViewController.h"
#import "LRDQHomeTableViewCell.h"
#import "AppDelegate.h"
#import "LRDQSenderMngView.h"
#import <RDVTabBarController.h>
#import <RDVTabBarItem.h>
#import "MJRefresh.h"
#import "MJRefreshNormalHeader.h"
#import "CoreDataMngTool.h"
#import "NSString+DateTransform.h"
#import <Parse/Parse.h>
#import "NSString+MoreExtentions.h"


@interface LRDQTableViewController ()
@property (strong ,nonatomic)NSMutableArray * lists;

@property (weak,nonatomic)LRDQHomeTableViewCell * homeCell;
@property(strong,nonatomic)LRDQHomeMsgModel *msgModel;
@property (strong,nonatomic) NSMutableArray * myLists;

@property(strong,nonatomic)PFObject * object;
@end

@implementation LRDQTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:103.f/255.f green:210.f/255.f blue:243.f/255.f alpha:1];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    }];
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self loadNewData];
    
    }
-(void)loadNewData{
    [self.tableView.header beginRefreshing];
    if ([PFUser currentUser]) {
        PFQuery * query=[PFQuery queryWithClassName:@"LRDQLists"];
        [query findObjectsInBackgroundWithBlock:^(NSArray * objects,NSError * error){
            if (!error) {
                [CoreDataMngTool deleteAllMsg];
                self.myLists = [NSMutableArray array];
                for (int i=0; i<objects.count; i++) {
                    NSDictionary * dict=objects[i];
                    [LRDQHomeMsgModel LRDQHomeMsgModelWithDict:dict];
                    [self.lists removeAllObjects];
                    for (int j=0; j<[CoreDataMngTool searchLists].count; j++) {
                        LRDQHomeMsgModel * msgModel=[CoreDataMngTool searchLists][j];
                        LRDQHomeMsgFrameModel * msgFrameModel=[LRDQHomeMsgFrameModel LRDQHomeMsgFrameModel:msgModel];
                        [self.lists addObject:msgFrameModel];
                    }
                    
                    [self.tableView reloadData];
                
                }
                [self.tableView.header endRefreshing];
            }else{
                
                NSLog(@"Error");
            }
        }];
    }
}
- (IBAction)write:(UIButton *)sender {
        LRDQSenderMngView* senderMngView=[LRDQSenderMngView senderMngView];
        [senderMngView showInView:self.view.window];
        senderMngView.delegate=self;
        [self.view.window addSubview:senderMngView];
    
}
-(BOOL)prefersStatusBarHidden{
    
    return YES;
}
-(NSMutableArray *)lists
{
    if (_lists==nil) {
        _lists=[NSMutableArray array];
        NSArray * array=[CoreDataMngTool searchLists];
        for (int i=0; i<array.count; i++)
        {
                LRDQHomeMsgModel * msgModel=array[i];
                LRDQHomeMsgFrameModel * msgFrameModel=[LRDQHomeMsgFrameModel LRDQHomeMsgFrameModel:msgModel];
                [_lists addObject:msgFrameModel];
            
            }
    }

    return _lists;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LRDQHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellType1" forIndexPath:indexPath];
    cell.delegate=self;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.msgFrameModel=self.lists[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LRDQHomeMsgFrameModel * msgFrameModel=self.lists[indexPath.row];
    return msgFrameModel.cellHeight;
}
-(void)senderMngView:(LRDQSenderMngView *)senderMngView senderMngtoHome:(NSString *)addressMng :(NSString *)telMng :(NSString *)descMng{
    if ([telMng validatePhoneNumber]) {
        NSDictionary * dict=@{@"address":addressMng,
                              @"tel":telMng,
                              @"desc":descMng,
                              @"get":@"1",
                              @"time":[NSString HMSWithDate:nil],
                              @"loginTel":[CoreDataMngTool shareCoreDatamngTool].curTel
                              };
        //senderMngView.msgModel.isload = YES;//1109
        LRDQHomeMsgModel * msgModel=[LRDQHomeMsgModel LRDQHomeMsgModelWithDict:dict];
        //msgModel.isload = YES;//1109
        PFObject * object = [PFObject objectWithClassName:@"LRDQLists"];
        [object setObject:msgModel.tel forKey:@"tel"];
        [object setObject:msgModel.address forKey:@"address"];
        [object setObject:msgModel.desc forKey:@"desc"];
        [object setObject:msgModel.time forKey:@"time"];
        [object setObject:msgModel.get forKey:@"get"];
        [object setObject:msgModel.loginTel forKey:@"loginTel"];
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if (!succeeded){
                //Go back to the wall
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [errorAlertView show];
            }else{
                UIAlertView *successAlertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"上传成功了" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                [successAlertView show];
                if (self.lists!=nil) {
                    _myLists = [[NSMutableArray alloc]init];
                    [self.lists removeAllObjects];
                    for (int i=0; i<[CoreDataMngTool searchLists].count; i++) {
                        LRDQHomeMsgModel * msgModel=[CoreDataMngTool searchLists][i];
                        LRDQHomeMsgFrameModel * msgFrameModel=[LRDQHomeMsgFrameModel LRDQHomeMsgFrameModel:msgModel];
                        [self.lists addObject:msgFrameModel];
                        //我的订单共用数据
                        [self.myLists addObject:msgModel];
                    }
                    [CoreDataMngTool shareCoreDatamngTool].msgList = nil;
                    [CoreDataMngTool shareCoreDatamngTool].msgList = self.myLists;
                    
                }
                [self.tableView reloadData];//慕思网
            }
        }];
        if (_lists.count>1) {
            NSIndexPath* lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView scrollToRowAtIndexPath:lastIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
        }

    }else{
        UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"电话号码错误" delegate:nil cancelButtonTitle:@"知道了！" otherButtonTitles:nil, nil];
        [alertView show];
    }
    [senderMngView hide];
}

-(void)homeCell:(LRDQHomeTableViewCell *)homeCell getMailClicked:(UIButton *)geiMail{
        PFQuery * query = [PFQuery queryWithClassName:@"LRDQLists"];
        [query whereKey:@"tel" equalTo:homeCell.msgFrameModel.msgModel.tel];
        [query whereKey:@"desc" equalTo:homeCell.msgFrameModel.msgModel.desc];
        [query findObjectsInBackgroundWithBlock:^(NSArray * objects,NSError * error){
            if (!error) {
                for (PFObject * wallObject in [[NSArray alloc]initWithArray:objects]) {
                    dispatch_queue_t asynQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    dispatch_async(asynQueue, ^{

                    homeCell.msgFrameModel.msgModel.get = @"0";
                    [wallObject setObject:homeCell.msgFrameModel.msgModel.get forKey:@"get"];
                    [wallObject saveInBackground];
                    [wallObject fetch];
                });
            }
                                   
            }else{
                NSString * errorString = [[error userInfo ]objectForKey:@"error"];
                NSLog(@"error:%@",errorString);
            }
        }];
    //homeCell.msgFrameModel.msgModel.get=@"0";
    [self.tableView reloadData];
    
}

//拨打电话
-(void)homeCell:(LRDQHomeTableViewCell *)homeCell connectButtonClicked:(UIButton *)connect{
    NSString*telnum=homeCell.msgFrameModel.msgModel.tel;
    NSString *allString = [NSString stringWithFormat:@"tel:%@",telnum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
}

@end
