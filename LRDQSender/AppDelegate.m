//
//  AppDelegate.m
//  LRDQSender
//
//  Created by neuedu on 15/9/16.
//  Copyright (c) 2015年 zhg. All rights reserved.
//

#import "AppDelegate.h"
#import "LRDQMeViewController.h"
#import "LRDQwelViewController.h"
#import "LRDQLogonAndSignUpViewController.h"
#import "LRDQLogonViewController.h"
#import <Parse/Parse.h>
#import <RDVTabBarItem.h>
#import <RDVTabBarController.h>
#import "VersionSingletonTool.h"
#import "LRDQTableViewController.h"
#import "LRDQTBController.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions

{
    
    dispatch_queue_t asynQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(asynQueue, ^{
        //网络
        [Parse setApplicationId:@"tf46oRYGjQa8GLz9DueRY4qmcWBzu6PPzrBZUQEl"
                      clientKey:@"a2xShS8R4PnjJNOjHlMSpUrigBg99ZGJc3qkBJOq"];
        //1其中第一部分代码创建了一个对象,并指定其类名为Player。
        PFObject*player =[PFObject objectWithClassName:@"Player"];
        
        [player setObject:@"John"forKey:@"Name"];
        //3 第三部分代码用于保存该对象。此时将会以同步方式将对象发送到服务器。
        [player save];
        
        
    });
    
    _window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.frame = [UIScreen mainScreen].bounds;
    
    NSDictionary * infoDict = [NSBundle mainBundle].infoDictionary;
    NSString * newVersion = infoDict[@"CFBundleVersion"];
    
    //    //2、和之前保存的版本号对比，如果相同，则从主页启动，不同则从欢迎页启动。
    NSString * oldVersion= [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleVersion"];
    if (oldVersion == nil)
    {
        //从欢迎页启动
        UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"LRDQwelStoryboard" bundle:nil];
        LRDQwelViewController * welVC = [storyBoard instantiateViewControllerWithIdentifier:@"welID"];
        self.window.rootViewController = welVC;
    }
    else
    {
        if ([oldVersion isEqualToString:newVersion])
        {
            
            UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"LRDQwelStoryboard" bundle:nil];
            LRDQwelViewController * welVC = [storyBoard instantiateViewControllerWithIdentifier:@"welID"];
            self.window.rootViewController = welVC;
            //从登录注册页启动
//            UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"LRDQLogonAndSignUpStoryBoard" bundle:nil];
//            LRDQLogonAndSignUpViewController * signUpOrIn = [storyBoard instantiateViewControllerWithIdentifier:@"LogonAndSIgnUPID"];
//            UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:signUpOrIn];
//            self.window.rootViewController = nav;
        }
        else
        {
            //从欢迎页启动
            UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"LRDQwelStoryboard" bundle:nil];
            LRDQwelViewController * welVC = [storyBoard instantiateViewControllerWithIdentifier:@"welID"];
            self.window.rootViewController = welVC;
        }
    }
    
    //3、如果不同，把新的app版本号保存起来。
    [[NSUserDefaults standardUserDefaults] setObject:newVersion forKey:@"CFBundleVersion"];
    [self.window makeKeyAndVisible];
    NSLog(@"doc path%@",self.applicationDocumentsDirectory);
    
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.neuedu.LRDQSender" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LRDQSender" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LRDQSender.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
