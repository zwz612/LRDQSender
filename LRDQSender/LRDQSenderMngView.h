//
//  LRDQSenderMngView.h
//  LRDQSender
//
//  Created by neuedu on 15/9/28.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRDQHomeMsgModel.h"//1109
@class LRDQSenderMngView;
@protocol LRDQSenderMngViewDelegate <NSObject>

@required
-(void)senderMngView:(LRDQSenderMngView*)senderMngView senderMngtoHome:(NSString*)addressMng :(NSString*)telMng :(NSString*)descMng;
@end

@interface LRDQSenderMngView : UIView

@property(weak,nonatomic)UITextField* tel;
@property (weak,nonatomic)UITextField * address;
@property (weak,nonatomic)UITextField * desc;

@property(weak,nonatomic)UIButton* cancel;
@property(weak,nonatomic)UIButton* sender;
@property(weak,nonatomic)UIView * coverBoard;

@property(weak,nonatomic)id<LRDQSenderMngViewDelegate>delegate;
@property (strong,nonatomic) LRDQHomeMsgModel * msgModel;
+(instancetype)senderMngView;

-(void)showInView:(UIView*)view;
-(void)hide;

@end
