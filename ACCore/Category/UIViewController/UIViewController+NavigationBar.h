//
//  UIViewController+NavigationBar.h
//  ACDemo
//
//  Created by alan on 2013/11/1.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(NavigationBar)

-(void)addTopRightButtonItem:(UIBarButtonItem *)button;
-(void)addTopLeftButtonItem:(UIBarButtonItem *)button;

-(void)addTopRightButtonItem:(UIBarButtonItem *)button target:(id)target action:(SEL)action;
-(void)addTopLeftButtonItem:(UIBarButtonItem *)button target:(id)target action:(SEL)action;

-(void)addTopRightView:(UIView *)view;
-(void)addTopLeftView:(UIView *)view ;

-(void)addTopRightEmpty;
-(void)addTopLeftEmpty;

-(void)addTopRightView:(UIView *)view target:(id)target action:(SEL)action;
-(void)addTopLeftView:(UIView *)view target:(id)target action:(SEL)action;

@end
