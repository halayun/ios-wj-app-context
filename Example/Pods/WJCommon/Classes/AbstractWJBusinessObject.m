//
//  BaseBusinessObject.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/7/29.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "AbstractWJBusinessObject.h"

@implementation AbstractWJBusinessObject

-(instancetype)init {
    self = [super init];
    if (self) {
        [self registerForKVO];
    }
    return self;
}

-(void)dealloc {
    [self unregisterFromKVO];
    [self deallocObject];
}

-(void)deallocObject {
    /**
     *  移除当前对象中所有的注册通知
     */
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@ business description ...",NSStringFromClass(self.class)];
}

#pragma mark KVO
-(NSKeyValueObservingOptions) observerOptionsForKeypath:(NSString*) keyPath {
    return NSKeyValueObservingOptionNew;
}
- (void)registerForKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:[self observerOptionsForKeypath:keyPath] context:NULL];
    }
}
- (void)unregisterFromKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}
- (NSArray *)observableKeypaths {
    return nil;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:keyPath waitUntilDone:NO];
    } else {
        [self updateUIForKeypath:keyPath];
    }
}
- (void)updateUIForKeypath:(NSString *)keyPath {
}

@end
