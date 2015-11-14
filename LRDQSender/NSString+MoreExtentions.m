//
//  NSString+MoreExtentions.m
//  UI2-微博
//
//  Created by hegf on 15/8/24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "NSString+MoreExtentions.h"

@implementation NSString (MoreExtentions)

-(CGFloat)heightForWidth:(CGFloat)width Font:(UIFont *)font{
    
    CGSize size = {width, MAXFLOAT};
    NSDictionary* attributs = @{NSFontAttributeName: font};
    
    CGRect boundRect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributs context:nil];
    return boundRect.size.height;
}

-(CGFloat)widthForWidth:(CGFloat)width Font:(UIFont *)font{
    
    CGSize size = {width, MAXFLOAT};
    NSDictionary* attributs = @{NSFontAttributeName: font};
    
    CGRect boundRect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributs context:nil];
    return boundRect.size.width;
}
-(BOOL)validatePhoneNumber{
    NSString * number = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate * numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:self];
}

@end
