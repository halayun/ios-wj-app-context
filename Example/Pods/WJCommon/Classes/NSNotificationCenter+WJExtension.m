//
//  NSNotificationCenter+WJExtension.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 16/1/4.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "NSNotificationCenter+WJExtension.h"

@implementation NSNotificationCenter (WJExtension)

+(void)wj_postNotificationOnMainThread:(NSNotification *)notification {
    if ([NSThread isMainThread]) return [self wj_postNotification:notification];
    [self wj_postNotificationOnMainThread:notification waitUntilDone:NO];
}

+(void)wj_postNotificationOnMainThread:(NSNotification *)notification
                      waitUntilDone:(BOOL)wait {
    if ([NSThread isMainThread]) return [self wj_postNotification:notification];
    [self performSelectorOnMainThread:@selector(wj_postNotification:) withObject:notification waitUntilDone:wait];
}

+(void)wj_postNotificationOnMainThreadWithName:(NSString *)name object:(id)object {
    if ([NSThread isMainThread]) {
        return [[self defaultCenter] postNotificationName:name object:object];
    }
    [self wj_postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
}

+(void)wj_postNotificationOnMainThreadWithName:(NSString *)name
                                     object:(id)object
                                   userInfo:(NSDictionary *)userInfo {
    if ([NSThread isMainThread]) {
        return [[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
    }
    [self wj_postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
}


+(void)wj_postNotificationOnMainThreadWithName:(NSString *)name
                                     object:(id)object
                                   userInfo:(NSDictionary *)userInfo
                              waitUntilDone:(BOOL)wait {
    if ([NSThread isMainThread]) {
        return [[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
    }
    NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if (name) [info setObject:name forKey:@"name"];
    if (object) [info setObject:object forKey:@"object"];
    if (userInfo) [info setObject:userInfo forKey:@"userInfo"];
    [self performSelectorOnMainThread:@selector(wj_postNotificationName:) withObject:info waitUntilDone:wait];
}

+(void) wj_postNotification:(NSNotification *)notification {
    [[self defaultCenter] postNotification:notification];
}

+(void) wj_postNotificationName:(NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    [[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

@end
