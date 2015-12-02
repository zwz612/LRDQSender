//
//  MBProgressHUD+MoreExtension.m
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/20.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "MBProgressHUD+MoreExtension.h"

@implementation MBProgressHUD (MoreExtension)
+(instancetype)showHUDAddedTo:(UIView *)view LabelText:(NSString *)labelText animated:(BOOL)animated{
    
    
    MBProgressHUD*hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.labelText=labelText;

    
    
    return hud;
}
+(void)showTipToWindow:(NSString *)tip{
    
    MBProgressHUD*hud=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode=MBProgressHUDModeText;
    hud.labelText=tip;
    //从屏幕中心点向下偏移
    hud.yOffset=[UIScreen mainScreen].bounds.size.height*0.25;
    [hud hide:YES afterDelay:3.0f];
}
@end
