//
//  NSMutableArray+WJExtension.h
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

#import <Foundation/Foundation.h>

@interface NSMutableArray (WJExtension)

/**
 *  添加一个元素
 */
- (void) wj_push:(id)object;

/**
 *  取出最后一个数据并移除
 */
- (id) wj_pop;

/**
 *  取出指定数量的元素并移除
 */
- (NSArray *) wj_pop:(NSUInteger)numberOfElements;

/**
 *  添加数组
 */
- (void) wj_concat:(NSArray *)array;

/**
 *  取出第一个元素，并在数据中移除这个元素
 *
 *  @return 移除元素
 */
- (id) wj_shift;

/**
 *  取出前 numberOfElements 个对象并从数组中移除
 *
 *  @param numberOfElements 元素数量
 *
 *  @return 移除元素列表
 */
- (NSArray *) wj_shift:(NSUInteger)numberOfElements;

/**
 *  根据条件移除元素
 *
 *  @param block 筛选block
 *
 *  @return 移除后的结果
 */
- (NSArray *) wj_keepIf:(BOOL (^)(id object))block;

@end
