//
//  WJVersionUtils.h
//  WJCommon-master
//
//  Created by 吴云海 on 16/9/24.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WJ_OS_VERSION_GREATER_THAN(version)              [WJVersionUtils currentSystemVersionGreaterThan:version]
#define WJ_OS_VERSION_GREATER_THAN_OR_EQUAL(version)     [WJVersionUtils currentSystemVersionGreaterThanOrEqual:version]
#define WJ_OS_VERSION_LESS_THAN(version)                 [WJVersionUtils currentSystemVersionLessThan:version]
#define WJ_OS_VERSION_LESS_THAN_OR_EQUAL(version)        [WJVersionUtils currentSystemVersionLessThanOrEqual:version]

@interface WJVersionUtils : NSObject

/**
 *  当前版本大于等于version
 *
 *  @param version 版本号
 *
 *  @return 当前系统版本是否大于version
 */
+ (BOOL)currentSystemVersionGreaterThan:(NSString*)version;

/**
 *  当前版本大于等于version
 *
 *  @param version 版本号
 *
 *  @return 当前系统版本是否大于或等于version
 */
+ (BOOL)currentSystemVersionGreaterThanOrEqual:(NSString*)version;

/**
 *  当前系统版本小于Version
 *
 *  @param version 版本号
 *
 *  @return 当前系统版本是否小于version
 */
+ (BOOL)currentSystemVersionLessThan:(NSString*)version;

/**
 *  当前系统版本小于或等于Version
 *
 *  @param version 版本号
 *
 *  @return 当前系统版本是否小于或等于version
 */
+ (BOOL)currentSystemVersionLessThanOrEqual:(NSString*)version;

@end
