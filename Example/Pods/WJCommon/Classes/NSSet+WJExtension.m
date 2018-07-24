//
//  NSSet+WJExtension.m
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

#import "NSSet+WJExtension.h"
#import "NSArray+WJExtension.h"

@implementation NSSet (WJExtension)

- (id) wj_first {
    NSArray *allObjects = self.allObjects;
    
    if (allObjects.count > 0)
        return allObjects[0];
    return nil;
}

- (id) wj_last {
    return self.allObjects.lastObject;
}

- (id) wj_sample {
    return [self.allObjects wj_sample];
}

- (void) wj_each:(void (^)(id))block {
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        block(obj);
    }];
}

- (void) wj_eachWithIndex:(void (^)(id object, NSUInteger index))block {
    __block int counter = 0;
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        block(obj, counter);
        counter ++;
    }];
}

- (NSArray *) wj_map:(id (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        id newObject = block(object);
        [array addObject:newObject];
    }
    
    return array;
}

- (NSArray *) wj_select:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        if (block(object)) {
            [array addObject:object];
        }
    }
    
    return array;
}

- (NSArray *) wj_reject:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        if (block(object) == NO) {
            [array addObject:object];
        }
    }
    
    return array;
}

- (NSArray *) wj_sort {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    return [self sortedArrayUsingDescriptors:@[sortDescriptor]];
}

@end
