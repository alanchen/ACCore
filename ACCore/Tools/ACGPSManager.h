//
//  ACGPSManager.h
//  ACDemo
//
//  Created by alan on 2013/11/8.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

static NSString *GPSManagerNotificationDidUpdate    = @"GPSManagerNotificationDidUpdate";
static NSString *GPSManagerNotificationDidFail      = @"GPSManagerNotificationDidFail";

@interface ACGPSManager : NSObject

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *bestEffortAtLocation;

+(id)sharedInstance;
+(BOOL)isAccessible;

-(void)startUpdatingLocation;
-(void)stopUpdatingLocation;

@end
