//
//  BaseWJEnum.h
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

#import "BaseWJObject.h"

/**
 * 枚举类型基类
 * 使用方法：
 *  1、继承BaseWJEnum基类
 *  2、子类中.m文件中声明一个 NSSet集合类型，并重写方法 +(NSSet)values 返回此集合
 *  3、在+(void)load 中初始化枚举项
 *  4、每个枚举类型构造一个可读属性，并实现属性get方法
 */



@protocol IWJEnum <NSObject>

+(NSSet*) values;//枚举列表

+(id<IWJEnum>) getEnumByValue:(NSInteger) value;

-(NSInteger) value;//值

-(NSString*) name;//名称

@end

#define ENUMINIT(v,n)       [[self.class alloc] initWithValue:v name:n]
/**
 *  枚举基类
 */
@interface BaseWJEnum : BaseWJObject<IWJEnum>

-(instancetype) initWithValue:(NSInteger) value name:(NSString*) name;

@end
