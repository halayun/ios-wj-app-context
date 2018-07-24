//
//  WJCacheConfig.h
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

#import <Foundation/Foundation.h>
#import "WJSingleton.h"
#import "IWJCache.h"

/**
 *  缓存配置
 */
@interface WJCacheConfig : NSObject

AS_SINGLETON(WJCacheConfig)

@property (nonatomic, copy, readonly) NSString *keychainAccessGroup;

@property (nonatomic, copy, readonly) NSString *keychainDefaultService;

/**
 *  keychain accessGroup
 */
- (void)setKeychainAccessGroup:(NSString*) keychainAccessGroup;

/**
 *  keychain service
 */
- (void)setKeychainDefaultService:(NSString *) defaultService;

/**
 *  扩展使用，如果有自定义缓存对象可以使用这个方法添加，但是注意，cacheType不能是默认的，WJCacheTypeUserDefault、WJCacheTypeFile、WJCacheTypeMemory、WJCacheTypeKeychain
 *
 *  @return 添加是否成功
 */
- (BOOL)saveCacheObjectClass:(Class)cacheObjectClass;

@end
