//
//  WJLoggerFactory.m
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

#import "WJLoggerFactory.h"

@implementation WJLoggerFactory

static id<IWJLogger> logger = nil;

+(id<IWJLogger>) getLogger {
    if (!logger) {
        Class clazz = NSClassFromString(@"WJLogger");
        if (clazz) {
            if ([clazz conformsToProtocol:@protocol(IWJLogger)]) {
                logger = [[clazz alloc] init];
            } else {
                NSString *reason = [NSString stringWithFormat:@"无法创建Logger,因为 WJLogger 没有实现协议IWJLogger"];
                @throw [NSException exceptionWithName:@"WJLoggerFactoryException" reason:reason userInfo:@{@"WJLoggerClassName":@"WJLogger"}];
            }
        }
    }
    return logger;
}

@end