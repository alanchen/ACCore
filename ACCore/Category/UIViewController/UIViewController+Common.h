//
//  UIViewController+Common.h
//  ACDemo
//
//  Created by alan on 2013/11/1.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController(Common)

+(id)createViewControllerWithTheSameNibName;

-(void)presentModalViewControllerWithNavigation:(UIViewController *)modalViewController
                                       animated:(BOOL)animated;
-(void)presentModalViewControllerWithNavigation:(UIViewController *)modalViewController
                                       animated:(BOOL)animated
                                     completion:(void (^)(void))completion ;
-(BOOL)checkMyselfIsRootViewController;

@end
