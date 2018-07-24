//
//  BaseWJEnum.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/11/25.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import "BaseWJEnum.h"

@interface BaseWJEnum ()
@property (nonatomic, copy) NSString *name;//枚举名称
@property (nonatomic, assign) NSInteger value;//枚举值（主要比对值）
@end

@implementation BaseWJEnum

-(instancetype)initWithValue:(NSInteger)value name:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
        self.value = value;
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    BOOL result = NO;
    if (object && [object isMemberOfClass:self.class]) {
        BaseWJEnum *comObject = (BaseWJEnum*) object;
        if (self.value == [comObject value]) {
            result = YES;
        }
    }
    return result;
}

-(NSUInteger)hash {
    return @(_value).hash;
}

#pragma mark IWJEnum
-(NSInteger)value {
    return _value;
}

-(NSString *)name {
    return _name;
}

+(NSSet *)values {
    return [NSSet set];
}

+(id<IWJEnum>)getEnumByValue:(NSInteger)value {
    id<IWJEnum> result = nil;
    NSSet *values = [self values];
    for (id<IWJEnum> o in values) {
        if ([o value] == value) {
            result = o;
            break;
        }
    }
    return result;
}

@end
