//
//  NSData+WJArchive.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 16/1/12.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  存档扩展
 */
@interface NSData (WJArchive)

/**
 *  将普通NSCoding转成NSData
 */
+(NSData*) archivedDataWithRootObject:(id) object;

/**
 *  将NSData反序列化成NSCoding对象
 */
+(id) unarchiveObjectWithData:(NSData*) data;

@end
