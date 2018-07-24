//
//  NSDate+WJExtension.h
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

@interface NSDate (WJExtension)

@property (readonly, nonatomic) NSInteger wj_year;//年
@property (readonly, nonatomic) NSInteger wj_month;//月
@property (readonly, nonatomic) NSInteger wj_day;//天
@property (readonly, nonatomic) NSInteger wj_weekday;//星期
@property (readonly, nonatomic) NSInteger wj_weekOfYear;//一年的第几周
@property (readonly, nonatomic) NSInteger wj_hour;//时
@property (readonly, nonatomic) NSInteger wj_minute;//分
@property (readonly, nonatomic) NSInteger wj_second;//秒

@property (readonly, nonatomic) NSDate *wj_dateByIgnoringTimeComponents;
@property (readonly, nonatomic) NSDate *wj_firstDayOfMonth;
@property (readonly, nonatomic) NSDate *wj_lastDayOfMonth;
@property (readonly, nonatomic) NSDate *wj_firstDayOfWeek;
@property (readonly, nonatomic) NSDate *wj_middleOfWeek;
@property (readonly, nonatomic) NSDate *wj_tomorrow;
@property (readonly, nonatomic) NSDate *wj_yesterday;
@property (readonly, nonatomic) NSInteger wj_numberOfDaysInMonth;

+ (instancetype)wj_dateFromString:(NSString *)string format:(NSString *)format;
+ (instancetype)wj_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

- (NSDate *)wj_dateByAddingYears:(NSInteger)years;
- (NSDate *)wj_dateBySubtractingYears:(NSInteger)years;
- (NSDate *)wj_dateByAddingMonths:(NSInteger)months;
- (NSDate *)wj_dateBySubtractingMonths:(NSInteger)months;
- (NSDate *)wj_dateByAddingWeeks:(NSInteger)weeks;
- (NSDate *)wj_dateBySubtractingWeeks:(NSInteger)weeks;
- (NSDate *)wj_dateByAddingDays:(NSInteger)days;
- (NSDate *)wj_dateBySubtractingDays:(NSInteger)days;
- (NSInteger)wj_yearsFrom:(NSDate *)date;
- (NSInteger)wj_monthsFrom:(NSDate *)date;
- (NSInteger)wj_weeksFrom:(NSDate *)date;
- (NSInteger)wj_daysFrom:(NSDate *)date;

- (BOOL)wj_isEqualToDateForMonth:(NSDate *)date;
- (BOOL)wj_isEqualToDateForWeek:(NSDate *)date;
- (BOOL)wj_isEqualToDateForDay:(NSDate *)date;

- (NSString *)wj_stringWithFormat:(NSString *)format;
- (NSString *)wj_string;

@end



@interface NSCalendar (WJExtension)

+ (instancetype)wj_sharedCalendar;

@end

@interface NSDateFormatter (WJExtension)

+ (instancetype)wj_sharedDateFormatter;

@end

@interface NSDateComponents (WJExtension)

+ (instancetype)wj_sharedDateComponents;

@end
