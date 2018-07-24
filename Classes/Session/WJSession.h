//
//  GenericWJSession.h
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

#import "AbstractWJBusinessObject.h"
#import "IWJSession.h"
#import "WJSingleton.h"

@interface WJSession : AbstractWJBusinessObject<IWJSession>

AS_SINGLETON(WJSession)

@end
