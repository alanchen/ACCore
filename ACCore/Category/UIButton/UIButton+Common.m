//
//  UIButton+Common.m
//  ACDemo
//
//  Created by alan on 2013/11/1.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "UIButton+Common.h"

@implementation UIButton(Common)

- (void)addTargetForTouchUpInsideEvent:(id)target action:(SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setImageForStateNormal:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
}

- (void)setTitleForStateNormal:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

@end
