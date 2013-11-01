//
//  ACMacros.h
//  ACCore
//
//  Created by alan on 13/10/7.
//  Copyright (c) 2013年 alan. All rights reserved.
//

///////////////////   Log  //////////////////////////

#define ACDumpInt(x)    NSLog(@"Value of %s = %d",#x, x)
#define ACDumpFloat(x)  NSLog(@"Value of %s = %f",#x, x)
#define ACDumpObj(x)    NSLog(@"Value of %s = %@",#x, x)
#define ACDumpRect(rect)    NSLog(@"Rect of %s = (%f, %f, %f, %f)",#rect,rect.origin.x,rect.origin.y,rect.size.width,rect.size.height)
#define ACDumpSize(size)    NSLog(@"Size of %s = (%f, %f)",#size,size.width,size.height)
#define ACDumpPoint(point)  NSLog(@"Point of %s = (%f, %f)",#point,point.x, point.y)
#define ACDumpFunction      NSLog(@"%s",__PRETTY_FUNCTION__)

///////////////////   Notification  //////////////////////////

#define NotificationAdd(target,action,notiname,withobject) [[NSNotificationCenter defaultCenter] addObserver:target selector:action name:notiname object:withobject]
#define NotificationRemoveSelfObserver [[NSNotificationCenter defaultCenter] removeObserver:self]
#define NotificationPost(notiname,withobject) [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:withobject]
#define NotificationPostWithInfo(notiname,withobject,withuserinfo) [[NSNotificationCenter defaultCenter] postNotificationName:notiname object:withobject userInfo:withuserinfo]


///////////////////   Display  //////////////////////////

#define IsRetinaDisplay [[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)]&&([UIScreen mainScreen].scale ==2.0)?1:0

#define  ScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define  ScreenHeight   [[UIScreen mainScreen] bounds].size.height

#define  StatusBarWidth     [[UIApplication sharedApplication] statusBarFrame].size.width
#define  StatusBarHeight    [[UIApplication sharedApplication] statusBarFrame].size.height


