//
//  WJCacheKeychain.h
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

#import "AbstractWJBusinessObject.h"
#import "WJSingleton.h"
#import "WJCacheAPI.h"


/**
 *  Keychain 缓存对IWJCache实现
 */
@interface WJCacheKeychain : AbstractWJBusinessObject<IWJCache>

AS_SINGLETON(WJCacheKeychain)

@end
