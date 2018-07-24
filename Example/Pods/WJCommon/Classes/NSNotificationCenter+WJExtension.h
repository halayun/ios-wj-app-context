//
//  NSNotificationCenter+WJExtension.h
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

#import <Foundation/Foundation.h>

//POST
#define WJ_NOTIFY_POST(notification)                                        [NSNotificationCenter wj_postNotificationOnMainThread:notification]
#define WJ_NOTIFY_POST_WAIT(notification,wait)                              [NSNotificationCenter wj_postNotificationOnMainThread:notification waitUntilDone:wait]
#define WJ_NOTIFY_POST_NAME_OBJECT(name,object)                             [NSNotificationCenter wj_postNotificationOnMainThreadWithName:name object:object]
#define WJ_NOTIFY_POST_NAME_OBJECT_USERINFO(name,object,userInfo)           [NSNotificationCenter wj_postNotificationOnMainThreadWithName:name object:object userInfo:userInfo]
#define WJ_NOTIFY_POST_NAME_OBJECT_USERINFO_WAIT(name,object,userInfo,wait) [NSNotificationCenter wj_postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:wait]

//REMOVE
#define WJ_NOTIFY_REMOVE(observer)                                          [[NSNotificationCenter defaultCenter] removeObserver:observer]
#define WJ_NOTIFY_REMOVE_NAME_OBJECT(observer,name,object)                  [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:object]

//ADD
#define WJ_NOTIFY_ADD_OBSERVER(observer,selector,name,object)               [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object]

@interface NSNotificationCenter (WJExtension)

+(void) wj_postNotificationOnMainThread:(NSNotification *)notification;

+(void) wj_postNotificationOnMainThread:(NSNotification *)notification
                         waitUntilDone:(BOOL)wait;

+(void) wj_postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object;

+(void) wj_postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object
                                    userInfo:(NSDictionary *)userInfo;

+(void) wj_postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object
                                    userInfo:(NSDictionary *)userInfo
                               waitUntilDone:(BOOL)wait;



@end
