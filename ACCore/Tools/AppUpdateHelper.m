//
//  AppUpdateHelper.m
//  PetViewer
//
//  Created by alan on 13/10/11.
//  Copyright (c) 2013年 MoneyMan. All rights reserved.
//

#import "AppUpdateHelper.h"

static NSString * const kUserDefaultRemindMeLater = @"kUserDefaultRemindMeLater";

@interface AppUpdateHelper()<UIAlertViewDelegate>
{
    NSURLConnection *_connection;
}

@end

@implementation AppUpdateHelper

+(AppUpdateHelper *)sharedInstance
{
    static AppUpdateHelper *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AppUpdateHelper alloc] init];
        sharedInstance.appId = nil;
        sharedInstance.remoteVersion = @"";
    });
    
    return sharedInstance;
}

#pragma mark - Private

- (NSComparisonResult) compareVersions: (NSString*) version1 version2: (NSString*) version2
{
    NSComparisonResult result = NSOrderedSame;
    
    NSMutableArray* a = (NSMutableArray*) [version1 componentsSeparatedByString: @"."];
    NSMutableArray* b = (NSMutableArray*) [version2 componentsSeparatedByString: @"."];
    
    while (a.count < b.count) { [a addObject: @"0"]; }
    while (b.count < a.count) { [b addObject: @"0"]; }
    
    for (int i = 0; i < a.count; ++i)
    {
        if ([[a objectAtIndex: i] integerValue] < [[b objectAtIndex: i] integerValue])
        {
            result = NSOrderedAscending;
            break;
        }
        else if ([[b objectAtIndex: i] integerValue] < [[a objectAtIndex: i] integerValue])
        {
            result = NSOrderedDescending;
            break;
        }
    }
    
    return result;
}

-(void)showUpdateAlert
{
    NSString *msg =[NSString stringWithFormat: @"是否更新到新版本:%@",self.remoteVersion];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"新版本"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"稍後提醒",@"更新", nil];
    [alert show];
}

-(BOOL)checkIfRemindMeLater
{
    NSNumber *remindMeTimeNum = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultRemindMeLater]  ;
    NSTimeInterval remindMeTime = [remindMeTimeNum doubleValue];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    
    if(now > remindMeTime){
        return NO;
    }
    
    return YES;
}

-(void)launchAppStorePage
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kAppStoreUrl,self.appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

#pragma mark - Getter

-(BOOL)isNewVersionAvailable
{
    if([self.remoteVersion length]==0)
        return NO;
    
    BOOL hasUpdate = [self compareVersions: self.localVersion version2: self.remoteVersion] == NSOrderedAscending;
    return hasUpdate;
}

#pragma mark - Public

-(void)checkNowWithAppId:(NSString *)appId
{
    if(_delegate==nil)
        _delegate=self;
    
    if(appId==nil)
        return;
    else
        self.appId = appId;
    
    if([self checkIfRemindMeLater]){
        return;
    }
    
    NSURL* url = [NSURL URLWithString: [NSString stringWithFormat: @"%@?id=%@", kAppUpdateUrl, self.appId]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                         timeoutInterval:30];
    
    [_connection cancel];
    _connection =nil;
    _connection = [NSURLConnection connectionWithRequest:request delegate: self];
    
    if (_connection == nil){
        if ([_delegate respondsToSelector: @selector (appUpdateFailed:)]){
            NSDictionary* info = [NSDictionary dictionaryWithObject: @"A connection can't be created." forKey: @"message"];
            NSError* error = [NSError errorWithDomain: @"NSURLErrorDomain" code: -1 userInfo: info];
            [_delegate appUpdateFailed:error];
        }
    }
}

-(void)remindMeOneDayLater
{
    NSTimeInterval secs = 60*60*24*2; // two days
    NSTimeInterval remindMeTime= [[NSDate date] timeIntervalSince1970]+secs;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithDouble:remindMeTime] forKey:kUserDefaultRemindMeLater]  ;
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)cancelRemindMeLater
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultRemindMeLater];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - NSURLConnection Delegate

- (void) connection: (NSURLConnection*) connection didReceiveData: (NSData*) data
{
    NSError *error = nil;
    NSDictionary* jsonData =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *results = [jsonData objectForKey: @"results"];
    NSDictionary* result;

    if([results count]>0){
        result = [results objectAtIndex:0];
    }
    
    NSString* remoteVersion = [result objectForKey: @"version"];
//    remoteVersion = @"1.0.5";
    
    if([remoteVersion length]==0 || [self.localVersion length]==0)
    {
        if ([_delegate respondsToSelector: @selector (appUpdateFailed:)]){
            [_delegate appUpdateFailed: error];
        }
    }
    else
    {
        _remoteVersion = remoteVersion;
        BOOL hasUpdate = [self compareVersions: self.localVersion version2: remoteVersion] == NSOrderedAscending;
        
        NSLog(@"localVersion:%@ remoteVersion:%@ hasUpdate:%d",self.localVersion,remoteVersion,hasUpdate);
        
        if ([_delegate respondsToSelector: @selector (appUpdateComplete:updateAvailable:)]){
            [_delegate appUpdateComplete: jsonData updateAvailable: hasUpdate];
        }
    }
}

- (void) connection: (NSURLConnection*) connection didFailWithError: (NSError*) error
{
    if ([_delegate respondsToSelector: @selector (appUpdateFailed:)]){
        [_delegate appUpdateFailed: error];
    }
}

#pragma mark - AppUpdate Delegate

- (void) appUpdateComplete: (NSDictionary*) appInfo updateAvailable: (BOOL) updateAvailable
{
    if(updateAvailable)
        [self showUpdateAlert];
    
    NSLog(@"appUpdateComplete updateAvailable=%d",updateAvailable);
}

- (void) appUpdateFailed: (NSError*) error
{
    NSLog(@"appUpdateFailed");
}

#pragma mark - UIAlert Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)  // remind me later
    {
        [self remindMeOneDayLater];
    }
    else if(buttonIndex==1) // update
    {
        [self launchAppStorePage];
    }
}


@end
