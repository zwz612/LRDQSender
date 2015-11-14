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
@interface LRDQMymessageTableViewCell : UITableViewCell

+(instancetype)LRDQMymessageTableViewCellWithTableView:(UITableView*)tableView;
@property (weak, nonatomic)UILabel * time;
@property (weak ,nonatomic)UIButton * contact;
@property (weak ,nonatomic)UILabel * address;
@property (weak,nonatomic)UILabel * tel;
@property (weak,nonatomic)UILabel * desc;
@property (copy,nonatomic)NSArray *array;
@property (strong,nonatomic)LRDQHomeMsgFrameModel * msgFrameModel;
@end
