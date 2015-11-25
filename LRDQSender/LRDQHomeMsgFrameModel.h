//
//  LRDQHomeMsgFrameModel.h
//  LRDQSender
//
//  Created by neuedu on 15/9/17.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LRDQHomeMsgModel.h"
#import "NSString+MoreExtentions.h"
#define kMargin 20.f
#define textWidthRatio 200.f/375.f
#define addressFont [UIFont systemFontOfSize:18.f]
#define telFont [UIFont systemFontOfSize:18.f]
#define descFont [UIFont systemFontOfSize:18.f]

@interface LRDQHomeMsgFrameModel : NSObject
@property(assign ,nonatomic)CGRect timeFrame;
@property(assign ,nonatomic)CGRect addressFrame;
@property(assign ,nonatomic)CGRect telFrame;
@property(assign ,nonatomic)CGRect descFrame;
@property(assign ,nonatomic)CGRect getMarlFrame;
@property(assign ,nonatomic)CGRect contactFrame;
@property(assign,nonatomic)CGRect getUserFrame;
@property(assign,nonatomic)CGRect distanceFrame;

@property(strong,nonatomic)LRDQHomeMsgModel * msgModel;

@property(assign,nonatomic)BOOL stroll;

@property(assign,nonatomic)CGFloat cellHeight;

+(instancetype)LRDQHomeMsgFrameModel:(LRDQHomeMsgModel*)msgModel;


@end
