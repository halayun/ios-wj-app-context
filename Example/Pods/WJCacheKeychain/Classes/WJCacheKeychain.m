//
//  WJCacheKeychain.m
//  WJCacheKeychain-example
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海 on 16/9/26.
//  Copyright © 2016年 wuyunhai. All rights reserved.
//

#import "WJCacheKeychain.h"
#import "WJCacheConfig.h"
#import "UICKeyChainStore.h"
#import "NSData+WJArchive.h"

@interface WJCacheKeychain ()

@property (nonatomic, strong) UICKeyChainStore *keychainStore;

@end

@implementation WJCacheKeychain

DEF_SINGLETON_INIT(WJCacheKeychain)
 
-(void) singleInit {
    self.keychainStore = [[UICKeyChainStore alloc] initWithService:[[WJCacheConfig sharedInstance] keychainDefaultService] accessGroup:[[WJCacheConfig sharedInstance] keychainAccessGroup]];
}

#pragma mark IWJCache
- (BOOL)hasObjectForKey:(NSString*)key {
    if (key) return [self.keychainStore contains:key];
    return NO;
}

- (BOOL)boolForKey:(NSString*)key {
    NSString *value = [self.keychainStore stringForKey:key];
    if ([value length] == 1) {
        return [value boolValue];
    }
    return NO;
}

- (void)setBool:(BOOL)value forKey:(NSString*)key {
    if (key) {
        [self setString:[NSString stringWithFormat:@"%@",@(value)] forKey:key];
    }
}

- (NSString*)stringForKey:(NSString*)key {
    if (key) {
        return [self.keychainStore stringForKey:key];
    }
    return nil;
}

- (void)setString:(NSString*)value forKey:(NSString*)key {
    if (value && key) {
        [self.keychainStore setString:value forKey:key];
    }
}

- (NSData*)dataForKey:(NSString*)key {
    if (key) {
        return [self.keychainStore dataForKey:key];
    }
    return nil;
}

- (void)setData:(NSData*)data forKey:(NSString*)key {
    if (data && key) {
        [self.keychainStore setData:data forKey:key];
    }
}

- (id<NSCoding>)objectForKey:(NSString*)key {
    NSData *data = [self dataForKey:key];
    if (data) {
        return [NSData unarchiveObjectWithData:data];
    }
    return nil;
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString*)key {
    if (object && key) {
        NSData *data = [NSData archivedDataWithRootObject:object];
        [self setData:data forKey:key];
    }
}

- (void)removeObjectForKey:(NSString*)key {
    [self.keychainStore removeItemForKey:key];
}

- (void)removeAllObjects {
    [self.keychainStore removeAllItems];
}

-(NSInteger)cacheType {
    return WJCacheTypeKeychain;
}

+(id<IWJCache>)getInstance {
    return [WJCacheKeychain sharedInstance];
}

@end
