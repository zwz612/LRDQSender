//
//  MBProgressHUD+MoreExtension.h
//  KGKuGouPlayer
//
//  Created by neuedu on 15/10/20.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MoreExtension)
+ (MB_INSTANCETYPE)showHUDAddedTo:(UIView *)view LabelText:(NSString*)labelText animated:(BOOL)animated ;

// 将指定的提示语显示在window上 几秒钟
+(void)showTipToWindow:(NSString *)tip;
@end
