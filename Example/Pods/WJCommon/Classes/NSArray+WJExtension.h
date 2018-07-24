//
//  NSArray+WJExtension.h
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

@interface NSArray (WJExtension)

/**
 *  第一个元素
 */
- (id) wj_first;

/**
 *  最后一个元素
 */
- (id) wj_last;


/**
 *  随机一个元素
 */
- (id) wj_sample;


/**
 * 根据下标返回元素列表
 */
- (id) wj_objectForKeyedSubscript:(id <NSCopying>)key;


/**
 * 遍历所有元素
 */
- (void) wj_each:(void (^)(id object))block;

/**
 * 遍历所有元素
 */
- (void) wj_eachWithIndex:(void (^)(id object, NSUInteger index))block;

/**
 *  是否包含此元素
 */
- (BOOL) wj_includes:(id)object;

/**
 *  返回指定数量的元素
 */
- (NSArray *) wj_take:(NSUInteger)numberOfElements;

/**
 *  根据条件返回元素
 */
- (NSArray *) wj_takeWhile:(BOOL (^)(id object))block;

/**
 *  遍历整个数组
 */
- (NSArray *) wj_map:(id (^)(id object))block;

/**
 *  根据条件返回数据
 */
- (NSArray *) wj_select:(BOOL (^)(id object))block;

/**
 *  查找元素
 */
- (id) wj_detect:(BOOL (^)(id object))block;


/**
 *  查找元素
 */
- (id) wj_find:(BOOL (^)(id object))block;

/**
 *  不符合条件数组
 */
- (NSArray *) wj_reject:(BOOL (^)(id object))block;

/**
 *  将数组中所有是数组的元素全部作为一个数组返回
 */
- (NSArray *) wj_flatten;

/**
 *  将数组连接成字符串
 */
- (NSString *) wj_join;

/**
 *  根据指定字符连接数组
 */
- (NSString *) wj_join:(NSString *)separator;

/**
 *  排序（compare:）
 */
- (NSArray *) wj_sort;

/**
 *  根据指定字段排序
 */
- (NSArray *) wj_sortBy:(NSString*)key;

/**
 *  翻转字符串
 */
- (NSArray *) wj_reverse;

/**
 *  查找在array中的数组元素
 *
 *  @param array 条件数组
 *
 *  @return 在array数据中的数据集合
 */
- (NSArray *) wj_intersectionWithArray:(NSArray *)array;

/**
 *  合并两个数组
 */
- (NSArray *) wj_unionWithArray:(NSArray *)array;

/**
 *  筛选不在array中的数据元素
 *
 *  @param array 条件数组
 *
 *  @return 不在array中的数据集合
 */
- (NSArray *) wj_relativeComplement:(NSArray *)array;

/**
 *  补集，不同时在当前数组和array中的元素集合
 *
 *  @param array 条件数组
 *
 *  @return 补集结果
 */
- (NSArray *) wj_symmetricDifference:(NSArray *)array;

@end
