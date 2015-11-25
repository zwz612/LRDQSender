//
//  NEUButton.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/9/22.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "NEUButton.h"

@implementation NEUButton
//返回button的image的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//  CGRect rect = [super imageRectForContentRect:contentRect];
//    return rect;
    NSLog(@"image content rect %@",NSStringFromCGRect(contentRect));
    NSLog(@"default image rect %@",NSStringFromCGRect([super imageRectForContentRect:contentRect]));
    CGFloat newImageRectX=(CGRectGetWidth(contentRect)-30.f)*0.5;
    CGFloat newImageRectY=8.f;
    
    CGRect newImageRect=CGRectMake(newImageRectX, newImageRectY, 30.f, 30.f);
    return newImageRect;
}
//返回button的title的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    NSLog(@"title content rect %@",NSStringFromCGRect(contentRect));
NSLog(@"default title rect %@",NSStringFromCGRect([super titleRectForContentRect:contentRect]));
    CGRect titleRect=[super titleRectForContentRect:contentRect];
    CGFloat newnewTitleRectX=(CGRectGetWidth(contentRect)-CGRectGetWidth(titleRect))*0.5;
    CGFloat newnewTitleRectY=(CGRectGetHeight(contentRect)-38.f-CGRectGetHeight(titleRect))*0.5+38.f;
    CGFloat newTitleRectW=CGRectGetWidth(titleRect);
    CGFloat newTitleRectH=CGRectGetHeight(titleRect);
    CGRect newTitleRect=CGRectMake(newnewTitleRectX, newnewTitleRectY, newTitleRectW, newTitleRectH);
    
    return newTitleRect;
}
@end
