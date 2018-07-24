//
//  WJJSON.h
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

#import <Foundation/Foundation.h>
#import "WJJSONGroupType.h"
#import "IWJJSONObject.h"
#import "NSObject+WJJSON.h"

@interface NSObject (WJConverter)

-(id) wjInitWithDictionary:(NSDictionary*) dictionary;

-(NSDictionary*) wjDictionary;

@end

/**
 *  JSON 解析入口
 */
@interface WJJSON : NSObject

/**
 *  将对象转成Json（可以直接解析NSDictionary，NSArray，NSObject）
 */
+(NSData*) toJson:(id) object;

/**
 *  将对象转成Json（可以直接解析NSDictionary，NSArray，NSObject）
 */
+(NSString*) toJsonString:(id) object;

/**
 *  解析Json
 */
+(id) fromJsonString:(NSString*) jsonString type:(Class) type;

/**
 *  解析Json
 */
+(id) fromJsonData:(NSData*) jsonData type:(Class)type;

/**
 *  解析Json
 */
+(id) fromJsonString:(NSString*) jsonString groupType:(WJJSONGroupType*) groupType;

/**
 *  解析Json
 */
+(id) fromJsonData:(NSData*) jsonData groupType:(WJJSONGroupType*) groupType;

/**
 *  返回NSDictionary 或者 NSArray
 */
+(id) fromJsonString:(NSString*) json;

/**
 *  返回NSDictionary 或者 NSArray
 */
+(id) fromJsonData:(NSData*)jsonData;


@end
