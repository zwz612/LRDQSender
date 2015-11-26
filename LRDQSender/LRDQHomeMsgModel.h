//
//  LRDQHomeMsgModel.h
//  LRDQSender
//
//  Created by neuedu on 15/11/2.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LRDQHomeMsgModel : NSManagedObject
@property (nonatomic ,retain) NSString * time;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * get;
@property (nonatomic, retain) NSString * tel;
@property (nonatomic, retain) NSString * selmsg;
@property (nonatomic, retain) NSString * loginTel;
@property (nonatomic, retain) NSString * getUser;
+(instancetype)LRDQHomeMsgModelWithDict:(NSDictionary *)dict;
@property (nonatomic, retain) NSString * finish;
@property (nonatomic, retain) NSString * distance;//1119
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, assign) BOOL btnclick;
@end
