//
//  WJConfig.h
//  WJConfig-example
//
//  Created by 吴云海 on 17/4/6.
//  Copyright © 2017年 wuyunhai. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 组件配置
 *
 * 在应用程序info.plist中添加配置：key：WJConfigFile    value:(String)配置文件名称
 * 如果info.plist中未配置，则默认配置文件名称为 app-config.plist
 *
 */
@interface WJConfig : NSObject

-(NSDictionary*)getConfig:(NSString*)configName;

+ (instancetype)sharedInstance;

@end
