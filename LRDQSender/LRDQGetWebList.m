//
//  LRDQGetWebList.m
//  LRDQSender
//
//  Created by neuedu on 15/11/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQGetWebList.h"
#import <Parse/Parse.h>
#import "LRDQHomeMsgFrameModel.h"
@implementation LRDQGetWebList
+(NSMutableArray *)searchWebListIf:(NSString *)key equalTo:(NSString *)loadName{
    NSMutableArray * webList = [NSMutableArray array];
    if ([PFUser currentUser]) {
        PFQuery * query = [PFQuery queryWithClassName:@"LRDQLists"];
        [query whereKey:key equalTo:loadName];
        [query findObjectsInBackgroundWithBlock:^(NSArray * objects,NSError * error){
            for (PFObject * object in objects) {
                LRDQHomeMsgFrameModel * frameModel = [[LRDQHomeMsgFrameModel alloc]init];
                frameModel.msgModel.tel = [object valueForKey:@"tel"];
                frameModel.msgModel.desc = [object valueForKey:@"desc"];
                frameModel.msgModel.address =[object valueForKey:@"address"];
                [webList addObject:frameModel];
            }
        }];
        
    }
    return webList;
}
+(NSArray *)searchWebList{
    NSMutableArray * webList = [NSMutableArray array];
    if ([PFUser currentUser]) {
        PFQuery * query = [PFQuery queryWithClassName:@"LRDQLists"];
        [query findObjectsInBackgroundWithBlock:^(NSArray * objects,NSError * error){
            for (PFObject * object in objects) {
                LRDQHomeMsgFrameModel * frameModel = [[LRDQHomeMsgFrameModel alloc]init];
                frameModel.msgModel.tel = [object valueForKey:@"tel"];
                frameModel.msgModel.desc = [object valueForKey:@"desc"];
                frameModel.msgModel.address =[object valueForKey:@"address"];
                [webList addObject:frameModel];
            }
        }];
        
    }
    return webList;
}


@end
