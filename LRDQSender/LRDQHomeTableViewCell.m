//
//  LRDQHomeTableViewCell.m
//  LRDQSender
//
//  Created by neuedu on 15/9/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQHomeTableViewCell.h"
#import "LRDQHomeMsgModel.h"

#import "CoreDataMngTool.h"//1106

@implementation LRDQHomeTableViewCell

- (void)awakeFromNib {
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
   
    UIButton * getMail=[[UIButton alloc]init];
    _getMail=getMail;
    [self addSubview:getMail];
    [getMail addTarget:self action:@selector(getMailButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * contact=[[UIButton alloc]init];
    _contact=contact;
    [contact setImage:[UIImage imageNamed:@"telphone"] forState:UIControlStateNormal];
    [contact addTarget:self action:@selector(connectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:contact];
    
    UILabel * distance = [[UILabel alloc]init];//1119
    _distance = distance;
    [self addSubview:distance];
    
    
}
-(void)getMailButtonClicked:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(homeCell:getMailClicked:)]) {
        [_delegate homeCell:self getMailClicked:sender];
    }
    
   }
-(void)connectButtonClicked:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(homeCell:connectButtonClicked:)]) {
        [_delegate homeCell:self connectButtonClicked:sender];
    }

}
-(void)layoutSubviews{
    [super layoutSubviews];
    _time.frame=_msgFrameModel.timeFrame;
    _address.frame=_msgFrameModel.addressFrame;
    _tel.frame=_msgFrameModel.telFrame;
    _desc.frame=_msgFrameModel.descFrame;
    _getMail.frame=_msgFrameModel.getMarlFrame;
    _contact.frame=_msgFrameModel.contactFrame;
    
    _distance.frame = _msgFrameModel.distanceFrame;//1119
}
-(void)setMsgFrameModel:(LRDQHomeMsgFrameModel *)msgFrameModel
{
    _msgFrameModel=msgFrameModel;
    LRDQHomeMsgModel * msgModel=msgFrameModel.msgModel;
    _time.text = msgModel.time;
    _address.text=msgModel.address;
    _tel.text=msgModel.tel;
    _desc.text=msgModel.desc;
    if ([msgModel.get isEqualToString:@"1"]) {
       [_getMail setImage:[UIImage imageNamed:@"qiangdan"] forState:UIControlStateNormal];
        _getMail.enabled=YES;
    }else if ([msgModel.get isEqualToString:@"0"]){
        [_getMail setImage:[UIImage imageNamed:@"yiqiang"] forState:UIControlStateNormal];
        _getMail.enabled=NO;
    }
    _distance.text = msgModel.distance;
    [_distance setTextColor:[UIColor redColor]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}





@end
