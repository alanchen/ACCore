//
//  UIButton+Common.h
//  ACDemo
//
//  Created by alan on 2013/11/1.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton(Common)

- (void)addTargetForTouchUpInsideEvent:(id)target action:(SEL)action;
- (void)setImageForStateNormal:(UIImage *)image;
- (void)setTitleForStateNormal:(NSString *)title;

@end
