//
//  WJJSONObjectDesc.h
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

/**
 *  对象类型
 */
typedef NS_ENUM(NSInteger, WJObjectType) {
    WJObjectTypeObject,//任意类型自定义
    WJObjectTypeDictionary,//词典类型
    WJObjectTypeArray,//数组类型
    WJObjectTypeSet,//集合类型
    WJObjectTypeNumber,//数字类型
    WJObjectTypeString,//字符串类型
    WJObjectTypeDate,//日期类型
    WJObjectTypeCustom,//自定义类型
};


@interface WJJSONPropertyDesc : NSObject
@property (nonatomic, copy) NSString *jsonName;//属性对应JSON名称
@property (nonatomic, copy) NSString *name;//属性名称
@property (nonatomic, assign) WJObjectType type;
@property (nonatomic, copy) NSString *typeName;//类型名称 NSString NSNumber NSArray NSDictionary
@property (nonatomic, copy) NSString *dateFormat;//日期格式化字符串
@property (nonatomic, assign) BOOL nonJson;//是否为非序列化属性（Default NO）
@property (nonatomic, assign) BOOL hasCusHandle;//是否自定义处理解析
@property (nonatomic) Class genericClass;//泛型（NSArray，NSSet）
@property (nonatomic, strong) NSDictionary *genericClassDict;//词典泛型（NSDictionary）

-(instancetype) initWithName:(NSString*) name typeName:(NSString*) typeName jsonName:(NSString*) jsonName nonJson:(BOOL) nonJson customHandle:(BOOL) cusHandle;
@property (nonatomic) Class customClass;

@end



/**
 *  Json 对象描述
 */
@interface WJJSONObjectDesc : NSObject

-(NSArray*) allPropertys;

-(WJJSONPropertyDesc*) getPropertyByName:(NSString*) propertyName;

-(WJJSONPropertyDesc*) getPropertyByJsonName:(NSString*) jsonName;

-(instancetype) initWithProperty:(NSArray*) propertys;

@end
