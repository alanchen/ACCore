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

-(void)addTopRightButton:(UIButton *)button
{
    [self addTopRightButtonItem:[[UIBarButtonItem alloc] initWithCustomView:button]];
}

-(void)addTopLeftButton:(UIButton *)button
{
    [self addTopLeftButtonItem:[[UIBarButtonItem alloc] initWithCustomView:button]];
}

-(void)addTopRightEmptyButton
{
    [self addTopRightButton:[UIButton buttonWithType:UIButtonTypeCustom]];
}

-(void)addTopLeftEmptButton
{
    [self addTopLeftButton:[UIButton buttonWithType:UIButtonTypeCustom]];
}

-(void)addTopRightButton:(UIButton *)button target:(id)target action:(SEL)action
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,button.width,button.height)];
    [view addSubview:button];
    
    [self addTopRightButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view] target:target action:action];
}

-(void)addTopLeftButton:(UIButton *)button target:(id)target action:(SEL)action
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,button.width,button.height)];
    [view addSubview:button];
    
    [self addTopLeftButtonItem:[[UIBarButtonItem alloc] initWithCustomView:view] target:target action:action];
}

@end