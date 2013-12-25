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

-(void)addTopRightView:(UIView *)view;
{
    [self addTopRightButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view]];
}

-(void)addTopLeftView:(UIView *)view ;
{
    [self addTopLeftButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view]];
}

-(void)addTopRightEmpty
{
    [self addTopRightView:[UIButton buttonWithType:UIButtonTypeCustom]];
}

-(void)addTopLeftEmpty
{
    [self addTopLeftView:[UIButton buttonWithType:UIButtonTypeCustom]];
}

-(void)addTopRightView:(UIView *)view target:(id)target action:(SEL)action;
{
    [self addTopRightButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view] target:target action:action];
}

-(void)addTopLeftView:(UIView *)view target:(id)target action:(SEL)action
{
    [self addTopLeftButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view] target:target action:action];
}

@end