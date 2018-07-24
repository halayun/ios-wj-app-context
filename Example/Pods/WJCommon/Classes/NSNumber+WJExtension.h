//
//  NSNumber+WJExtension.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/12/16.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (WJExtension)

- (void) wj_times:(void(^)(void))block;
- (void) wj_timesWithIndex:(void(^)(NSUInteger index))block;

- (void) wj_upto:(int)number do:(void(^)(NSInteger number))block;
- (void) wj_downto:(int)number do:(void(^)(NSInteger number))block;

// Numeric inflections
- (NSNumber *) wj_seconds;
- (NSNumber *) wj_minutes;
- (NSNumber *) wj_hours;
- (NSNumber *) wj_days;
- (NSNumber *) wj_weeks;
- (NSNumber *) wj_fortnights;
- (NSNumber *) wj_months;
- (NSNumber *) wj_years;

// There are singular aliases for the above methods
- (NSNumber *) wj_second;
- (NSNumber *) wj_minute;
- (NSNumber *) wj_hour;
- (NSNumber *) wj_day;
- (NSNumber *) wj_week;
- (NSNumber *) wj_fortnight;
- (NSNumber *) wj_month;
- (NSNumber *) wj_year;

- (NSDate *) wj_ago;
- (NSDate *) wj_ago:(NSDate *)time;
- (NSDate *) wj_since:(NSDate *)time;
- (NSDate *) wj_until:(NSDate *)time;
- (NSDate *) wj_fromNow;

@end
