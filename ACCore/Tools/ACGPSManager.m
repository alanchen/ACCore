//
//  ACGPSManager.m
//  ACDemo
//
//  Created by alan on 2013/11/8.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "ACGPSManager.h"

@interface ACGPSManager()<CLLocationManagerDelegate>
@end

@implementation ACGPSManager

+(id)sharedInstance
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
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; //kCLLocationAccuracyBestForNavigation;
        self.locationManager.distanceFilter = 5;
    }
    return self;
}

-(void)startUpdatingLocation
{
    [self.locationManager startUpdatingLocation];
}

-(void)stopUpdatingLocation
{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark -  CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    
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
    
    // test the measurement to see if it meets the desired accuracy
    // IMPORTANT!!! kCLLocationAccuracyBest should not be used for comparison with location coordinate or altitidue
    // accuracy because it is a negative value. Instead, compare against some predetermined "real" measure of
    // acceptable accuracy, or depend on the timeout to stop updating. This sample depends on the timeout.
    if (newLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
        
        // we have a measurement that meets our requirements, so we can stop updating the location
        // IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
        [self.locationManager stopUpdatingLocation];
        
        NotificationPost(GPSManagerNotificationDidUpdate, newLocation);
    }
    
    NSLog(@"GPS new Location : %@  horizontalAccuracy%f", newLocation, newLocation.horizontalAccuracy);
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
    NotificationPost(GPSManagerNotificationDidFail, error);
}


@end
