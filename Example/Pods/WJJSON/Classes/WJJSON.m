//
//  WJJSON.m
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

#import "WJJSON.h"
#import "WJJSONObjectDesc.h"
#import "WJJSONUtils.h"

static NSDateFormatter *wjDateFormat = nil;

@implementation NSObject (WJConverter)

+(void)load {
    wjDateFormat = [[NSDateFormatter alloc] init];
}

-(NSDictionary *)wjDictionary {
    NSMutableDictionary *dict = nil;
    if ([[self class] conformsToProtocol:@protocol(IWJJSONObject)]) {
        dict = [[NSMutableDictionary alloc] init];
        WJJSONObjectDesc *objectDesc = [WJJSONUtils getJsonObjectDesc:self.class];
        NSArray *propertys = [objectDesc allPropertys];
        for (WJJSONPropertyDesc *desc in propertys) {
            if ([desc nonJson]) {
                continue;
            }
            id value = [self valueForKey:[desc name]];
            if (value && value != [NSNull null]) {
                id o = [[self class] toObjectValue:value propertyDesc:desc];
                if (o) {
                    [dict setObject:o forKey:desc.jsonName];
                }
            }
        }
    }
    return dict;
}

+(id) toObjectValue:(id) value propertyDesc:(WJJSONPropertyDesc*) desc {
    WJObjectType t = [desc type];
    id returnValue = nil;
    if (desc == nil) {
        t = [WJJSONUtils getType:value];
    }
    switch (t) {
        case WJObjectTypeArray:
            {
                Class genericClazz = [desc genericClass];
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (id o in value) {
                    if ([o isKindOfClass:[NSString class]] || [o isKindOfClass:[NSNumber class]]) {
                        [array addObject:o];
                    } else {
                        if (genericClazz) {
                            [array addObject:[o wjDictionary]];
                        } else {
                            [array addObject:[self toObjectValue:o propertyDesc:nil]];
                        }
                    }
                }
                returnValue = array;
            }
            break;
        case WJObjectTypeSet:
            {
                Class genericClazz = [desc genericClass];
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (id o in value) {
                    if ([o isKindOfClass:[NSString class]] || [o isKindOfClass:[NSNumber class]]) {
                        [array addObject:o];
                    } else {
                        if (genericClazz) {
                            [array addObject:[o wjDictionary]];
                        } else {
                            [array addObject:[self toObjectValue:o propertyDesc:nil]];
                        }
                    }
                }
                returnValue = array;
            }
            break;
        case WJObjectTypeDictionary:
            {
                NSDictionary *genericClazzDict = [desc genericClassDict];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                NSArray *keys = [value allKeys];
                for (NSString *key in keys) {
                    id v = value[key];
                    if ([v isKindOfClass:[NSString class]] || [v isKindOfClass:[NSNumber class]]) {
                        [dict setObject:v forKey:key];
                    } else {
                        Class genericClazz = genericClazzDict[key];
                        if (genericClazz) {
                            [dict setObject:[v wjDictionary] forKey:key];
                        } else {
                            [dict setObject:[self toObjectValue:v propertyDesc:nil] forKey:key];
                        }
                    }
                }
                returnValue = dict;
            }
            break;
        case WJObjectTypeDate:
            {
                NSString *dfs = [desc dateFormat];
                if (dfs) {
                    [wjDateFormat setDateFormat:dfs];
                    returnValue = [wjDateFormat stringFromDate:value];
                } else {
                    returnValue = value;
                }
            }
            break;
        
        case WJObjectTypeNumber:
            {
                returnValue = value;
            }
            break;
        case WJObjectTypeString:
            {
                returnValue = value;
            }
            break;
        case WJObjectTypeCustom:
            {
                returnValue = [value wjDictionary];
            }
            break;
        default:
            {
                returnValue = value; //WJObjectTypeObject  对象类型如果不是实现了IWJJSONObject 协议则忽略转换
            }
            break;
    }
    
    return returnValue;
}

+(id) fromObject:(id) value propertyDesc:(WJJSONPropertyDesc*) desc {
    WJObjectType t = desc.type;
    id returnValue = nil;
    if (!desc) {
        t = [WJJSONUtils getType:value];
    }
    switch (t) {
        case WJObjectTypeArray:
            {
                Class genericClazz = [desc genericClass];
                NSMutableArray *array = [[NSMutableArray alloc] init];
                for (id o in value) {
                    if (genericClazz) {
                        id v = [[genericClazz alloc] wjInitWithDictionary:o];
                        if (v) {
                            [array addObject:v];
                        }
                    } else {
                        id v = [self fromObject:o propertyDesc:nil];
                        if (v) {
                            [array addObject:v];
                        }
                    }
                }
                returnValue = array;
            }
            break;
        case WJObjectTypeSet:
            {
                Class genericClazz = [desc genericClass];
                NSMutableSet *set = [[NSMutableSet alloc] init];
                for (id o in value) {
                    if (genericClazz) {
                        id v = [[genericClazz alloc] wjInitWithDictionary:o];
                        if (v) {
                            [set addObject:v];
                        }
                    } else {
                        id v = [self fromObject:o propertyDesc:nil];
                        if (v) {
                            [set addObject:v];
                        }
                    }
                }
                returnValue = set;
            }
            break;
        case WJObjectTypeDate:
            {
                NSString *dfs = [desc dateFormat];
                if (dfs) {
                    [wjDateFormat setDateFormat:dfs];
                    returnValue = [wjDateFormat stringFromDate:value];
                }
            }
            break;
        case WJObjectTypeNumber:
            {
                returnValue = value;
            }
            break;
        case WJObjectTypeString:
            {
                returnValue = value;
            }
            break;
        case WJObjectTypeDictionary:
            {
                NSDictionary *genericClazzDict = [desc genericClassDict];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                NSArray *allKeys = [value allKeys];
                for (NSString *key in allKeys) {
                    id o = value[key];
                    Class genericClazz = genericClazzDict[key];
                    id v = nil;
                    if (genericClazz && [o isKindOfClass:[NSDictionary class]]) {
                        v = [[genericClazz alloc] wjInitWithDictionary:o];
                    } else {
                        v = [self fromObject:o propertyDesc:nil];
                    }
                    if (v) {
                        [dict setObject:v forKey:key];
                    }
                }
                returnValue = dict;
            }
            break;
        case WJObjectTypeCustom:
            {
                Class clazz = NSClassFromString(desc.typeName);
                returnValue = [[clazz alloc] wjInitWithDictionary:value];
            }
            break;
        default:
            {
                returnValue = value; //WJObjectTypeObject
            }
            break;
    }
    return returnValue;
}

-(instancetype)wjInitWithDictionary:(NSDictionary *)dictionary {
    if ([self init]) {
        WJJSONObjectDesc *objectDesc = [WJJSONUtils getJsonObjectDesc:self.class];
        NSArray *allPropertys = [objectDesc allPropertys];
        for (WJJSONPropertyDesc *property in allPropertys) {
            id value = dictionary[property.jsonName];
            if (value && value != [NSNull null]) {
                if ([property hasCusHandle]) {
                    [self wjCustomParseProperty:property.name value:value];
                } else {
                    id returnValue = [[self class] fromObject:value propertyDesc:property];
                    if (returnValue && (returnValue != [NSNull null])) {
                        [self setValue:returnValue forKey:property.name];
                    }
                }
            }
        }
    }
    return self;
}

@end

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

@implementation WJJSON

+(NSData*) toJson:(id) object {
    if (object) {
        id o = object;
        if (![NSJSONSerialization isValidJSONObject:object]) {
            o = [self toObjectValue:object propertyDesc:nil];
        }
        if (o) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:o options:NSJSONWritingPrettyPrinted error:&error];
            if (error) {
                @throw [NSException exceptionWithName:@"WJJSONException" reason:[error userInfo][NSLocalizedDescriptionKey] userInfo:[error userInfo]];
            } else {
                return jsonData;
            }
        }
    }
    return nil;
}
 +(NSString*) toJsonString:(id) object {
    NSData *data = [self toJson:object];
    if (data) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+(id) fromJsonString:(NSString*) json type:(Class) type {
    if (json) {
        return [self fromJsonData:[json dataUsingEncoding:NSUTF8StringEncoding] type:type];
    }
    return nil;
}

+(id)fromJsonData:(NSData *)json type:(Class)type {
    if (json) {
        if ([type conformsToProtocol:@protocol(IWJJSONObject)]) {
            NSError *error;
            id o = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                @throw [NSException exceptionWithName:@"WJJSONException" reason:[error userInfo][NSLocalizedDescriptionKey] userInfo:[error userInfo]];
            } else {
                if (![o isKindOfClass:[NSDictionary class]]) {
                    NSString *reason = [NSString stringWithFormat:@"%@ 类型无法解析此json",NSStringFromClass(type)];
                    @throw [NSException exceptionWithName:@"WJJSONException" reason:reason userInfo:@{NSLocalizedDescriptionKey:reason}];
                } else {
                    return [[type alloc] wjInitWithDictionary:o];
                }
            }
        } else {
            NSString *reason = @"非IWJJSONObject对象";
            @throw [NSException exceptionWithName:@"WJJSONException" reason:reason userInfo:@{NSLocalizedDescriptionKey:reason}];
        }
    }
    return nil;
}

+(id) fromJsonString:(NSString*) json groupType:(WJJSONGroupType*) groupType {
    if (json) {
        return [self fromJsonData:[json dataUsingEncoding:NSUTF8StringEncoding] groupType:groupType];
    }
    return nil;
}

+(id) fromJsonData:(NSData*) json groupType:(WJJSONGroupType*) groupType {
    if (json) {
        NSError *error = nil;
        id o = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            @throw [NSException exceptionWithName:@"WJJSONException" reason:[error userInfo][NSLocalizedDescriptionKey] userInfo:[error userInfo]];
        } else {
            if (![o isKindOfClass:[NSArray class]]) {
                NSString *reason = [NSString stringWithFormat:@"%@ 类型无法解析此json",NSStringFromClass([groupType collectionClass])];
                @throw [NSException exceptionWithName:@"WJJSONException" reason:reason userInfo:@{NSLocalizedDescriptionKey:reason}];
            } else {
                Class elementClass = [groupType elementClass];
                if ([[groupType collectionClass] isSubclassOfClass:[NSArray class]]) {
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    for (id item in o) {
                        if ([item isKindOfClass:[NSDictionary class]]) {
                            [array addObject:[[elementClass alloc] wjInitWithDictionary:item]];
                        } else {
                            [array addObject:item];
                        }
                    }
                    return array;
                } else if ([[groupType collectionClass] isSubclassOfClass:[NSSet class]]) {
                    NSMutableSet *set = [[NSMutableSet alloc] init];
                    for (id item in o) {
                        if ([item isKindOfClass:[NSDictionary class]]) {
                            [set addObject:[[elementClass alloc] wjInitWithDictionary:item]];
                        } else {
                            [set addObject:item];
                        }
                    }
                    return set;
                }
            }
        }
    }
    return nil;
}

+(id) fromJsonString:(NSString*) json {
    if (json) {
        return [self fromJsonData:[json dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return nil;
}

+(id) fromJsonData:(NSData*)jsonData {
    if (jsonData) {
        NSError *error = nil;
        id o = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            @throw [NSException exceptionWithName:@"WJJSONException" reason:[error userInfo][NSLocalizedDescriptionKey] userInfo:[error userInfo]];
        } else {
            return o;
        }
    }
    return nil;
}

@end
