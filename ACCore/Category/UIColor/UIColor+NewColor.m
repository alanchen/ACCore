//
//  UIColor+NewColor.m
//  ACCore
//
//  Created by alan on 13/10/9.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "UIColor+NewColor.h"

@implementation UIColor(NewColor)


+(UIColor *)colorWithDecRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b alpha:(CGFloat)a
{
    return [ UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

+(UIColor *)colorWithRGBHex:(UInt32)hex
{
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	
	return [UIColor colorWithDecRed:r green:g blue:b alpha:1.0];
}

+(UIColor *)color:(UIColor *)color WithAlpha:(float)alpha
{
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
    
    BOOL success = [color getRed:&r green:&g blue:&b alpha:&a];
    if(success){
        return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
    }
    
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat a2;
    
    BOOL success2 = [color getHue:&hue saturation:&saturation brightness:&brightness alpha:&a2];
    
    if(success2){
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];}
    
    return  nil;
    
}

+ (UIColor *) randomColor
{
	CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

-(UIColor *)colorRGBConvertToHSB
{
    CGFloat hue;
    CGFloat saturation;
    CGFloat brightness;
    CGFloat alpha;
    
    BOOL success = [self getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha];
    
    if(success){
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];}
    
    return  nil;
}


@end
