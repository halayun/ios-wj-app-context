//
//  NSString+WJExtension.m
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

#import "NSString+WJCalculateSize.h"


@implementation NSString (WJCalculateSize)

-(CGSize)wj_sizeWithFont:(UIFont *)font boundingSize:(CGSize) aSize mode:(NSLineBreakMode)mode {
    return [self wj_sizeWithFont:font boundingSize:aSize mode:mode lineSpacing:0];
}

-(CGSize)wj_sizeWithFont:(UIFont *)font boundingSize:(CGSize) aSize mode:(NSLineBreakMode)mode lineSpacing:(CGFloat) spacing {
    CGSize s = CGSizeZero;
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0
    s = [self sizeWithFont:font constrainedToSize:aSize lineBreakMode:mode];
#else
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (spacing > 0) {
        [paragraphStyle setLineSpacing:spacing];
    }
    paragraphStyle.lineBreakMode = mode;
    NSDictionary *attributes = [[NSDictionary alloc] initWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle,NSParagraphStyleAttributeName, nil];
    s = [self boundingRectWithSize:aSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
#endif
    return s;
}


@end
