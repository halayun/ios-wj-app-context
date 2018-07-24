//
//  WJAppContext.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/11/2.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJAppContext.h"
#import "IAppModule.h"
#import "WJConfig.h"

@interface WJAppContext ()

@property(nonatomic, strong) NSMutableArray *appModules;

@end

@implementation WJAppContext

DEF_SINGLETON_INIT(WJAppContext)


+(void) registerAppContext {
    [WJAppContext sharedInstance];
}

- (Class)loadClazz:(NSString*)clazzName {
    return NSClassFromString(clazzName);
}

-(void) singleInit {
    self.appModules = [[NSMutableArray alloc] init];
    NSDictionary *appContextConfig = [[WJConfig sharedInstance] getConfig:@"WJAppContext"];
    id o = appContextConfig[@"modules"];
    if (o) {
        if ([o isKindOfClass:[NSArray class]]) {
            NSArray *modules = (NSArray*)o;
            for (NSString *moduleClazzName in modules) {
                Class clazz = [self loadClazz:moduleClazzName];
                if (clazz) {
                    if ([clazz conformsToProtocol:@protocol(IAppModule)]) {
                        [self.appModules addObject:[[clazz alloc] init]];
                        WJLogVerbose(@"WJAppContext config load %@ module successful", moduleClazzName);
                    } else {
                        WJLogError(@"WJAppContext config %@ Do not implement IAppModule ", moduleClazzName);
                    }
                } else {
                    WJLogError(@"WJAppContext config not load class:%@", moduleClazzName);
                }
            }
        } else {
            WJLogError(@"WJAppContext config modules not array type error ...");
        }
    }
}

-(void)forwardInvocation:(NSInvocation *)anInvocation {
    for (id<IAppModule> module in _appModules) {
        if ([module respondsToSelector:[anInvocation selector]]) {
            [anInvocation invokeWithTarget:module];
        }
    }
}

@end
