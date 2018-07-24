//
//  NSObject+WJJSON.h
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
 *  模拟实现WJJSON
 */
@interface NSObject (WJJSON)

/**
 *  属性到JSON属性名称映射
 */
+(NSDictionary*) wjPropertyToJsonPropertyDictionary;

/**
 *  非JSON属性列表
 */
+(NSSet*) wjNonJsonPropertys;

/**
 *  容器属性类型
 *  key：属性名称
 *  value：类型（Class）支持NSDictionary，NSSet，NSArray
 *  {
 *      @"users" : [UserDTO class],
 *      @"dict" : {
 *                   @"key1" : [DTOClass1 class],
 *                   @"key2" : [DTOClass2 class]
 *                }
 *  }
 */
+(NSDictionary*) wjContainerPropertysGenericClass;

/**
 *  日期属性Format字符串
 */
+(NSString*) wjPropertyDateFormatString:(NSString*) property;

/**
 *  自定义解析属性集合
 *
 *  @return 数据名称集合
 */
+(NSSet*) wjCustomParsePropertys;

/**
 *  自定义处理属性（只有wjCustomParsePropertys返回有属性需要自定义处理时才触发）
 *
 *  @param property 属性名称
 *  @param object   对应值
 */
-(void) wjCustomParseProperty:(NSString*) property value:(id) object;

@end
