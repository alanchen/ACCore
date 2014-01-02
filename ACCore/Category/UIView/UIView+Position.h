//
//  UIView+Position.h
//  ACDemo
//
//  Created by alan on 2013/11/1.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Position)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint point;

@property (nonatomic) CGPoint topLeft;
@property (nonatomic) CGPoint topRight;

@property (nonatomic) CGPoint bottomLeft;
@property (nonatomic) CGPoint bottomRight;

@end
