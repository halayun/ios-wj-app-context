//
//  WJJSONObjectDesc.m
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

#import "WJJSONObjectDesc.h"
#import "IWJJSONObject.h"

@implementation WJJSONPropertyDesc

-(void)setTypeName:(NSString *)typeName {
    _typeName = [typeName copy];
    if ([typeName isEqualToString:@"NSDate"]) {
        _type = WJObjectTypeDate;
    } else if ([typeName isEqualToString:@"NSString"]) {
        _type = WJObjectTypeString;
    } else if ([typeName isEqualToString:@"NSNumber"]) {
        _type = WJObjectTypeNumber;
    } else if ([typeName isEqualToString:@"NSSet"]) {
        _type = WJObjectTypeSet;
    } else if ([typeName isEqualToString:@"NSArray"]) {
        _type = WJObjectTypeArray;
    } else if ([typeName isEqualToString:@"NSDictionary"]) {
        _type = WJObjectTypeDictionary;
    } else {
        if ([NSClassFromString(typeName) conformsToProtocol:@protocol(IWJJSONObject)]) {
            _type = WJObjectTypeCustom;
        } else {
            _type = WJObjectTypeObject;
        }
    }
}

-(instancetype) initWithName:(NSString*) name typeName:(NSString*) typeName jsonName:(NSString*) jsonName nonJson:(BOOL) nonJson customHandle:(BOOL) cusHandle {
    self = [super init];
    if (self) {
        self.name = name;
        self.typeName = typeName;
        self.jsonName = jsonName;
        self.nonJson = nonJson;
        self.hasCusHandle = cusHandle;
    }
    return self;
}

-(BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[WJJSONPropertyDesc class]]) {
        if ([_name isEqualToString:[(WJJSONPropertyDesc*)object name]]) {
            return YES;
        }
    }
    return NO;
}

-(NSUInteger)hash {
    return _name.hash;
}

@end



@interface WJJSONObjectDesc ()

@property (nonatomic, copy) NSArray *propertys;

@property (nonatomic, strong) NSMutableDictionary *jnToPropertyDict;

@property (nonatomic, strong) NSMutableDictionary *nToPropertyDict;

@end
@implementation WJJSONObjectDesc

-(NSArray*) allPropertys {
    return _propertys;
}

-(WJJSONPropertyDesc*) getPropertyByName:(NSString*) propertyName {
    return _nToPropertyDict[propertyName];
}

-(WJJSONPropertyDesc*) getPropertyByJsonName:(NSString*) jsonName {
    return _jnToPropertyDict[jsonName];
}

-(instancetype) initWithProperty:(NSArray*) propertys {
    self = [super init];
    if (self) {
        self.propertys = propertys;
        if ([self.propertys count] > 0) {
            self.jnToPropertyDict = [[NSMutableDictionary alloc] init];
            self.nToPropertyDict = [[NSMutableDictionary alloc] init];
        }
        for (WJJSONPropertyDesc *desc in self.propertys) {
            [self.jnToPropertyDict setObject:desc forKey:[desc jsonName]];
            [self.nToPropertyDict setObject:desc forKey:[desc name]];
        }
    }
    return self;
}
@end
