//
//  NSData+WJArchive.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 16/1/12.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "NSData+WJArchive.h"
#import "WJLoggingMacros.h"

@implementation NSData (WJArchive)

+(NSData *)archivedDataWithRootObject:(id)object {
    NSData *data = nil;
    if (object) {
        @try {
            if ([[object class] conformsToProtocol:@protocol(NSCoding)]) {
                data = [NSKeyedArchiver archivedDataWithRootObject:object];
            } else {
                WJLogError(@"%@没有实现NSCoding协议",NSStringFromClass([object class]));
            }
        }
        @catch (NSException *exception) {
            data = nil;
            WJLogError(@"异常:%@",exception);
        }
    }
    return data;
}

+(id)unarchiveObjectWithData:(NSData *)data {
    id result = nil;
    if (data && [data length] > 0) {
        @try {
            result = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        @catch (NSException *exception) {
            result = nil;
            WJLogError(@"异常:%@",exception);
        }
    }
    return result;
}

@end
