//
//  UIView+Position.m
//  ACDemo
//
//  Created by alan on 2013/11/1.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "UIView+Position.h"

@implementation UIView(Position)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGSize)size
{
    return self.frame.size;
}

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    self.frame = frame;
}

-(CGPoint)point
{
    return self.frame.origin;
}

-(void)setPoint:(CGPoint)point
{
    CGRect frame = self.frame;
    frame.origin.x = point.x;
    frame.origin.y = point.y;
    self.frame = frame;
}

-(CGPoint)topLeft
{
    return CGPointMake(self.left, self.top);
}

-(void)setTopLeft:(CGPoint)topLeft
{
    self.left = topLeft.x;
    self.top = topLeft.y;
}

-(CGPoint)topRight
{
    return CGPointMake(self.right, self.top);
}

-(void)setTopRight:(CGPoint)topRight
{
    self.right = topRight.x;
    self.top = topRight.y;
}

-(CGPoint)bottomLeft
{
    return CGPointMake(self.left, self.bottom);
}

-(void)setBottomLeft:(CGPoint)bottomLeft
{
    self.left = bottomLeft.x;
    self.bottom = bottomLeft.y;
}

-(CGPoint)bottomRight
{
    return CGPointMake(self.right, self.bottom);
}

-(void)setBottomRight:(CGPoint)bottomRight
{
    self.right = bottomRight.x;
    self.bottom = bottomRight.y;
}


@end
