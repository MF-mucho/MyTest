//
//  AppDelegate.m
//  WeatherForecast
//
//  Created by tarena on 16/1/16.
//  Copyright © 2016年 Muxi. All rights reserved.
//

#import "AppDelegate.h"
#import "MFMainViewController.h"
#import "RESideMenu.h"
#import "MFLeftViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:SCREEN_BOUNDS];  //创建跟视图控制器
    //创建RESiderMenu对象（指定内容/左边/右边）
    RESideMenu *sideViewController = [[RESideMenu alloc]initWithContentViewController:[MFMainViewController new] leftMenuViewController:[MFLeftViewController new] rightMenuViewController:nil];
    sideViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    //设置内容控制器的阴影颜色、半径、enable
    sideViewController.contentViewShadowColor = [UIColor blackColor];
    sideViewController.contentViewShadowRadius = 10;
    sideViewController.contentViewShadowEnabled = YES;
    
    
    
    self.window.rootViewController = sideViewController;
    self.window.backgroundColor = [UIColor clearColor];
    //显示
    [self.window makeKeyAndVisible];
    
    
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
}

@end
