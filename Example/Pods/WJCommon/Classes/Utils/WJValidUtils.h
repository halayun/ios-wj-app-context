//
//  WJValidUtils.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/17.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WJ_VALID_IS_TEL(str)                 [WJValidUtils isTelephone:str]
#define WJ_VALID_IS_MOBILE_PHONE(str)        [WJValidUtils isMobilephone:str]
#define WJ_VALID_IS_USER_NAME(str)           [WJValidUtils isUserName:str]
#define WJ_VALID_IS_CHINESE_USER_NAME(str)   [WJValidUtils isChineseUserName:str]
#define WJ_VALID_IS_CHINESE_NAME(str)        [WJValidUtils isChineseName:str]
#define WJ_VALID_IS_PASSWORD(str)            [WJValidUtils isPassword:str]
#define WJ_VALID_IS_EMAIL(str)               [WJValidUtils isEmail:str]
#define WJ_VALID_IS_URL(str)                 [WJValidUtils isUrl:str]
#define WJ_VALID_IS_IP_ADDRESS(str)          [WJValidUtils isIPAddress:str]

/**
 *  验证工具类
 */
@interface WJValidUtils : NSObject

/**
 *  是否为电话号码
 */
+ (BOOL)isTelephone:(NSString*) str;
/**
 *  是否为手机号
 */
+ (BOOL)isMobilephone:(NSString*) str;

/**
 *  是否为有效用户名(match alphabet 3-20)
 */
+ (BOOL)isUserName:(NSString*) str;

/**
 *  是否为中文名称（包含拼音和汉字）
 */
+ (BOOL)isChineseUserName:(NSString*) str;

/**
 *  是否为中文名称（只匹配汉字）
 */
+ (BOOL)isChineseName:(NSString*) str;

/**
 *  是否为密码（6-20位）
 */
+ (BOOL)isPassword:(NSString*) str;

/**
 *  是否为邮箱
 */
+ (BOOL)isEmail:(NSString*) str;

/**
 *  是否为URL
 */
+ (BOOL)isUrl:(NSString*) str;

/**
 *  是否为ip地址
 */
+ (BOOL)isIPAddress:(NSString*) str;


@end
