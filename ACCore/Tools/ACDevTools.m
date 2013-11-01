//
//  ACDevTools.m
//  ACCore
//
//  Created by alan on 13/10/9.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "ACDevTools.h"

@implementation ACDevTools

+ (void)showDevAlertNotImplement
{
    [self showDevAlertWithText:@"Not Implement"];
}

+ (void) showDevAlertSomethingError
{
    [self showDevAlertWithText:@"Something Error"];
}

+ (void) showDevAlertWithText:(NSString *)text
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:text message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}



@end
