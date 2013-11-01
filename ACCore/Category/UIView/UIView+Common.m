//
//  UIView+Common.m
//  ACDemo
//
//  Created by alan on 2013/11/1.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView(Common)

-(void)removeSubviewWithTag:(int)tag
{
    UIView *v =  [self viewWithTag:tag];
    
    if(v){
        [v removeFromSuperview];}
}


@end
