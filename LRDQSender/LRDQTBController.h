//
//  LRDQTBController.h
//  LRDQSender
//
//  Created by neuedu on 15/10/11.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RDVTabBarController.h>
#import <RDVTabBarItem.h>
@interface LRDQTBController : UIViewController
@property (strong,nonatomic) RDVTabBarController * TBController;
+(instancetype)TBController;
@end
