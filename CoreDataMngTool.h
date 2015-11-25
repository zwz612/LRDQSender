//
//  CoreDataMngTool.h
//  iOSCoreDataDemo
//
//  Created by hegf on 15/9/10.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LRDQHomeMsgModel.h"

@interface CoreDataMngTool : NSObject
@property (strong,nonatomic) NSArray * msgList;
@property (copy,nonatomic) NSString * curTel;//1109
@property (strong ,nonatomic)NSArray * allMsg;//1111
@property (strong,nonatomic)NSArray * catchMsg;
@property(copy,nonatomic)NSString*selectTel;
@property(copy,nonatomic)NSString * distance;
+(instancetype)shareCoreDatamngTool;

//查询所有Person的方法
+(NSArray*)searchLists;

////删除一个Person的方法
+(void)deleteMsg:(LRDQHomeMsgModel*)contact;
+(void)deleteAllMsg;

/*我的订单＊＊＊＊＊＊＊＊＊＊*/
+(NSArray*)mycatchList;


+(NSArray*)searchLoadList;//1109
@end
