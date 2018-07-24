//
//  WJCacheType.h
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16/9/22.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  缓存类型
 */
typedef NS_ENUM(NSInteger, WJCacheType) {
    
    /**
     *  NSUserDefault
     */
    WJCacheTypeUserDefaults = 0,
    
    /**
     *  秘钥缓存
     */
    WJCacheTypeKeychain = 1,
};
