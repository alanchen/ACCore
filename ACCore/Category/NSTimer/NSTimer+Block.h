//
//  NSTimer+Block.h
//  iVocabGame
//
//  Created by alan on 2013/12/19.
//  Copyright (c) 2013年 MoneyMan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^NSTimerBlock)(NSTimer *);

@interface NSTimer(Block)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))fireBlock;
+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))fireBlock;

@end
