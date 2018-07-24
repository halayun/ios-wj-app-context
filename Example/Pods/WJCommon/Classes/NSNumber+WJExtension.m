//
//  NSNumber+WJExtension.m
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

#import "NSNumber+WJExtension.h"

@implementation NSNumber (WJExtension)

- (void) wj_times:(void (^)(void))block {
    for (int i = 0; i < self.integerValue; i++)
        block();
}

- (void) wj_timesWithIndex:(void (^)(NSUInteger))block {
    for (int i = 0; i < self.unsignedIntegerValue; i++)
        block(i);
}

- (void) wj_upto:(int)number do:(void (^)(NSInteger))block {
    for (NSInteger i = self.integerValue; i <= number; i++)
        block(i);
}

- (void) wj_downto:(int)number do:(void (^)(NSInteger))block {
    for (NSInteger i = self.integerValue; i >= number; i--)
        block(i);
}

- (NSNumber *) wj_second {
    return self.wj_seconds;
}

- (NSNumber *) wj_seconds {
    return self;
}

- (NSNumber *) wj_minute {
    return self.wj_minutes;
}

- (NSNumber *) wj_minutes {
    return @(self.floatValue * 60);
}

- (NSNumber *)wj_hour {
    return self.wj_hours;
}

- (NSNumber *)wj_hours {
    return @(self.floatValue * [@60 wj_minutes].integerValue);
}

- (NSNumber *)wj_day {
    return self.wj_days;
}

- (NSNumber *)wj_days {
    return @(self.floatValue * [@24 wj_hours].integerValue);
}

- (NSNumber *)wj_week {
    return self.wj_weeks;
}

- (NSNumber *)wj_weeks {
    return @(self.floatValue * [@7 wj_days].integerValue);
}

- (NSNumber *)wj_fortnight {
    return self.wj_fortnights;
}

- (NSNumber *)wj_fortnights {
    return @(self.floatValue * [@2 wj_weeks].integerValue);
}

- (NSNumber *)wj_month {
    return self.wj_months;
}

- (NSNumber *)wj_months {
    return @(self.floatValue * [@30 wj_days].integerValue);
}

- (NSNumber *)wj_year {
    return self.wj_years;
}

- (NSNumber *)wj_years {
    return @(self.floatValue * [@(365.25) wj_days].integerValue);
}

- (NSDate *)wj_ago {
    return [self wj_ago:[NSDate date]];
}

- (NSDate *)wj_ago:(NSDate *)time {
    return [NSDate dateWithTimeIntervalSince1970:([time timeIntervalSince1970] - self.floatValue)];
}

- (NSDate *)wj_since:(NSDate *)time {
    return [NSDate dateWithTimeIntervalSince1970:([time timeIntervalSince1970] + self.floatValue)];
}

- (NSDate *)wj_until:(NSDate *)time {
    return [self wj_ago:time];
}

- (NSDate *)wj_fromNow {
    return [self wj_since:[NSDate date]];
}

@end
