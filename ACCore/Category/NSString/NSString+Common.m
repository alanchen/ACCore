//
//  NSString+Common.m
//  ACDemo
//
//  Created by alan on 2013/11/1.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString(Common)

+ (NSString *)randomName
{
    NSMutableString *name = [[NSMutableString alloc] init];
    for (NSInteger ix = 0; ix < arc4random_uniform(10) + 5; ++ix){
        [name appendFormat:@"%c", arc4random_uniform('z'-'a')+'a'];
    }
    return [name capitalizedString];
}

-(BOOL)containSubString:(NSString *)substring
{
    NSRange textRange;
    textRange =[[self lowercaseString] rangeOfString:[substring lowercaseString]];
    
    if(textRange.location != NSNotFound){
        return YES;
    }
    
    return NO;
}


-(BOOL)isPhotoUrl
{
    NSArray *photoFormats = @[@".jpg", @".png", @".bmp", @".gif", @".jpeg", @".jpe"];
    NSString *detectedURLLowercase = [self lowercaseString];
    
    __block BOOL isPhotoUrlStr = NO;
    [photoFormats enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([detectedURLLowercase hasSuffix:obj]) {
            isPhotoUrlStr = YES;
            *stop = YES;
        };
    }];
    
    return isPhotoUrlStr;
}


@end
