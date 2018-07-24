//
//  WJStringUtils.h
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


#define WJ_STRING_EQUAL(str1, str2)            [WJStringUtils equal:str1 str:str2]
#define WJ_STRING_IS_BLANK(str)                [WJStringUtils isBlank:str]
#define WJ_STRING_IS_NOT_BLANK(str)            [WJStringUtils isNotBlank:str]
#define WJ_STRING_IS_EMPTY(str)                [WJStringUtils isEmpty:str]
#define WJ_STRING_IS_NOT_EMPTY(str)            [WJStringUtils isNotEmpty:str]
#define WJ_STRING_SPLIT(str,separator)         [WJStringUtils split:str separator:separator]
#define WJ_STRING_JOIN(strList,separator)      [WJStringUtils join:strList separator:separator]


/**
 *  字符串 工具类
 */
@interface WJStringUtils : NSObject

/**
 *  字符串是否为空串
 *
 *  @param string 判断字符串
 *
 *  @return 判断结果（YES:nil、“”）
 */
+(BOOL) isBlank:(NSString*) str;

/**
 *  字符串是否为空
 *
 *  @param string 判断字符串
 *
 *  @return 判断结果（YES:[NSNull null]、null、(null)、nil、“”）
 */
+(BOOL) isEmpty:(NSString*) str;

/**
 *  字符串是否不为空串
 *
 *  @param string 判断字符串
 *
 *  @return 判断结果（YES:nil、“”）
 */
+(BOOL) isNotBlank:(NSString*) str;

/**
 *  字符串是否不为空
 *
 *  @param string 判断字符串
 *
 *  @return 判断结果（YES:[NSNull null]、null、(null)、nil、“”）
 */
+(BOOL) isNotEmpty:(NSString*) str;

/**
 *  比较字符串
 *
 *  @param str1 字符串1
 *  @param str2 字符串2
 *
 *  @return 结果
 */
+(BOOL) equal:(NSString*) str1 str:(NSString*) str2;

/**
 *  分拆字符串
 *
 *  @param str       被分拆字符串
 *  @param separator 分拆符
 *
 *  @return 分拆结果
 */
+(NSArray*) split:(NSString*) str separator:(NSString*) separator;

/**
 *  连接字符串数组
 *
 *  @param strs       字符串列表
 *  @param separator 连接符
 *
 *  @return 连接字符串结果
 */
+(NSString*) join:(NSArray*) strs separator:(NSString*) separator;

@end
