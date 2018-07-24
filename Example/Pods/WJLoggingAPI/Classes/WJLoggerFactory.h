//
//  WJLoggerFactory.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 15-12-13.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWJLogger.h"

/**
 *  日志记录器工厂
 */
@interface WJLoggerFactory : NSObject

/**
 *  得到日志记录器
 */
+(id<IWJLogger>) getLogger;

@end
