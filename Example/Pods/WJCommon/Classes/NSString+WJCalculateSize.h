//
//  NSString+WJExtension.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/12/16.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

/**
 *  计算字符串所占区域大小
 */
@interface NSString (WJCalculateSize)


/**
 *  计算字符串所占区域大小
 *
 *  @param font             字体
 *  @param boundingSize     边距大小
 *  @param mode             模式
 *
 *  @return 所占区域大小
 */
-(CGSize) wj_sizeWithFont:(UIFont*) font boundingSize:(CGSize) aSize mode:(NSLineBreakMode) mode;

/**
 *  计算字符串所占区域大小
 *
 *  @param font             字体
 *  @param boundingSize     边距大小
 *  @param mode             模式
 *  @param spacing          行间距
 *
 *  @return 所占区域大小
 */
-(CGSize) wj_sizeWithFont:(UIFont*) font boundingSize:(CGSize) aSize mode:(NSLineBreakMode) mode lineSpacing:(CGFloat) spacing;

@end
