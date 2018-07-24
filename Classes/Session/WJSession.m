//
//  GenericWJSession.m
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/11/2.
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import "WJSession.h"
#import "WJStringUtils.h"
#import "BaseWJObject.h"
#import "WJCacheAPI.h"
#import "WJConfig.h"
#import "ISessionTokenFormatter.h"

NSString * const UserLoginedNotification = @"UserLoginedNotification";

NSString * const UserLogoutNotification = @"UserLogoutNotification";

#define KEYCHAIN_STORE_TOKEN_KEY            @"appTokenKey"
#define USERDEFAULTS_STORE_DATA_SAFE_KEY    @"dataSafeKey"

@interface WJSession ()
@property (nonatomic, copy) id<IWJToken> token;
@property (nonatomic, strong) NSLock *refLock;
@property (nonatomic, weak) id<IWJCache> keychainCache;
@property (nonatomic, weak) id<IWJCache> userDefaultsCache;
@property (nonatomic, strong) id<ISessionTokenFormatter> sessionTokenFormatter;
@end

@implementation WJSession

DEF_SINGLETON_INIT(WJSession)

-(void) deleteStorage {
    [self.keychainCache removeObjectForKey:KEYCHAIN_STORE_TOKEN_KEY];
    [self.userDefaultsCache removeObjectForKey:USERDEFAULTS_STORE_DATA_SAFE_KEY];
}

-(void) syncStorage {
    if (_token) {
        NSData *tokenData = [_sessionTokenFormatter toData:_token];
        if (tokenData) [self.keychainCache setData:tokenData forKey:KEYCHAIN_STORE_TOKEN_KEY];
        //保存数据安全key到userdefaults
        if ([self.token dataSafeKey]) [self.userDefaultsCache setString:[self.token dataSafeKey] forKey:USERDEFAULTS_STORE_DATA_SAFE_KEY];
    }
}

-(void) loadStorage {
    if ([self.keychainCache hasObjectForKey:KEYCHAIN_STORE_TOKEN_KEY]) {
        NSData *tokenData = [self.keychainCache dataForKey:KEYCHAIN_STORE_TOKEN_KEY];
        if (tokenData) {
            id<IWJToken> tokenValue = [_sessionTokenFormatter toToken:tokenData];
            NSString *dataSafeKey = [_userDefaultsCache stringForKey:USERDEFAULTS_STORE_DATA_SAFE_KEY];
            if (WJ_STRING_EQUAL(dataSafeKey, [tokenValue dataSafeKey])) {
                self.token = tokenValue;
            } else {
                self.token = nil;
                [self.keychainCache removeObjectForKey:KEYCHAIN_STORE_TOKEN_KEY];
            }
        }
    }
}

-(void)loadSessionTokenFormatter {
    NSString *sessionDataFormatterClazzName = [[WJConfig sharedInstance] getConfig:@"WJAppContext"][@"sessionDataFormatter"];
    Class clazz = NSClassFromString(sessionDataFormatterClazzName);
    if (clazz) {
        if ([clazz conformsToProtocol:@protocol(ISessionTokenFormatter)]) {
            self.sessionTokenFormatter = [[clazz alloc] init];
        } else {
            @throw [[NSException alloc] initWithName:@"WJAppContextException" reason:[NSString stringWithFormat:@"sessionDataFormatter:%@ 没有实现接口ISessionTokenFormatter", sessionDataFormatterClazzName] userInfo:nil];
        }
    } else {
        @throw [[NSException alloc] initWithName:@"WJAppContextException" reason:@"需要在WJConfig中配置sessionDataFormatter" userInfo:nil];
    }
}

/**
 *  初始化方法
 */
-(void) singleInit {
    if (WJ_CACHE_IS_VALID(WJCacheTypeKeychain)) {
        self.keychainCache = WJ_CACHE_OBJECT(WJCacheTypeKeychain);
    } else {
        WJLogError(@"需要keyChain cache实现");
        @throw [[NSException alloc] initWithName:@"WJSessionException" reason:@"需要keyChain cache实现" userInfo:nil];
    }
    if (WJ_CACHE_IS_VALID(WJCacheTypeUserDefaults)) {
        self.userDefaultsCache = WJ_CACHE_OBJECT(WJCacheTypeUserDefaults);
    } else {
        WJLogError(@"需要userDefaults cache实现");
        @throw [[NSException alloc] initWithName:@"WJSessionException" reason:@"需要userDefaults cache实现" userInfo:nil];
    }
    
    [self loadSessionTokenFormatter];
    
    self.refLock = [[NSLock alloc] init];
    [self loadStorage];
}


#pragma mark IWJSession
-(id<IWJToken>) getToken {
    if ([self isLogined]) {
        return _token;
    }
    return nil;
}

-(void) logined:(id<IWJToken>) token {
    [_refLock lock];
    if (token) {
        self.token = token;
        [self syncStorage];
        [[NSNotificationCenter defaultCenter] postNotificationName:UserLoginedNotification object:self];
    }
    [_refLock unlock];
}

-(void) logout {
    [_refLock lock];
    if (_token) {
        self.token = nil;
        [self deleteStorage];
        [[NSNotificationCenter defaultCenter] postNotificationName:UserLogoutNotification object:self];
    }
    [_refLock unlock];
}

-(BOOL) isLogined {
    if (_token == nil)
        return NO;
    if (([_token invalidTime] > 0 && [_token invalidTime] < [[NSDate date] timeIntervalSince1970]) || ![_token currentUid]) {
        [self logout];
        return NO;
    }
    return YES;
}

@end
