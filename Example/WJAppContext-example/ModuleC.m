//
//  ModuleC.m
//  WJAppContext-example
//
//  Created by 吴云海 on 17/4/6.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import "ModuleC.h"

@implementation ModuleC


-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"ccc:%@", launchOptions);
    return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"tttt");
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return YES;
}

@end
