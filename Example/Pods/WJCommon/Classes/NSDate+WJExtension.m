//
//  NSDate+WJExtension.m
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

#import "NSDate+WJExtension.h"

@implementation NSDate (WJExtension)
- (NSInteger)wj_year
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitYear fromDate:self];
    return component.year;
}

- (NSInteger)wj_month
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitMonth
                                              fromDate:self];
    return component.month;
}

- (NSInteger)wj_day
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitDay
                                              fromDate:self];
    return component.day;
}

- (NSInteger)wj_weekday
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return component.weekday;
}

- (NSInteger)wj_weekOfYear
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekOfYear fromDate:self];
    return component.weekOfYear;
}

- (NSInteger)wj_hour
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitHour
                                              fromDate:self];
    return component.hour;
}

- (NSInteger)wj_minute
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitMinute
                                              fromDate:self];
    return component.minute;
}

- (NSInteger)wj_second
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *component = [calendar components:NSCalendarUnitSecond
                                              fromDate:self];
    return component.second;
}

- (NSDate *)wj_dateByIgnoringTimeComponents
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate *)wj_firstDayOfMonth
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth| NSCalendarUnitDay fromDate:self];
    components.day = 1;
    return [calendar dateFromComponents:components];
}

- (NSDate *)wj_lastDayOfMonth
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.month++;
    components.day = 0;
    return [calendar dateFromComponents:components];
}

- (NSDate *)wj_firstDayOfWeek
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *componentsToSubtract = [NSDateComponents wj_sharedDateComponents];
    componentsToSubtract.day = - (weekdayComponents.weekday - calendar.firstWeekday);
    NSDate *beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:beginningOfWeek];
    beginningOfWeek = [calendar dateFromComponents:components];
    componentsToSubtract.day = NSIntegerMax;
    return beginningOfWeek;
}

- (NSDate *)wj_middleOfWeek
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *componentsToSubtract = [NSDateComponents wj_sharedDateComponents];
    componentsToSubtract.day = - (weekdayComponents.weekday - calendar.firstWeekday) + 3;
    NSDate *middleOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:middleOfWeek];
    middleOfWeek = [calendar dateFromComponents:components];
    componentsToSubtract.day = NSIntegerMax;
    return middleOfWeek;
}

- (NSDate *)wj_tomorrow
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.day++;
    return [calendar dateFromComponents:components];
}

- (NSDate *)wj_yesterday
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    components.day--;
    return [calendar dateFromComponents:components];
}

- (NSInteger)wj_numberOfDaysInMonth
{
    NSCalendar *c = [NSCalendar wj_sharedCalendar];
    NSRange days = [c rangeOfUnit:NSCalendarUnitDay
                           inUnit:NSCalendarUnitMonth
                          forDate:self];
    return days.length;
}

+ (instancetype)wj_dateFromString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter wj_sharedDateFormatter];
    formatter.dateFormat = format;
    return [formatter dateFromString:string];
}

+ (instancetype)wj_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [NSDateComponents wj_sharedDateComponents];
    components.year = year;
    components.month = month;
    components.day = day;
    NSDate *date = [calendar dateFromComponents:components];
    components.year = NSIntegerMax;
    components.month = NSIntegerMax;
    components.day = NSIntegerMax;
    return date;
}

- (NSDate *)wj_dateByAddingYears:(NSInteger)years
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [NSDateComponents wj_sharedDateComponents];
    components.year = years;
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    components.year = NSIntegerMax;
    return date;
}

- (NSDate *)wj_dateBySubtractingYears:(NSInteger)years
{
    return [self wj_dateByAddingYears:-years];
}

- (NSDate *)wj_dateByAddingMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [NSDateComponents wj_sharedDateComponents];
    components.month = months;
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    components.month = NSIntegerMax;
    return date;
}

- (NSDate *)wj_dateBySubtractingMonths:(NSInteger)months
{
    return [self wj_dateByAddingMonths:-months];
}

- (NSDate *)wj_dateByAddingWeeks:(NSInteger)weeks
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [NSDateComponents wj_sharedDateComponents];
    components.weekOfYear = weeks;
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    components.weekOfYear = NSIntegerMax;
    return date;
}

-(NSDate *)wj_dateBySubtractingWeeks:(NSInteger)weeks
{
    return [self wj_dateByAddingWeeks:-weeks];
}

- (NSDate *)wj_dateByAddingDays:(NSInteger)days
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [NSDateComponents wj_sharedDateComponents];
    components.day = days;
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    components.day = NSIntegerMax;
    return date;
}

- (NSDate *)wj_dateBySubtractingDays:(NSInteger)days
{
    return [self wj_dateByAddingDays:-days];
}

- (NSInteger)wj_yearsFrom:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.year;
}

- (NSInteger)wj_monthsFrom:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.month;
}

- (NSInteger)wj_weeksFrom:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekOfYear
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.weekOfYear;
}

- (NSInteger)wj_daysFrom:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar wj_sharedCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                               fromDate:date
                                                 toDate:self
                                                options:0];
    return components.day;
}

- (NSString *)wj_stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter wj_sharedDateFormatter];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *)wj_string
{
    return [self wj_stringWithFormat:@"yyyyMMdd"];
}


- (BOOL)wj_isEqualToDateForMonth:(NSDate *)date
{
    return self.wj_year == date.wj_year && self.wj_month == date.wj_month;
}

- (BOOL)wj_isEqualToDateForWeek:(NSDate *)date
{
    return self.wj_year == date.wj_year && self.wj_weekOfYear == date.wj_weekOfYear;
}

- (BOOL)wj_isEqualToDateForDay:(NSDate *)date
{
    return self.wj_year == date.wj_year && self.wj_month == date.wj_month && self.wj_day == date.wj_day;
}
@end


@implementation NSCalendar (WJExtension)

+ (instancetype)wj_sharedCalendar
{
    static id instance;
    static dispatch_once_t wj_sharedCalendar_onceToken;
    dispatch_once(&wj_sharedCalendar_onceToken, ^{
        instance = [NSCalendar currentCalendar];
    });
    return instance;
}

@end


@implementation NSDateFormatter (WJExtension)

+ (instancetype)wj_sharedDateFormatter
{
    static id instance;
    static dispatch_once_t wj_sharedDateFormatter_onceToken;
    dispatch_once(&wj_sharedDateFormatter_onceToken, ^{
        instance = [[NSDateFormatter alloc] init];
    });
    return instance;
}

@end

@implementation NSDateComponents (WJExtension)

+ (instancetype)wj_sharedDateComponents
{
    static id instance;
    static dispatch_once_t wj_sharedDateFormatter_onceToken;
    dispatch_once(&wj_sharedDateFormatter_onceToken, ^{
        instance = [[NSDateComponents alloc] init];
    });
    return instance;
}

@end