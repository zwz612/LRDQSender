//
//  LRDQMeButton.h
//  LRDQSender
//
//  Created by neuedu on 15/11/3.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRDQMeButton : UIButton
@property(weak,nonatomic)UIButton*btn;

+(instancetype)LRDQMeButton:(NSString*)btnName;
@end
