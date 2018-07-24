//
//  BaseWJObject.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/29.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "BaseWJObject.h"
#import "WJJSONUtils.h"
#import "WJLoggerFactory.h"

@implementation BaseWJObject

#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
    id copyObject = [[[self class] allocWithZone:zone] init];
    NSArray *allPropertys = [[WJJSONUtils getJsonObjectDesc:self.class] allPropertys];
    for (WJJSONPropertyDesc *desc in allPropertys) {
        @try {
            id value = [self valueForKey:desc.name];
            if (value != nil && (NSNull*)value != [NSNull null]) {
                if ([value isKindOfClass:[NSNumber class]]) {
                    [copyObject setValue:value forKey:desc.name];
                } else if ([value isKindOfClass:[NSMutableArray class]] || [value isKindOfClass:[NSMutableSet class]] || [value isKindOfClass:[NSMutableDictionary class]]) {
                    [copyObject setValue:[value mutableCopyWithZone:zone] forKey:desc.name];
                }else {
                    [copyObject setValue:[value copyWithZone:zone] forKey:desc.name];
                }
            }
        }
        @catch (NSException *exception) {
            WJLogError(@"copyWithZone:exception:%@",exception);
        }
    }
    return copyObject;
}
#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *allPropertys = [[WJJSONUtils getJsonObjectDesc:self.class] allPropertys];
    for (WJJSONPropertyDesc *desc in allPropertys) {
        @try {
            [aCoder encodeObject:[self valueForKey:desc.name] forKey:desc.name];
        }
        @catch (NSException *exception) {
            WJLogError(@"encodeWithCoder:exception:%@",exception);
        }
    }
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        NSArray *allPropertys = [[WJJSONUtils getJsonObjectDesc:self.class] allPropertys];
        for (WJJSONPropertyDesc *desc in allPropertys) {
            id value = [aDecoder decodeObjectForKey:desc.name];
            if (value != nil && (NSNull*)value != [NSNull null]) {
                @try {
                    [self setValue:value forKey:desc.name];
                }
                @catch (NSException *exception) {
                    WJLogError(@"initWithCoder:exception:%@",exception);
                }
                
            }
        }
    }
    return self;
}
#pragma override NSObject
-(NSString *)description {
    NSMutableString *string = [[NSMutableString alloc] init];
    NSArray *allPropertys = [[WJJSONUtils getJsonObjectDesc:self.class] allPropertys];
    [string appendString:@"("];
    for (WJJSONPropertyDesc *desc in allPropertys) {
        @try {
            [string appendFormat:@"%@:%@,",desc.name,[self valueForKey:desc.name]];
        }
        @catch (NSException *exception) {
            [string appendFormat:@"%@:%@,",desc.name,@"null"];
        }
    }
    [string appendString:@")"];
    return [NSString stringWithFormat:@"%@:%@",NSStringFromClass([self class]),string];
}
@end
