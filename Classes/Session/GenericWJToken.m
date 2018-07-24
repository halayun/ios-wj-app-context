//
//  GenericWJToken.m
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

#import "GenericWJToken.h"

@implementation GenericWJToken

#pragma mark IWJToken
-(NSString*) currentToken {
    return _token;
}

-(NSString*) refreshToken {
    return _refreshToken;
}

-(id) currentUid {
    return _uid;
}

-(NSTimeInterval) invalidTime {
    return _timeout;
}

-(NSString *)dataSafeKey {
    return _dataSafeKey;
}

@end
