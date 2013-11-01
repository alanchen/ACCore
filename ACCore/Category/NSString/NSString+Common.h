//
//  NSString+Common.h
//  ACDemo
//
//  Created by alan on 2013/11/1.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString(Common)

+ (NSString *)randomName;

-(BOOL)containSubString:(NSString *)substrings;
-(BOOL)isPhotoUrl;

@end
