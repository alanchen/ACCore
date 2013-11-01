//
//  UIColor+NewColor.h
//  ACCore
//
//  Created by alan on 13/10/9.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIColor(NewColor)

+(UIColor *)colorWithDecRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a; // (255,255,255)
+(UIColor *)colorWithRGBHex:(UInt32)hex; // 0xFA12B0
+(UIColor *)color:(UIColor *)color WithAlpha:(float)alpha;
+(UIColor *)randomColor;

-(UIColor *)colorRGBConvertToHSB;

@end
