//
//  LRDQHomeTableViewCell.h
//  LRDQSender
//
//  Created by neuedu on 15/9/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRDQHomeMsgFrameModel.h"
#import "UIView+Extension.h"
#import "NSString+MoreExtentions.h"

#define kTimeFont [UIFont systemFontOfSize:14.f]
@class LRDQHomeTableViewCell;
@protocol LRDQHomeTableViewCellDelegate <NSObject>


@required
-(void)homeCell:(LRDQHomeTableViewCell*)homeCell getMailClicked:(UIButton*)geiMail;
-(void)homeCell:(LRDQHomeTableViewCell*)homeCell connectButtonClicked:(UIButton*)connect;

@end
@interface LRDQHomeTableViewCell : UITableViewCell
@property (weak, nonatomic)UILabel * time;
@property (weak ,nonatomic)UIButton * getMail;
@property (weak ,nonatomic)UIButton * contact;
@property (weak ,nonatomic)UILabel * address;
@property (weak,nonatomic)UILabel * tel;
@property (weak,nonatomic)UILabel * desc;
@property (weak,nonatomic) UILabel * distance;


@property(weak,nonatomic)UILabel * price;//1127


@property(weak,nonatomic)id<LRDQHomeTableViewCellDelegate>delegate;
@property (strong,nonatomic)LRDQHomeMsgFrameModel * msgFrameModel;







@end
