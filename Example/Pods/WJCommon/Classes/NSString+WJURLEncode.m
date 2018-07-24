//
//  NSString+WJURLEncode.m
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

#import "NSString+WJURLEncode.h"

@implementation NSString (WJURLEncode)

+(NSString *)wj_urlEncode:(NSString *)s {
    return [s stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

+(NSString *)wj_urlDecode:(NSString *)s {
    return [s stringByRemovingPercentEncoding];
}

@end
