//
//  WJJSONGroupType.m
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

#import "WJJSONGroupType.h"
#import "IWJJSONObject.h"

@interface WJJSONGroupType ()
@property (nonatomic, readwrite) Class collectionClass;
@property (nonatomic, readwrite) Class elementClass;
@end
@implementation WJJSONGroupType

-(Class) collectionClass {
    return _collectionClass;
}

-(Class) elementClass {
    return _elementClass;
}

+(WJJSONGroupType *)createCollectionClass:(Class)collectionClass elementClass:(Class)elementClass {
    if (![collectionClass isSubclassOfClass:[NSArray class]] && ![collectionClass isSubclassOfClass:[NSSet class]]) {
        NSString *reason = @"collectionClass必须是NSArray，NSSet类型";
        @throw [[NSException alloc] initWithName:@"WJJSONGroupTypeException" reason:reason userInfo:@{NSLocalizedDescriptionKey:reason}];
        return nil;
    }
    if (![elementClass conformsToProtocol:@protocol(IWJJSONObject)]) {
        NSString *reason = @"elementClass必须是IWJJSONObject类型";
        @throw [[NSException alloc] initWithName:@"WJJSONGroupTypeException" reason:reason userInfo:@{NSLocalizedDescriptionKey:reason}];
        return nil;
    }
    WJJSONGroupType *type = [[WJJSONGroupType alloc] init];
    [type setCollectionClass:collectionClass];
    [type setElementClass:elementClass];
    return type;
}

@end
