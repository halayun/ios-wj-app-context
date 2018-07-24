//
//  WJLoggingMacros.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 15-12-26.
//  Copyright (c) 2015年 WJ. All rights reserved.
//


/**
 * 日志入口
 * error > warn > info > debug > verbose
 */

#import "IWJLogger.h"
#import "WJLoggerFactory.h"

#define WJLogError(frmt, ...) \
        [[WJLoggerFactory getLogger] error:[NSString stringWithFormat:@"%s line:%d",__func__,__LINE__] format:frmt, ##__VA_ARGS__]

#define WJLogWarn(frmt, ...) \
        [[WJLoggerFactory getLogger] warn:[NSString stringWithFormat:@"%s line:%d",__func__,__LINE__] format:frmt, ##__VA_ARGS__]

#define WJLogInfo(frmt, ...) \
        [[WJLoggerFactory getLogger] info:[NSString stringWithFormat:@"%s line:%d",__func__,__LINE__] format:frmt, ##__VA_ARGS__]

#define WJLogDebug(frmt, ...) \
        [[WJLoggerFactory getLogger] debug:[NSString stringWithFormat:@"%s line:%d",__func__,__LINE__] format:frmt, ##__VA_ARGS__]

#define WJLogVerbose(frmt, ...) \
        [[WJLoggerFactory getLogger] verbose:[NSString stringWithFormat:@"%s line:%d",__func__,__LINE__] format:frmt, ##__VA_ARGS__]