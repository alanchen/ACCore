//
//  NSDate+Comparison.m
//  ACDemo
//
//  Created by alan on 2013/10/31.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "NSDate+Comparison.h"

#define CalendarUnitComponents NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit


@implementation NSDate(Comparison)

+ (BOOL)checkIfSameDayWithTimestamp:(NSTimeInterval)timestamp1 timestamp2:(NSTimeInterval)timestamp2
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp1];
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:CalendarUnitComponents fromDate:date];
    
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:timestamp2];
    NSDateComponents *newDateComps = [[NSCalendar currentCalendar] components:CalendarUnitComponents fromDate:newDate];
    
    if (newDateComps.year == dateComps.year &&
        newDateComps.month == dateComps.month &&
        newDateComps.day == dateComps.day) {
        return YES;
    }
    else{
        return NO;
    }
}

+ (BOOL)checkIfSameMonthWithTimestamp:(NSTimeInterval)timestamp1 timestamp2:(NSTimeInterval)timestamp2
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp1];
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:CalendarUnitComponents fromDate:date];
    
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:timestamp2];
    NSDateComponents *newDateComps = [[NSCalendar currentCalendar] components:CalendarUnitComponents fromDate:newDate];
    
    if (newDateComps.year == dateComps.year &&
        newDateComps.month == dateComps.month) {
        return YES;
    }
    else{
        return NO;
    }
}

+ (BOOL)checkIfSameYearWithTimestamp:(NSTimeInterval)timestamp1 timestamp2:(NSTimeInterval)timestamp2
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp1];
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:CalendarUnitComponents fromDate:date];
    
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:timestamp2];
    NSDateComponents *newDateComps = [[NSCalendar currentCalendar] components:CalendarUnitComponents fromDate:newDate];
    
    if (newDateComps.year == dateComps.year) {
        return YES;
    }
    else{
        return NO;
    }
}


@end
