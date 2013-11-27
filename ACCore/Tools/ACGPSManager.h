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
static NSString *GPSManagerNotificationDidTimeout   = @"GPSManagerNotificationDidTimeout";
static NSString *GPSManagerNotificationDidFail      = @"GPSManagerNotificationDidFail";

@interface ACGPSManager : NSObject

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *bestEffortAtLocation;
@property (nonatomic) float timeout ; // 0 is no timeout , default is  0. timeout means how many times updateffffwds
//sdggdsd

@property (nonatomic,readonly) float bestLatitude;
@property (nonatomic,readonly) float bestLongitude;

@property (nonatomic,readonly) BOOL isUpdating;

+(ACGPSManager *)sharedInstance;
+(BOOL)isAccessible;

-(void)startUpdatingLocation;
-(void)stopUpdatingLocation;

@end
