//
//  WJUUIDUtils.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/29.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WJ_UUID         [WJUUIDUtils UUID]

/**
 *  UUID 工具类
 */
@interface WJUUIDUtils : NSObject

/**
 *  生成一个UUID字符串
 *
 *  @return 返回随机UUID
 */
+(NSString*) UUID;

@end
