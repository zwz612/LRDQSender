//
//  LRDQHomeMsgFrameModel.m
//  LRDQSender
//
//  Created by neuedu on 15/9/17.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQHomeMsgFrameModel.h"

@implementation LRDQHomeMsgFrameModel

+(instancetype)LRDQHomeMsgFrameModel:(LRDQHomeMsgModel *)msgModel
{
    LRDQHomeMsgFrameModel * msgFrameModel=[[LRDQHomeMsgFrameModel alloc]init];
    
    if (msgFrameModel) {
        [msgFrameModel initWithmsgModel:msgModel];
    }
    return msgFrameModel;
}
-(void)initWithmsgModel:(LRDQHomeMsgModel*)msgModel
{
    _msgModel=msgModel;
    _timeFrame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,kMargin);
    CGFloat addressFrameW=[UIScreen mainScreen].bounds.size.width*textWidthRatio;
    CGFloat addressFrameH=[msgModel.address heightForWidth:addressFrameW Font:addressFont];
    
    _addressFrame=CGRectMake(kMargin, CGRectGetMaxY(_timeFrame),addressFrameW, addressFrameH);
    
    CGFloat telFrameH =[msgModel.tel heightForWidth:addressFrameW Font:telFont];
    _telFrame=CGRectMake(CGRectGetMinX(_addressFrame), CGRectGetMaxY(_addressFrame)+kMargin, addressFrameW, telFrameH);
    
    CGFloat descFrameH=[msgModel.desc heightForWidth:addressFrameW Font:descFont];
    _descFrame=CGRectMake(CGRectGetMinX(_telFrame), CGRectGetMaxY(_telFrame)+kMargin, addressFrameW, descFrameH);

    _getMarlFrame=CGRectMake(CGRectGetMaxX(_addressFrame)+kMargin, CGRectGetMaxY(_addressFrame), 44.f, 44.f);
    
    _contactFrame=CGRectMake(CGRectGetMaxX(_getMarlFrame)+kMargin, CGRectGetMinY(_getMarlFrame), 44.f, 44.f);
    
    _getUserFrame=CGRectMake(CGRectGetMinX(_descFrame), CGRectGetMaxY(_descFrame)+kMargin,[UIScreen mainScreen].bounds.size.width, 18.f);
    _distanceFrame =CGRectMake(CGRectGetMinX(_descFrame), CGRectGetMaxY(_descFrame)+kMargin, [UIScreen mainScreen].bounds.size.width, 18.f);
    
    
}
-(CGFloat)cellHeight
{
        return CGRectGetMaxY(_getUserFrame);
}
@end
