//
//  LRDQHomeMsgModel.m
//  LRDQSender
//
//  Created by neuedu on 15/11/2.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQHomeMsgModel.h"
#import "AppDelegate.h"
#import "CoreDataMngTool.h"

@implementation LRDQHomeMsgModel

@dynamic address;
@dynamic desc;
@dynamic get;
@dynamic tel;
@dynamic time;
@dynamic selmsg;
@dynamic loginTel;
@dynamic getUser;
@dynamic finish;
@dynamic longitude;
@dynamic latitude;
@dynamic btnclick;
@dynamic distance;
@dynamic meter;

+(instancetype)LRDQHomeMsgModelWithDict:(NSDictionary *)dict{
    
    AppDelegate*delegate=[UIApplication sharedApplication].delegate;
    LRDQHomeMsgModel*model=[NSEntityDescription insertNewObjectForEntityForName:@"LRDQHomeMsgModel" inManagedObjectContext:delegate.managedObjectContext];
    
    model.tel=[dict objectForKey:@"tel"];
    model.desc=[dict objectForKey:@"desc"];
    model.get=[dict objectForKey:@"get"];
    model.address=[dict objectForKey:@"address"];
    model.time=[dict objectForKey:@"time"];
    model.selmsg = [dict objectForKey:@"selmsg"];
    model.loginTel = [dict objectForKey:@"loginTel"];
    model.getUser = [dict objectForKey:@"getUser"];
    model.finish=[dict objectForKey:@"finish"];
    

    model.distance = [dict objectForKey:@"distance"];
    model.latitude = [dict objectForKey:@"latitude"];
    model.longitude = [dict objectForKey:@"longitude"];
    model.btnclick=NO;
    
    [delegate saveContext];
    
    return model;
}


@end
