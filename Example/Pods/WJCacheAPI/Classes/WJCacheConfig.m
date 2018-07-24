//
//  WJCacheConfig.m
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

#import "WJCacheConfig.h"
#import "WJCacheFactory.h"

@implementation WJCacheConfig

DEF_SINGLETON_INIT(WJCacheConfig)

-(void) singleInit {
    _keychainDefaultService = [[NSBundle mainBundle] bundleIdentifier];
    _keychainAccessGroup = @"";
}

-(void) setKeychainAccessGroup:(NSString*) keychainAccessGroup {
    _keychainAccessGroup = [keychainAccessGroup copy];
}

-(void) setKeychainDefaultService:(NSString *) defaultService {
    if (defaultService) {
        _keychainDefaultService = [defaultService copy];
    }
}

- (BOOL)saveCacheObjectClass:(Class)cacheClass {
    return [WJCacheFactory injectCacheClass:cacheClass];
}

@end
