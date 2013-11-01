//
//  UIViewController+Common.m
//  ACDemo
//
//  Created by alan on 2013/11/1.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController(Common)

+(id)createViewControllerWithTheSameNibName
{
    Class class = self;
    
    NSString* nibName=  NSStringFromClass(class);
    id vc = [[class alloc] initWithNibName:nibName bundle:nil];
    
    return vc;
}

-(void)presentModalViewControllerWithNavigation:(UIViewController *)modalViewController animated:(BOOL)animated
{
    UINavigationController *navi =[[UINavigationController alloc] initWithRootViewController:modalViewController];
    [self presentViewController:navi animated:animated completion:nil];
}

-(void)presentModalViewControllerWithNavigation:(UIViewController *)modalViewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    UINavigationController *navi =[[UINavigationController alloc] initWithRootViewController:modalViewController];
    [self presentViewController:navi animated:animated completion:completion];
}

-(BOOL)checkMyselfIsRootViewController
{
    UIViewController *rootVC = [self.navigationController.viewControllers objectAtIndex:0];
    
    if(rootVC==self){
        return YES;
    }
    
    return NO;
}


@end
