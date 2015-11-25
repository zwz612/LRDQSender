//
//  LRDQGetWebList.h
//  LRDQSender
//
//  Created by neuedu on 15/11/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRDQGetWebList : NSObject
+(NSArray *)searchWebListIf:(NSString *)key equalTo:(NSString *)loadName;
+(NSArray *)searchWebList;
@end
