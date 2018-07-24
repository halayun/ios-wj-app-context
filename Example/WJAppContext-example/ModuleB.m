//
//  ModuleB.m
//  WJAppContext-example
//
//  Created by 吴云海 on 17/4/5.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import "ModuleB.h"

@implementation ModuleB

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"bbb:%@", launchOptions);
    return NO;
}

-(void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"tttt");
}

@end
