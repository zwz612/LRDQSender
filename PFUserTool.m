//
//  PFUserTool.m
//  LRDQSender
//
//  Created by neuedu on 15/11/13.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "PFUserTool.h"
static PFUserTool*tool;
@implementation PFUserTool
+(instancetype)sharedUser{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tool = [[PFUserTool alloc]init];
        tool.userName = nil;
    });
    return tool;
 
}


@end
