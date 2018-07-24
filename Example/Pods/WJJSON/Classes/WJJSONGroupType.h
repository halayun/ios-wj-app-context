//
//  WJJSONGroupType.h
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
 *  组类型
 */
@interface WJJSONGroupType : NSObject

/**
 *  元素类型
 */
-(Class) elementClass;

/**
 *  集合类型
 */
-(Class) collectionClass;

/**
 *  创建方法
 */
+(WJJSONGroupType*) createCollectionClass:(Class) collectionClass elementClass:(Class)elementClass;

@end
