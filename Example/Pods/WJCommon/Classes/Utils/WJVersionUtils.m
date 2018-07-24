//
//  WJVersionUtils.m
//  WJCommon-master
//
//  Created by 吴云海 on 16/9/24.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "WJVersionUtils.h"
#import <UIKit/UIDevice.h>

@implementation WJVersionUtils

+(BOOL)currentSystemVersionGreaterThan:(NSString *)version {
    if (!version) {
        return NO;
    }
    return ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedDescending);
}

+(BOOL)currentSystemVersionGreaterThanOrEqual:(NSString *)version {
    if (!version) {
        return NO;
    }
    return ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] != NSOrderedAscending);
}

+(BOOL)currentSystemVersionLessThan:(NSString *)version {
    if (!version) {
        return NO;
    }
    return ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending);
}

+(BOOL)currentSystemVersionLessThanOrEqual:(NSString *)version {
    if (!version) {
        return NO;
    }
    return ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] != NSOrderedDescending);
}

@end
