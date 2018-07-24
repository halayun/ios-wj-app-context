//
//  WJCacheFactory.m
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16/9/6.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "WJCacheFactory.h"
#import "WJCacheType.h"
#import "WJLoggingMacros.h"

static NSMutableDictionary *wjCacheObjects;

@implementation WJCacheFactory

+(void)initialize {
    if (!wjCacheObjects) {
        wjCacheObjects = [[NSMutableDictionary alloc] init];
        
        //添加默认缓存对象
        Class userDefaultsCache = NSClassFromString(@"WJCacheUserDefaults");
        if ([self injectCacheClass:userDefaultsCache]) {
            WJLogDebug(@"add NSUserDefaults cache object success ...");
        }
        Class keychainCache = NSClassFromString(@"WJCacheKeychain");
        if ([self injectCacheClass:keychainCache]) {
            WJLogDebug(@"add Keychain cache object success ...");
        }
    }
}

+ (BOOL)isValidForType:(NSInteger)type {
    return [[wjCacheObjects allKeys] containsObject:@(type)];
}

+ (id<IWJCache>)getCacheObject:(NSInteger)type {
    return wjCacheObjects[@(type)];
}

#pragma mark IWJInjectCacheClass
+ (BOOL)injectCacheClass:(Class)cacheClass {
    if (cacheClass != Nil && [cacheClass conformsToProtocol:@protocol(IWJCache)]) {
        id<IWJCache> cache = [cacheClass getInstance];
        if (cache && ![self isValidForType:[cache cacheType]]) {
            [wjCacheObjects setObject:cache forKey:@([cache cacheType])];
            return YES;
        }
    }
    return NO;
}

@end
