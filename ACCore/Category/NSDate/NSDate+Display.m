//
//  NSDate+Display.m
//  ACDemo
//
//  Created by alan on 2013/10/31.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "NSDate+Display.h"

@implementation NSDate(Display)

+ (NSDate *)dateWithISO8601String:(NSString *)format
{
    if(format==nil) return nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeStyle = NSDateFormatterFullStyle;
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    
    NSDate *date = [formatter dateFromString:format];
    
    return date;
}

- (NSString *)prettyDateFormat
{
    return [self displayDateFormat:@"yyyy/MM/dd"];
}

- (NSString *)displayDateFormat:(NSString *)Format
{
    NSDateFormatter *output = [[NSDateFormatter alloc] init];
    [output setDateFormat:Format];
    
    return [output stringFromDate:self];
}

@end
