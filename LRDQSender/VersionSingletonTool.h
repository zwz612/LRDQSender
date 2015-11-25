//
//  VersionSingletonTool.h
//  LRDQSender
//
//  Created by mac on 15/11/11.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionSingletonTool : NSObject
@property (copy,nonatomic) NSString * curVersion;


+(instancetype)sharedVersionTool;
@end
