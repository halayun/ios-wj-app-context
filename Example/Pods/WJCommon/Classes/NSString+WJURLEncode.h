//
//  NSString+WJURLEncode.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 16/1/15.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>


#define WJ_STRING_URL_ENCODE(s)       [NSString wj_urlEncode:s]
#define WJ_STRING_URL_DECODE(s)       [NSString wj_urlDecode:s]

/**
 *  URL Encode
 */
@interface NSString (WJURLEncode)


/**
 *  Encode（默认UTF8编码格式）
 */
+(NSString*) wj_urlEncode:(NSString*) url;

/**
 *  Decode（默认UTF8编码格式）
 */
+(NSString*) wj_urlDecode:(NSString*) url;


@end
