//
//  WJCacheFactory.h
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
#import "IWJCache.h"


//缓存对象宏定义
#define WJ_CACHE_OBJECT(type)           [WJCacheFactory getCacheObject:type]
//是否为有效的缓存对象宏定义
#define WJ_CACHE_IS_VALID(type)         [WJCacheFactory isValidForType:type]

@protocol IWJInjectCacheClass <NSObject>

/**
 *  注入缓存对象Class
 */
+ (BOOL)injectCacheClass:(Class)cacheClass;

@end


/**
 *  缓存类工厂
 */
@interface WJCacheFactory : NSObject<IWJInjectCacheClass>

/**
 *  是否为有效的缓存对象
 *
 *  @param type 类型
 *
 *  @return 是否有效
 */
+ (BOOL)isValidForType:(NSInteger)type;

/**
 *  获取缓存对象
 */
+ (id<IWJCache>)getCacheObject:(NSInteger)type;

@end
