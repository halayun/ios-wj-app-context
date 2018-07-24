//
//  NSArray+WJExtension.m
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

#import "NSArray+WJExtension.h"
#import "NSMutableArray+WJExtension.h"
#import "NSString+WJExtension.h"

@implementation NSArray (WJExtension)

- (id) wj_first {
    return [self firstObject];
}

- (id) wj_last {
    return [self lastObject];
}

- (id) wj_sample {
    if (self.count == 0) return nil;
    
    NSUInteger index = arc4random_uniform((u_int32_t)self.count);
    return self[index];
}

- (id) wj_objectForKeyedSubscript:(id <NSCopying>)key {
    NSRange range;
    if ([(id)key isKindOfClass:[NSString class]]) {
        NSString *keyString = (NSString *)key;
        range = NSRangeFromString(keyString);
        if ([keyString containsString:@"..."]) {
            range = NSMakeRange(range.location, range.length - range.location);
        } else if ([keyString containsString:@".."]) {
            range = NSMakeRange(range.location, range.length - range.location + 1);
        }
    } else if ([(id)key isKindOfClass:[NSValue class]]) {
        range = [((NSValue *)key) rangeValue];
    } else {
        [NSException raise:NSInvalidArgumentException format:@"expected NSString or NSValue argument, got %@ instead", [(id)key class]];
    }
    
    return [self subarrayWithRange:range];
}


- (void) wj_each:(void (^)(id object))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (void) wj_eachWithIndex:(void (^)(id object, NSUInteger  index))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx);
    }];
}

- (BOOL) wj_includes:(id)object {
    return [self containsObject:object];
}

- (NSArray *) wj_take:(NSUInteger)numberOfElements {
    numberOfElements = MIN(numberOfElements, [self count]);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:numberOfElements];
    
    for (NSUInteger i = 0; i < numberOfElements; i++) {
        [array addObject:self[i]];
    }
    
    return array;
}

- (NSArray *) wj_takeWhile:(BOOL (^)(id object))block {
    NSMutableArray *array = [NSMutableArray array];
    
    for (id arrayObject in self) {
        if (block(arrayObject))
            [array addObject:arrayObject];
        
        else break;
    }
    
    return array;
}

- (NSArray *) wj_map:(id (^)(id object))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        id newObject = block(object);
        if (newObject) {
            [array addObject:newObject];
        }
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

- (id) wj_detect:(BOOL (^)(id object))block {
    
    for (id object in self) {
        if (block(object))
            return object;
    }
    
    return nil;
}

- (id) wj_find:(BOOL (^)(id object))block {
    return [self wj_detect:block];
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

- (NSArray *) wj_flatten {
    NSMutableArray *array = [NSMutableArray array];
    
    for (id object in self) {
        if ([object isKindOfClass:NSArray.class]) {
            [array wj_concat:[object wj_flatten]];
        } else {
            [array addObject:object];
        }
    }
    
    return array;
}

- (NSString *) wj_join {
    return [self componentsJoinedByString:@""];
}

- (NSString *) wj_join:(NSString *)separator {
    return [self componentsJoinedByString:separator];
}

- (NSArray *) wj_sort {
    return [self sortedArrayUsingSelector:@selector(compare:)];
}

- (NSArray *) wj_sortBy:(NSString*)key; {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
    return [self sortedArrayUsingDescriptors:@[descriptor]];
}

- (NSArray *) wj_reverse {
    return self.reverseObjectEnumerator.allObjects;
}

#pragma mark - Set operations

- (NSArray *) wj_intersectionWithArray:(NSArray *)array {
    NSPredicate *intersectPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", array];
    return [self filteredArrayUsingPredicate:intersectPredicate];
}

- (NSArray *) wj_unionWithArray:(NSArray *)array {
    NSArray *complement = [self wj_relativeComplement:array];
    return [complement arrayByAddingObjectsFromArray:array];
}

- (NSArray *) wj_relativeComplement:(NSArray *)array {
    NSPredicate *relativeComplementPredicate = [NSPredicate predicateWithFormat:@"NOT SELF IN %@", array];
    return [self filteredArrayUsingPredicate:relativeComplementPredicate];
}

- (NSArray *) wj_symmetricDifference:(NSArray *)array {
    NSArray *aSubtractB = [self wj_relativeComplement:array];
    NSArray *bSubtractA = [array wj_relativeComplement:self];
    return [aSubtractB wj_unionWithArray:bSubtractA];
}

@end
