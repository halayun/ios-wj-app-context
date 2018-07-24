//
//  WJJSONUtils.h
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
#import "WJJSONObjectDesc.h"

@interface WJJSONUtils : NSObject

+(WJJSONObjectDesc*) getJsonObjectDesc:(Class) clazz;

+(WJObjectType) getType:(id) value;

@end
