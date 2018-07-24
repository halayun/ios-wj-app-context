//
//  URLParamUtil.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/8/13.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "WJURLUtils.h"
#import "WJStringUtils.h"

@implementation WJURLUtils

+ (NSDictionary *) paramsWithFormURL:(NSString *) URL {
    if (!URL) {
        return nil;
    }
    NSArray *c1 = [URL componentsSeparatedByString:@"?"];
    NSString *paramsString = nil;
    if ([c1 count] == 2) {
        paramsString = c1[1];
    }
    if (paramsString) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        NSArray *pairs = [paramsString componentsSeparatedByString:@"&"];
        for (NSString *kvp in pairs) {
            if ([kvp length] == 0) {
                continue;
            }
            
            NSRange pos = [kvp rangeOfString:@"="];
            NSString *key;
            NSString *val;
            
            if (pos.location == NSNotFound) {
                key = [kvp stringByRemovingPercentEncoding];
                val = @"";
            } else {
                key = [[kvp substringToIndex:pos.location] stringByRemovingPercentEncoding];
                val = [[kvp substringFromIndex:pos.location + pos.length] stringByRemovingPercentEncoding];
            }
            if (!key || !val) {
                continue;
            }
            
            [result setObject:val forKey:key];
        }
        return result;
    }
    return nil;
}

+ (NSString *) stringWithFormParams:(NSDictionary*) params {
    if ([params count] > 0) {
        NSMutableArray *arguments = [NSMutableArray arrayWithCapacity:[params count]];
        [params enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
            [arguments addObject:[NSString stringWithFormat:@"%@=%@",
                                  [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]],
                                  [[object description] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
        }];
        return [arguments componentsJoinedByString:@"&"];
    }
    return nil;
}

+(NSString *)removeURLParams:(NSString *)URL {
    if ([WJStringUtils isNotBlank:URL]) {
        return [URL componentsSeparatedByString:@"?"][0];
    }
    return nil;
}

@end
