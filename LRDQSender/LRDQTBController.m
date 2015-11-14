//
//  LRDQTBController.m
//  LRDQSender
//
//  Created by neuedu on 15/10/11.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "LRDQTBController.h"

@implementation LRDQTBController
+(instancetype)TBController{
    LRDQTBController * tarbarController=[[LRDQTBController alloc]init];
    [tarbarController addTarbarController];
    return tarbarController;
}
-(void)addTarbarController{
    
    UIStoryboard*storyBoard1=[UIStoryboard storyboardWithName:@"LRDQHomePage" bundle:nil];
    UIViewController*firstViewController=[storyBoard1 instantiateViewControllerWithIdentifier:@"ListID"];
    
    UIViewController*firstNavigationController=[[UINavigationController alloc]initWithRootViewController:firstViewController];
    
    UIStoryboard*storyBoard2=[UIStoryboard storyboardWithName:@"LRDQMeStoryBoard" bundle:nil];
    UIViewController*secondViewController=[storyBoard2 instantiateViewControllerWithIdentifier:@"MeID"];
    
    UIViewController*secondNavigationController=[[UINavigationController alloc]initWithRootViewController:secondViewController];
    
    RDVTabBarController*tabBarController=[[RDVTabBarController alloc]init];
    [tabBarController setViewControllers:@[firstNavigationController,secondNavigationController]];
    _TBController = tabBarController;//实验
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"bottom_btn1", @"bottom_btn2", @"bottom_btn3"];
    NSArray *tabBarItemTitles = @[@"订单", @"我"];
    
    RDVTabBar *tabBar = [tabBarController tabBar];
    
    [tabBar setFrame:CGRectMake(CGRectGetMinX(tabBar.frame), CGRectGetMinY(tabBar.frame), CGRectGetWidth(tabBar.frame), 50)];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_checked",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_unchecked",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        item.title = tabBarItemTitles[index];
        
        item.selectedTitleAttributes = @{NSForegroundColorAttributeName: [UIColor purpleColor],
                                         NSFontAttributeName: [UIFont systemFontOfSize:18.f]};
        
        item.unselectedTitleAttributes = @{NSForegroundColorAttributeName: [UIColor grayColor],
                                           NSFontAttributeName: [UIFont systemFontOfSize:16.f]};
        
        index++;
    }
}
@end
