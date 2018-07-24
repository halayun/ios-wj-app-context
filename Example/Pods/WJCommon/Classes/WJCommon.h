//
//  WJCommon.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 16/1/12.
//  Copyright © 2016年 WJ. All rights reserved.
//

#import "WJSingleton.h"
#import "AbstractWJBusinessObject.h"
#import "BaseWJEnum.h"
#import "BaseWJObject.h"
#import "NSDate+WJExtension.h"
#import "NSData+WJArchive.h"
#import "NSString+WJCalculateSize.h"
#import "NSString+WJExtension.h"
#import "NSString+WJURLEncode.h"
#import "NSSet+WJExtension.h"
#import "NSNumber+WJExtension.h"
#import "NSMutableArray+WJExtension.h"
#import "NSDictionary+WJExtension.h"
#import "NSArray+WJExtension.h"
#import "NSNotificationCenter+WJExtension.h"

#ifdef WJCommonUtils_h
    #import "WJCommonUtils.h"
#endif

#ifdef WJCommonUI_h
    #import "WJCommonUI.h"
#endif

#ifdef WJCommonNetworkService_h
#import "WJCommonNetworkService.h"
#endif


#if __has_feature(objc_arc)
    #define WJ_BLOCK_WEAK               __weak
    #define WJ_WEAK                     weak
    #define WJ_STRONG                   strong
    #define WJ_WEAK_REF_TYPE            __weak typeof(self)
    #define WJ_STRONG_REF_TYPE          __strong typeof(self)
#else
    #define WJ_BLOCK_WEAK               __unsafe_unretained
    #define WJ_WEAK                     assign
    #define WJ_STRONG                   retain
    #define WJ_WEAK_REF_TYPE            __unsafe_unretained typeof(self)
    #define WJ_STRONG_REF_TYPE          typeof(self)
#endif
