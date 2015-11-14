//
//  NSString+DateTransform.h
//  UI14-QQ聊天界面
//
//  Created by neuedu on 15/8/27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
//[NSString HMWithDate:now];
//[NSString HMSWithDate:now];
//[NSString YMDWithDate:now];
@interface NSString (DateTransform)
//取得小时：分 比如11:23
//如果你传入的date事nil 返回的是当前的时间字符串
+(instancetype)HMWithDate:(NSDate*)date;
+(instancetype)HMSWithDate:(NSDate*)date;
+(instancetype)YMDWithDate:(NSDate*)date;
@end
