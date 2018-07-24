//
//  IWJSession.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/11/2.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IWJToken.h"

/**
 *  用户登录通知
 */
extern NSString * const UserLoginedNotification;

/**
 *  用户注销通知
 */
extern NSString * const UserLogoutNotification;

/**
 *  app回话（用户是否已登录，登出）
 */
@protocol IWJSession <NSObject>

/**
 *  token
 */
-(id<IWJToken>) getToken;

/**
 *  登录
 */
-(void) logined:(id<IWJToken>) token;

/**
 *  注销
 */
-(void) logout;

/**
 *  是否已登录
 */
-(BOOL) isLogined;

@end
