//
//  WJAppContext.h
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
#import <UIKit/UIKit.h>
#import "WJSingleton.h"


/**
 *  应用程序环境
 *
 *  在WJConfig 配置中配置  key:WJAppContext    childkey:modules   childkey:tokenClassName
 *
 *  WJAppContext:(NSDictionary<String,Object>)  App上下文环境
 *               modules:(NSArray<String>) 模块类名
 *  sessionDataFormatter:(String) 回话数据格式化器
 *
 */
@interface WJAppContext : AbstractWJBusinessObject<UIApplicationDelegate>

AS_SINGLETON(WJAppContext)

/**
 * 注册应用程序上下文环境
 * 在app启动时调用
 */
+(void)registerAppContext;

@end
