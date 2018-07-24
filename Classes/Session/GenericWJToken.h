//
//  GenericWJToken.h
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

#import "BaseWJObject.h"
#import "IWJToken.h"

@interface GenericWJToken : BaseWJObject<IWJToken>

/**
 *  令牌
 */
@property (nonatomic, copy) NSString *token;

/**
 *  刷新令牌
 */
@property (nonatomic, copy) NSString *refreshToken;

/**
 *  用户id
 */
@property (nonatomic, copy) NSString *uid;

/**
 *  过期时间
 */
@property (nonatomic, assign) NSTimeInterval timeout;

//数据安全key
@property(nonatomic, copy) NSString *dataSafeKey;


@end
