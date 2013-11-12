//
//  ACGPSManager.m
//  ACDemo
//
//  Created by alan on 2013/11/8.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "ACGPSManager.h"

@interface ACGPSManager()<CLLocationManagerDelegate>
{
    NSTimer *_timer;
}
@end

@implementation ACGPSManager

+(ACGPSManager *)sharedInstance
{
    static ACGPSManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ACGPSManager alloc] init];
    });
    
    return sharedInstance;
}

+(BOOL)isAccessible
{
    BOOL accessGranted = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized;
    return accessGranted;
}

- (id) init
{
    self = [super init];
 
    if (self != nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; //kCLLocationAccuracyBestForNavigation;
        self.locationManager.distanceFilter = 10;
    }
    
    return self;
}

-(float)bestLatitude
{
    return self.bestEffortAtLocation.coordinate.latitude;
}

-(float)bestLongitude
{
    return self.bestEffortAtLocation.coordinate.longitude;
}

-(void)startUpdatingLocation
{
    self.bestEffortAtLocation = nil;
    
    [self stopUpdatingLocation];
    [self.locationManager startUpdatingLocation];
    
    if([ACGPSManager isAccessible]){
        [self launchTimeoutTimer];
    }
}

-(void)stopUpdatingLocation
{
    [_timer invalidate];
    _timer = nil;
    [self.locationManager stopUpdatingLocation];
}
                  
#pragma mark - Timer

-(void)launchTimeoutTimer
{
    if(self.timeout)
    {
        [_timer invalidate];
        _timer = nil;
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeout target:self selector:@selector(timeoutTrigger) userInfo:nil repeats:NO];
    }
}

-(void)timeoutTrigger
{
    [self stopUpdatingLocation];
    NotificationPost(GPSManagerNotificationDidTimeout, self.bestEffortAtLocation);
}

#pragma mark -  CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    
    if(_timer==nil){  // ensure timeout is workable
        [self launchTimeoutTimer];
    }
    
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0)
        return;
    
    // test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements
    //    if (fabs([newLocation.timestamp timeIntervalSinceNow]) > 5.0)
    //        return;
    
    // test the measurement to see if it is more accurate than the previous measurement
    if (self.bestEffortAtLocation == nil || self.bestEffortAtLocation.horizontalAccuracy > newLocation.horizontalAccuracy)
    {
        // store the location as the "best effort"
        self.bestEffortAtLocation = newLocation;
    }
    
     NSLog(@"GPS new Location : %@  horizontalAccuracy%f", newLocation, newLocation.horizontalAccuracy);
    
    // test the measurement to see if it meets the desired accuracy
    // IMPORTANT!!! kCLLocationAccuracyBest should not be used for comparison with location coordinate or altitidue
    // accuracy because it is a negative value. Instead, compare against some predetermined "real" measure of
    // acceptable accuracy, or depend on the timeout to stop updating. This sample depends on the timeout.
    if (newLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
        
        // we have a measurement that meets our requirements, so we can stop updating the location
        // IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
        [self stopUpdatingLocation];
        NotificationPost(GPSManagerNotificationDidUpdate, newLocation);
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSMutableString *errorString = [[NSMutableString alloc] init];
    
    if ([error domain] == kCLErrorDomain)
    {
        switch ([error code])
        {
            case kCLErrorDenied:
                [errorString appendFormat:@"%@\n", @"LocationDenied"];
                break;
                
            case kCLErrorLocationUnknown:
                [errorString appendFormat:@"%@\n",@"LocationUnknown"];
                break;
                
            default:
                [errorString appendFormat:@"%@ %ld\n", @"GenericLocationError", (long)[error code]];
                break;
        }
    }
    else
    {
        [errorString appendFormat:@"Error domain: \"%@\"  Error code: %ld\n", [error domain], (long)[error code]];
        [errorString appendFormat:@"Description: \"%@\"\n", [error localizedDescription]];
    }
    
    NSLog(@"GPS Error : %@",errorString);
    [self stopUpdatingLocation];
    NotificationPost(GPSManagerNotificationDidFail, error);
}


@end
