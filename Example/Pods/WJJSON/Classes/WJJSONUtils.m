//
//  WJJSONUtils.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/9/9.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "WJJSONUtils.h"
#import "IWJJSONObject.h"
#import "NSObject+WJJSON.h"
#import <objc/runtime.h>

static NSMutableDictionary *cacheJsonObjectDescs = nil;

//忽略属性名称列表
static NSSet *ignorePropertyNames = nil;
//数字类型名称列表
static NSSet *numberTypeNames = nil;

static NSDictionary *objectTypeDict;

@implementation WJJSONUtils

+(void)load {
    cacheJsonObjectDescs = [[NSMutableDictionary alloc] init];
    ignorePropertyNames = [[NSSet alloc] initWithObjects:@"superclass",@"hash",@"debugDescription",@"description", nil];
    numberTypeNames = [[NSSet alloc] initWithObjects:@"B",@"i",@"I",@"d",@"D",@"c",@"C",@"f",@"l",@"L",@"s",@"S",@"q",@"Q", nil];
    objectTypeDict = @{@"NSString":@(WJObjectTypeString),
                  @"NSNumber":@(WJObjectTypeNumber),
                  @"NSSet":@(WJObjectTypeSet),
                  @"NSArray":@(WJObjectTypeArray),
                  @"NSDictionary":@(WJObjectTypeDictionary),
                  @"NSDate":@(WJObjectTypeDate),};
}

+(WJObjectType)getType:(id)value {
    WJObjectType t = WJObjectTypeObject;
    NSString *typeName = NSStringFromClass([value class]);
    NSNumber *n = objectTypeDict[typeName];
    if (n) {
        t = [n integerValue];
    } else if ([[value class] conformsToProtocol:@protocol(IWJJSONObject)]) {
        t = WJObjectTypeCustom;
    }
    return t;
}

+(WJJSONObjectDesc *)getJsonObjectDesc:(Class)clazz {
    WJJSONObjectDesc *objectDesc = nil;
//    if (clazz != Nil && [clazz conformsToProtocol:@protocol(IWJJSONObject)]) {
    if (clazz != Nil) {
        NSString *clazzName = NSStringFromClass(clazz);
        objectDesc = cacheJsonObjectDescs[clazzName];
        if (!objectDesc) {
            NSMutableArray *propertys = [self getPropertys:clazz];
            objectDesc = [[WJJSONObjectDesc alloc] initWithProperty:propertys];
            [cacheJsonObjectDescs setObject:objectDesc forKey:clazzName];
        }
    }
    return objectDesc;
}

+(NSMutableArray*) getPropertys:(Class) clazz {
    if (clazz == [NSObject class]) {
        return nil;
    } else {
        NSDictionary *map = [clazz wjPropertyToJsonPropertyDictionary];
        NSSet *customHandleSet = [clazz wjCustomParsePropertys];
        NSSet *nonJsonSet = [clazz wjNonJsonPropertys];
        NSDictionary *genericClassNameDict = [clazz wjContainerPropertysGenericClass];
        NSMutableArray *propertyList = [self getPropertys:[clazz superclass]];
        if (!propertyList) {
            propertyList = [[NSMutableArray alloc] init];
        }
        @autoreleasepool {
            unsigned int propertyCount = 0;
            objc_property_t *properties = class_copyPropertyList(clazz, &propertyCount);
            for (unsigned int i = 0; i < propertyCount; ++i) {
                objc_property_t property = properties[i];
                const char * name = property_getName(property);
                NSString *nameString = [NSString stringWithUTF8String:name];
                
                if ([ignorePropertyNames containsObject:nameString]) {
                    continue;
                }
                NSString *typeName = [self getPropertyTypeName:property];
                NSString *jsonName = map[nameString];
                if (!jsonName) {
                    jsonName = nameString;
                }
                BOOL isNonJson = NO;
                if ([nonJsonSet containsObject:nameString]) {
                    isNonJson = YES;
                }
                BOOL isCustomHandle = NO;
                if (customHandleSet && [customHandleSet containsObject:nameString]) {
                    isCustomHandle = YES;
                }
                WJJSONPropertyDesc *desc = [[WJJSONPropertyDesc alloc] initWithName:nameString typeName:typeName jsonName:jsonName nonJson:isNonJson customHandle:isCustomHandle];
                switch (desc.type) {
                    case WJObjectTypeDate:
                        {
                            NSString *df = [clazz wjPropertyDateFormatString:nameString];
                            [desc setDateFormat:df];
                        }
                        break;
                    default:
                        break;
                }
                
                switch (desc.type) {
                    case WJObjectTypeArray:
                        {
                            Class clazz = genericClassNameDict[nameString];
                            if ([clazz conformsToProtocol:@protocol(IWJJSONObject)]) {
                                [desc setGenericClass:clazz];
                            }
                        }
                        break;
                    case WJObjectTypeSet:
                        {
                            Class clazz = genericClassNameDict[nameString];
                            if ([clazz conformsToProtocol:@protocol(IWJJSONObject)]) {
                                [desc setGenericClass:clazz];
                            }
                        }
                        break;
                    case WJObjectTypeDictionary:
                        {
                            id value = genericClassNameDict[nameString];
                            if ([value isKindOfClass:[NSDictionary class]]) {
                                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                                NSArray *allKeys = [value allKeys];
                                for (NSString *key in allKeys) {
                                    Class clazz = value[key];
                                    if ([clazz conformsToProtocol:@protocol(IWJJSONObject)]) {
                                        [dict setObject:clazz forKey:key];
                                    }
                                }
                                if ([dict count] > 0) {
                                    [desc setGenericClassDict:dict];
                                }
                            }
                        }
                        break;
                    default:
                        break;
                }
                
                [propertyList addObject:desc];
            }
            free(properties);
        }
        return propertyList;
    }
}

+(NSString*) getPropertyTypeName:(objc_property_t) property {
    const char *attributes = property_getAttributes(property);
    NSString *attributeStr = [[NSString alloc] initWithBytes:attributes length:strlen(attributes) encoding:NSUTF8StringEncoding];
    NSString *a1 = [[[attributeStr componentsSeparatedByString:@","] objectAtIndex:0] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString *typeName = nil;
    if ([a1 hasPrefix:@"T@"]) {
        typeName = [[NSString alloc] initWithString:[a1 substringWithRange:NSMakeRange(2, a1.length-2)]];
    } else {
        if (a1.length >= 2) {
            typeName = [a1 substringWithRange:NSMakeRange(1, a1.length-1)];
            if ([numberTypeNames containsObject:typeName]) {
                typeName = @"NSNumber";
            }
        }
    }
    return typeName;
}

@end
