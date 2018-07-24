//
//  WJSecurityUtils.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/30.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WJ_SECURITY_MD2(data)               [WJSecurityUtils MD2:data]
#define WJ_SECURITY_MD4(data)               [WJSecurityUtils MD4:data]
#define WJ_SECURITY_MD5(data)               [WJSecurityUtils MD5:data]
#define WJ_SECURITY_SHA1(data)              [WJSecurityUtils SHA1:data]
#define WJ_SECURITY_SHA224(data)            [WJSecurityUtils SHA224:data]
#define WJ_SECURITY_SHA256(data)            [WJSecurityUtils SHA256:data]
#define WJ_SECURITY_SHA384(data)            [WJSecurityUtils SHA384:data]
#define WJ_SECURITY_SHA512(data)            [WJSecurityUtils SHA512:data]
#define WJ_SECURITY_HEXADEDIMAL(data)       [WJSecurityUtils hexadedimalString:data]
#define WJ_SECURITY_ENCODING_BASE64(data)   [WJSecurityUtils base64:data]
#define WJ_SECURITY_DECODE_BASE64(base64)   [WJSecurityUtils dataWithBase64:base64]
#define WJ_SECURITY_HMACMD5(content,key)    [WJSecurityUtils HMACMD5:content secretKey:key]
/**
 *  安全工具类
 */
@interface WJSecurityUtils : NSObject

/**
 *  MD2 散列
 */
+ (NSString *) MD2:(NSData*) data;

/**
 *  MD4 散列
 */
+ (NSString *) MD4:(NSData*) data;

/**
 *  MD5 散列
 */
+ (NSString *) MD5:(NSData*) data;

/**
 *  SHA1 散列
 */
+ (NSString *) SHA1:(NSData*) data;

+ (NSString *) SHA224:(NSData*) data;

+ (NSString *) SHA256:(NSData*) data;

+ (NSString *) SHA384:(NSData*) data;

+ (NSString *) SHA512:(NSData*) data;

/**
 *  将NSData转换成十六进制字符串
 *
 *  @param data 数据
 *
 *  @return 字符串
 */
+ (NSString *) hexadedimalString:(NSData*) data;

+ (NSString *) base64:(NSData*) data;

+ (NSData *) dataWithBase64:(NSString *)base64String;

/**
 *  HMAC MD5
 *
 *  @param content 需要加密内容
 *  @param secret  密钥
 *
 *  @return 结果
 */
+ (NSString *) HMACMD5:(NSString*) content secretKey:(NSString*) secret;

@end
