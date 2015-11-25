//
//  CoreDataMngTool.m
//  iOSCoreDataDemo
//
//  Created by hegf on 15/9/10.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "CoreDataMngTool.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

static CoreDataMngTool * tool;
@implementation CoreDataMngTool
+(instancetype)shareCoreDatamngTool{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tool = [[CoreDataMngTool alloc]init];
        tool.msgList = nil;
    });
    return tool;
}
+(NSArray *)searchLists{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"LRDQHomeMsgModel" inManagedObjectContext:delegate.managedObjectContext];
    request.entity = desc;
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO];
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"get" ascending:NO];

    //request.sortDescriptors = [NSArray arrayWithObject:sort];
    request.sortDescriptors = [NSArray arrayWithObjects:sort1,sort,nil];
    NSError *error = nil;
    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }

    
    return objs;

}
+(void)deleteMsg:(LRDQHomeMsgModel *)contact{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext deleteObject:contact];
    
    NSError *error = nil;
    [delegate.managedObjectContext save:&error];
    if (error) {
        [NSException raise:@"删除错误" format:@"%@", [error localizedDescription]];
    }
    [CoreDataMngTool shareCoreDatamngTool].allMsg = nil;//1111
}
+(void)deleteAllMsg{
    AppDelegate *delegate=[UIApplication sharedApplication].delegate;
    NSArray * msgs=[CoreDataMngTool searchLists];
    
    for (int i=0; i<msgs.count; i++) {
        [CoreDataMngTool deleteMsg:msgs[i]];
    }
    NSError *error = nil;
    [delegate.managedObjectContext save:&error];
    if (error) {
        [NSException raise:@"删除错误" format:@"%@", [error localizedDescription]];
    }
    
    
}


/*我的订单信息＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊＊*/

+(NSArray*)mycatchList{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"LRDQHomeMsgModel" inManagedObjectContext:delegate.managedObjectContext];
    request.entity = desc;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    NSString *tempStr = [CoreDataMngTool shareCoreDatamngTool].curTel;
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat: @"getUser like %@",tempStr];
    request.predicate = predicate1;
    NSError *error = nil;
    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    return objs;
}

+(NSArray*)searchLoadList{//1109
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"LRDQHomeMsgModel" inManagedObjectContext:delegate.managedObjectContext];
    request.entity = desc;
    NSString *tempStr = [CoreDataMngTool shareCoreDatamngTool].curTel;
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"loginTel like %@",tempStr];
    request.predicate=predicate;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO];//1110
    request.sortDescriptors = [NSArray arrayWithObject:sort];//1110
    NSError *error = nil;
    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    return objs;
}

-(NSArray *)msgList//1109
{
    _msgList = nil;
    if (_msgList == nil) {
        _msgList = [CoreDataMngTool searchLoadList];
    }
    return _msgList;
}
-(NSArray *)allMsg{//1111
    if (_allMsg == nil) {
        _allMsg =[CoreDataMngTool searchLists];
    }
    return _allMsg;
}
-(NSArray *)catchMsg{
    _catchMsg = nil;
    if (_catchMsg ==nil) {
        _catchMsg = [CoreDataMngTool mycatchList];
    }
    return _catchMsg;
}


@end
