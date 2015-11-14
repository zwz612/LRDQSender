//
//  PFUserTool.h
//  LRDQSender
//
//  Created by mac on 15/11/12.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFUserTool : NSObject
@property (copy,nonatomic) NSString * userName;


+(instancetype)sharedUser;

@end
