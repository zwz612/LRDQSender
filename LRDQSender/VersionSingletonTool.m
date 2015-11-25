//
//  VersionSingletonTool.m
//  LRDQSender
//
//  Created by mac on 15/11/11.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "VersionSingletonTool.h"

@implementation VersionSingletonTool

static VersionSingletonTool*tool;
+(instancetype)sharedVersionTool{

    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tool = [[VersionSingletonTool alloc]init];
        tool.curVersion = nil;
    });
    return tool;



}
@end
