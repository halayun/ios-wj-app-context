
//
//  WJValidUtils.m
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

#import "WJValidUtils.h"

@implementation WJValidUtils

/**
 *  是否为电话号码
 */
+ (BOOL)isTelephone:(NSString*) str {
    if (str) {
        NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
        NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
        NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
        NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
        NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
        
        return  [regextestmobile evaluateWithObject:str]   ||
        [regextestphs evaluateWithObject:str]      ||
        [regextestct evaluateWithObject:str]       ||
        [regextestcu evaluateWithObject:str]       ||
        [regextestcm evaluateWithObject:str];
    }
    return NO;
}

+ (BOOL)isMobilephone:(NSString*) str {
    if (str) {
        NSString * MOBILE = @"^[1-9]\\d{10}$";
        NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        return  [regextestMobile evaluateWithObject:str];
    }
    return NO;
}

+ (BOOL)isUserName:(NSString*) str {
    if (str) {
        NSString *		regex = @"(^[A-Za-z0-9]{3,20}$)";
        NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        return [pred evaluateWithObject:str];
    }
    return NO;
}


+ (BOOL)isChineseUserName:(NSString*) str {
    if (str) {
        NSString *		regex = @"(^[A-Za-z0-9\u4e00-\u9fa5]{3,20}$)";
        NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        return [pred evaluateWithObject:str];
    }
    return NO;
}

+ (BOOL)isChineseName:(NSString*) str {
    if (str) {
        NSString *		regex = @"(^[\u4e00-\u9fa5]{2,16}$)";
        NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        return [pred evaluateWithObject:str];
    }
    return NO;
}

+ (BOOL)isPassword:(NSString*) str {
    if (str) {
        NSString *		regex = @"(^[A-Za-z0-9]{6,20}$)";
        NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        return [pred evaluateWithObject:str];
    }
    return NO;
}

+ (BOOL)isEmail:(NSString*) str {
    if (str) {
        NSString *		regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        return [pred evaluateWithObject:str];
    }
    return NO;
}

+ (BOOL)isUrl:(NSString*) str {
    if (str) {
        NSString *		regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
        NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        return [pred evaluateWithObject:str];
    }
    return NO;
}

+ (BOOL)isIPAddress:(NSString*) str {
    if (!str) {
        return NO;
    }
    NSArray *			components = [str componentsSeparatedByString:@"."];
    NSCharacterSet *	invalidCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    
    if ( [components count] == 4 )
    {
        NSString *part1 = [components objectAtIndex:0];
        NSString *part2 = [components objectAtIndex:1];
        NSString *part3 = [components objectAtIndex:2];
        NSString *part4 = [components objectAtIndex:3];
        
        if ( [part1 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part2 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part3 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part4 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound )
        {
            if ( [part1 intValue] < 255 &&
                [part2 intValue] < 255 &&
                [part3 intValue] < 255 &&
                [part4 intValue] < 255 )
            {
                return YES;
            }
        }
    }
    
    return NO;
}

@end
