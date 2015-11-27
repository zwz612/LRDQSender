//
//  LRDQMymessageTableViewCell.h
//  LRDQSender
//
//  Created by neuedu on 15/11/4.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LRDQHomeMsgFrameModel.h"
#define kTimeFont [UIFont systemFontOfSize:14.f]

@class LRDQMymessageTableViewCell;
@protocol LRDQMymessageTableViewCellDelegate<NSObject>

@required
-(void)messageCell:(LRDQMymessageTableViewCell*)messageCell makeSureClicked:(UIButton*)makeSure;
@end

@interface LRDQMymessageTableViewCell : UITableViewCell

+(instancetype)LRDQMymessageTableViewCellWithTableView:(UITableView*)tableView;
@property(weak,nonatomic)UIButton*telnumber;
@property (weak, nonatomic)UILabel * time;
@property (weak ,nonatomic)UIButton * contact;
@property (weak ,nonatomic)UILabel * address;
@property (weak,nonatomic)UILabel * tel;
@property (weak,nonatomic)UILabel * desc;

@property (weak,nonatomic)UILabel * price;//1127

@property (strong,nonatomic)NSArray *array;
@property(weak,nonatomic)UILabel*getUser;
@property(weak,nonatomic)UIButton*makeSure;
@property (weak, nonatomic) id <LRDQMymessageTableViewCellDelegate> delegate;
@property (strong,nonatomic)LRDQHomeMsgFrameModel * msgFrameModel;
@end
