//
//  NSDate+Display.h
//  ACDemo
//
//  Created by alan on 2013/10/31.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate(Display)

// The format is specified in ISO 8601 (YYYY-MM-DDThh:mm:ss.sZ) format.
+ (NSDate *)dateWithISO8601String:(NSString *)format;

- (NSString *)displayDateFormat:(NSString *)Format;
- (NSString *)prettyDateFormat; // yyyy/MM/dd

@end
