//
//  UIViewController+NavigationBar.m
//  ACDemo
//
//  Created by alan on 2013/11/1.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "UIViewController+NavigationBar.h"
#import "UIButton+Common.h"
#import "UIView+Position.h"

@implementation UIViewController(NavigationBar)

-(void)addTopRightButtonItem:(UIBarButtonItem *)button
{
    self.navigationItem.rightBarButtonItem = button;
}

-(void)addTopLeftButtonItem:(UIBarButtonItem *)button
{
    self.navigationItem.leftBarButtonItem = button;
}

-(void)addTopRightButtonItem:(UIBarButtonItem *)button target:(id)target action:(SEL)action
{
    [self addTopRightButtonItem:button];
    button.style = UIBarButtonItemStyleBordered;
    button.target = target;
    button.action = action;
}

-(void)addTopLeftButtonItem:(UIBarButtonItem *)button target:(id)target action:(SEL)action
{
    [self addTopLeftButtonItem:button];
    button.style = UIBarButtonItemStyleBordered;
    button.target = target;
    button.action = action;
}

-(void)addTopRightButton:(UIButton *)btn;
{
    [self addTopRightButtonItem:[[UIBarButtonItem alloc] initWithCustomView:btn]];
}

-(void)addTopLeftButton:(UIButton *)btn ;
{
    [self addTopLeftButtonItem:[[UIBarButtonItem alloc] initWithCustomView:btn]];
}

-(void)addTopRightEmpty
{
    [self addTopRightButton:[UIButton buttonWithType:UIButtonTypeCustom]];
}

-(void)addTopLeftEmpty
{
    [self addTopLeftButton:[UIButton buttonWithType:UIButtonTypeCustom]];
}

-(void)addTopRightButton:(UIButton *)btn target:(id)target action:(SEL)action
{
    [btn addTargetForTouchUpInsideEvent:target action:action];
    [self addTopRightButton:btn];
}

-(void)addTopLeftButton:(UIButton *)btn target:(id)target action:(SEL)action
{
     [btn addTargetForTouchUpInsideEvent:target action:action];
     [self addTopLeftButton:btn];
}

@end