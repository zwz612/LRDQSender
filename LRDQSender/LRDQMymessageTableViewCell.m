//
//  LRDQMymessageTableViewCell.m
//  LRDQSender
//
//  Created by neuedu on 15/11/4.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQMymessageTableViewCell.h"
#include "CoreDataMngTool.h"
#import "LRDQHomeMsgModel.h"

@implementation LRDQMymessageTableViewCell
+(instancetype)LRDQMymessageTableViewCellWithTableView:(UITableView*)tableView{
    static NSString* ID = @"homeListcell";
    
    LRDQMymessageTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LRDQMymessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
      

    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel* time = [[UILabel alloc]init];
        _time = time;
        [self addSubview:time];
        time.font = kTimeFont;
        time.textColor = [UIColor grayColor];
        time.textAlignment = NSTextAlignmentCenter;
        
        UILabel * address=[[UILabel alloc]init];
        _address=address;
        address.numberOfLines=0;
        [self addSubview:address];
        
        UILabel *tel=[[UILabel alloc]init];
        _tel=tel;
        tel.numberOfLines=0;
        [self addSubview:tel];
        
        UILabel * desc=[[UILabel alloc]init];
        _desc=desc;
        desc.numberOfLines=0;
        [self addSubview:desc];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _time.frame=_msgFrameModel.timeFrame;
    _address.frame=_msgFrameModel.addressFrame;
    _tel.frame=_msgFrameModel.telFrame;
    _desc.frame=_msgFrameModel.descFrame;
}
-(void)setMsgFrameModel:(LRDQHomeMsgFrameModel *)msgFrameModel
{
    _msgFrameModel=msgFrameModel;
    _time.text = msgFrameModel.msgModel.time;
    _address.text=msgFrameModel.msgModel.address;
    _tel.text=msgFrameModel.msgModel.tel;
    _desc.text=msgFrameModel.msgModel.desc;
    
    

   
   
   
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
