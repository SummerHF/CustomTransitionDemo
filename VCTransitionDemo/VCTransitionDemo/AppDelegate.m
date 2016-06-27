//
//  AppDelegate.m
//  VCTransitionDemo
//
//  Created by 戴文婷 on 16/6/25.
//  Copyright © 2016年 戴文婷. All rights reserved.
//

#import "AppDelegate.h"
#import "CatModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/**初始化数据*/
-(void)initSourceData
{
    
    self.catsModelArray = @[
                            
                            [CatModel catWithTitle:@"箱子中的猫" withAttribute:@"http://www.sxc.hu/photo/1406907" withImageName:@"CatInBin.jpg"],
                            
                            [CatModel catWithTitle:@"跳舞的猫" withAttribute:@"http://www.sxc.hu/photo/1178601" withImageName:@"DancingCat.jpg"],
                            
                            [CatModel catWithTitle:@"篮子中的小猫" withAttribute:@"http://www.sxc.hu/photo/1406907" withImageName:@"KittensInABasket.jpg"],
                            
                            [CatModel catWithTitle:@"放松的猫" withAttribute:@"http://www.sxc.hu/photo/1406907" withImageName:@"RelaxedCat.jpg"],
                            
                            [CatModel catWithTitle:@"年轻的小猫" withAttribute:@"http://www.sxc.hu/photo/1406907" withImageName:@"VeryYoungKitten.jpg"],
                            
                            [CatModel catWithTitle:@"打哈欠的猫" withAttribute:@"http://www.sxc.hu/photo/1406907" withImageName:@"YawningCat.jpg"],
                            
                            [CatModel catWithTitle:@"聪明的猫" withAttribute:@"http://www.sxc.hu/photo/1406907" withImageName:@"CuteKitten.jpg"],
                            
                            ];
    
}

/**设置样式*/
-(void)initAppearence
{
    
    //设置背景颜色
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.97f green:0.37f blue:0.38f alpha:1.0f]];
    
    //设置字体颜色

    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    //设置标题大小以及颜色
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           
                                                           NSFontAttributeName:[UIFont systemFontOfSize:16],
                                                           
                                                           NSForegroundColorAttributeName :[UIColor whiteColor]
                                                           
                                                           }];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    [self initSourceData];
    
    [self initAppearence];
    
    
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
