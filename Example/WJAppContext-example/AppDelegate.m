//
//  AppDelegate.m
//  WJAppContext-example
//
//  Created by 吴云海 on 17/4/5.
//  Copyright © 2017年 WJ. All rights reserved.
//

#import "AppDelegate.h"
#import "ModuleA.h"
#import "RootViewController.h"
#import "WJAppContext.h"

@interface AppDelegate ()

@end


@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [WJAppContext registerAppContext];
    BOOL r = [[WJAppContext sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    if (r) {
        NSLog(@"YES");
    } else {
        NSLog(@"NO");
    }
    
    [self.window setRootViewController:[[RootViewController alloc] init]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL r = [[WJAppContext sharedInstance] application:application handleOpenURL:url];
    return r;
}


@end
