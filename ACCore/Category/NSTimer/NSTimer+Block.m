//
//  NSTimer+Block.m
//  iVocabGame
//
//  Created by alan on 2013/12/19.
//  Copyright (c) 2013年 MoneyMan. All rights reserved.
//

#import "NSTimer+Block.h"

@implementation NSTimer(Block)

+ (void)executeBlockWithTimer:(NSTimer *)timer
{
    NSTimerBlock block = [timer userInfo];
    block(timer);
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))fireBlock
{
    return [self scheduledTimerWithTimeInterval:seconds target:self selector:@selector(executeBlockWithTimer:) userInfo:[fireBlock copy] repeats:repeats];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))fireBlock
{
    return [self timerWithTimeInterval:seconds target:self selector:@selector(executeBlockWithTimer:) userInfo:[fireBlock copy] repeats:repeats];
}

@end
