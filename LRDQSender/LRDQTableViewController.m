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
#import "CCLocationManager.h"

#import "MBProgressHUD+MoreExtension.h"

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)

@interface LRDQTableViewController (){
    CLLocationManager *locationmanager;
}
@property (strong ,nonatomic)NSMutableArray * lists;

@property (weak,nonatomic)LRDQHomeTableViewCell * homeCell;
@property(strong,nonatomic)LRDQHomeMsgModel *msgModel;
@property (strong,nonatomic) NSMutableArray * myLists;
@property(strong,nonatomic)PFObject * object;

@property (strong,nonatomic) NSMutableArray * carchList;

//@property (strong,nonatomic)CLLocationManager *locationManager;
@property(assign,nonatomic)CLLocationCoordinate2D coor;

@property (strong,nonatomic) NSMutableArray * disArr;
@end

@implementation LRDQTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (IS_IOS8) {
        [UIApplication sharedApplication].idleTimerDisabled = TRUE;
        locationmanager = [[CLLocationManager alloc] init];
        [locationmanager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [locationmanager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
        locationmanager.delegate = self;
    }
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        _coor = locationCorrrdinate;
    }];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:103.f/255.f green:210.f/255.f blue:243.f/255.f alpha:1];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNewData];
}

-(void)loadNewData{
    [self.tableView.header beginRefreshing];
    if ([PFUser currentUser]) {
        PFQuery * query=[PFQuery queryWithClassName:@"LRDQLists"];
        [query findObjectsInBackgroundWithBlock:^(NSArray * objects,NSError * error){
            if (!error) {
                [CoreDataMngTool deleteAllMsg];
                //[self.lists removeAllObjects];
                //self.lists = nil;
                self.myLists = [NSMutableArray array];
                for (int i=0; i<objects.count; i++) {
                    NSDictionary * dict=objects[i];
                    LRDQHomeMsgModel * msgModel=[LRDQHomeMsgModel LRDQHomeMsgModelWithDict:dict];
                        CGFloat latitude =[msgModel.latitude floatValue];
                        CGFloat longitude =[msgModel.longitude floatValue];
                        //第一个坐标
                        CLLocation *current=[[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
                        //第二个坐标
                        CLLocation *before=[[CLLocation alloc] initWithLatitude:self.coor.latitude longitude:self.coor.longitude];
                        // 计算距离
                        CLLocationDistance meters=[current distanceFromLocation:before];
                        msgModel.distance =[NSString stringWithFormat:@"距离你:%0.1f 公里",meters/1000];
                        msgModel.meter = meters/1000;
                }
                self.lists = nil;
                [self.tableView reloadData];
                
                [self.tableView.header endRefreshing];
            }else{
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
        NSArray* hmarray = [CoreDataMngTool searchLists];
        
        for (int i=0; i<hmarray.count; i++)
        {
            LRDQHomeMsgModel * msgModel=hmarray[i];
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
-(void)senderMngView:(LRDQSenderMngView *)senderMngView senderMngtoHome:(NSString *)addressMng :(NSString *)telMng :(NSString *)descMng :(NSString *)price{
    
    MBProgressHUD * hud =[MBProgressHUD showHUDAddedTo:self.view.window LabelText:@"正在发送" animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomIn;

    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        //1125
        NSString *oreillyAddress=addressMng;
        CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
        [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
            if ([placemarks count] > 0 && error == nil)
            {
                CLPlacemark * firstPlacemark = [placemarks objectAtIndex:0];
                NSString * latitude =[NSString stringWithFormat:@"%f",firstPlacemark.location.coordinate.latitude];
                NSString * longitude = [NSString stringWithFormat:@"%f",firstPlacemark.location.coordinate.longitude];
                if ([telMng validatePhoneNumber]) {
                    NSDictionary * dict=@{@"address":addressMng,
                                          @"tel":telMng,
                                          @"desc":descMng,
                                          @"price":price,
                                          @"get":@"1",
                                          @"time":[NSString HMSWithDate:nil],
                                          @"loginTel":[CoreDataMngTool shareCoreDatamngTool].curTel,
                                          @"getUser":@"",
                                          @"finish":@"0",
                                          @"latitude":latitude,
                                          @"longitude":longitude
                                          };
                    
                    LRDQHomeMsgModel * msgModel=[LRDQHomeMsgModel LRDQHomeMsgModelWithDict:dict];
                    PFObject * object = [PFObject objectWithClassName:@"LRDQLists"];
                    [object setObject:msgModel.tel forKey:@"tel"];
                    [object setObject:msgModel.address forKey:@"address"];
                    [object setObject:msgModel.desc forKey:@"desc"];
                    [object setObject:msgModel.time forKey:@"time"];
                    [object setObject:msgModel.get forKey:@"get"];
                    [object setObject:msgModel.loginTel forKey:@"loginTel"];
                    [object setObject:msgModel.getUser forKey:@"getUser"];
                    [object setObject:msgModel.finish forKey:@"finish"];
                    [object setObject:msgModel.latitude forKey:@"latitude"];
                    [object setObject:msgModel.longitude forKey:@"longitude"];
                    [object setObject:msgModel.price forKey:@"price"];
                    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                        if (!succeeded){
                            //Go back to the wall
                            NSString *errorString = [[error userInfo] objectForKey:@"error"];
                            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [errorAlertView show];
                        }else{
                            hud.hidden = YES;
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
                            //[self.tableView reloadData];
                            [self loadNewData];
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
            }
        }];
    });
    [senderMngView hide];
}

-(void)homeCell:(LRDQHomeTableViewCell *)homeCell getMailClicked:(UIButton *)geiMail{
    PFQuery * query = [PFQuery queryWithClassName:@"LRDQLists"];
    [query whereKey:@"tel" equalTo:homeCell.msgFrameModel.msgModel.tel];
    [query whereKey:@"desc" equalTo:homeCell.msgFrameModel.msgModel.desc];
    [query findObjectsInBackgroundWithBlock:^(NSArray * objects,NSError * error){
        if (!error) {
            if (objects.count == 0) {
                UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:@"提示" message:@"订单已取消" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                [self loadNewData];
            }else{
            for (PFObject * wallObject in [[NSArray alloc]initWithArray:objects]) {
                dispatch_queue_t asynQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_async(asynQueue, ^{
                    homeCell.msgFrameModel.msgModel.get = @"0";
                    [wallObject setObject:homeCell.msgFrameModel.msgModel.get forKey:@"get"];
                    [wallObject setObject:[CoreDataMngTool shareCoreDatamngTool].curTel forKey:@"getUser"];
                    [wallObject saveInBackground];
                    [wallObject fetch];
                });
            }
                [self loadNewData];
            }
        }else{
            NSString * errorString = [[error userInfo ]objectForKey:@"error"];
            NSLog(@"error:%@",errorString);
        }
    }];
    homeCell.msgFrameModel.msgModel.get = @"0";
    [self.tableView reloadData];
    
}

//拨打电话
-(void)homeCell:(LRDQHomeTableViewCell *)homeCell connectButtonClicked:(UIButton *)connect{
    NSString*telnum=homeCell.msgFrameModel.msgModel.tel;
    NSString *allString = [NSString stringWithFormat:@"tel:%@",telnum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:allString]];
}

@end
