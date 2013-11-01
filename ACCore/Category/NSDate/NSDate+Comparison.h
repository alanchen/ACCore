//
//  NSDate+Comparison.h
//  ACDemo
//
//  Created by alan on 2013/10/31.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDate(Comparison)

+ (BOOL)checkIfSameDayWithTimestamp:(NSTimeInterval)timestamp1 timestamp2:(NSTimeInterval)timestamp2;
+ (BOOL)checkIfSameMonthWithTimestamp:(NSTimeInterval)timestamp1 timestamp2:(NSTimeInterval)timestamp2;
+ (BOOL)checkIfSameYearWithTimestamp:(NSTimeInterval)timestamp1 timestamp2:(NSTimeInterval)timestamp2;

@end
