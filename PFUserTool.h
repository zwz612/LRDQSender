//
//  PFUserTool.h
//  LRDQSender
//
//  Created by neuedu on 15/11/13.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFUserTool : NSObject
@property (copy,nonatomic) NSString * userName;


+(instancetype)sharedUser;
@end
