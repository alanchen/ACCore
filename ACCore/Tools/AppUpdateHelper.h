//
//  AppUpdateHelper.h
//  PetViewer
//
//  Created by alan on 13/10/11.
//  Copyright (c) 2013年 MoneyMan. All rights reserved.
//

/*
 If you don't assign delegate, it will popup a default alert to ask user for updating.
 If you want to customize the alert, please assign delegate and implement your code in appUpdateComplete.
 
 */

#import <Foundation/Foundation.h>

#define  kAppUpdateUrl      @"http://itunes.apple.com/lookup"
#define  kAppStoreUrl       @"https://itunes.apple.com/app/id"

@protocol AppUpdateHelpereDelegate <NSObject>

@optional
- (void) appUpdateComplete:(NSDictionary*)appInfo updateAvailable:(BOOL)updateAvailable;
- (void) appUpdateFailed:(NSError*) error;

@end

@interface AppUpdateHelper : NSObject <AppUpdateHelpereDelegate>

@property (nonatomic,strong) NSString *appId;
@property (nonatomic,weak)id <AppUpdateHelpereDelegate> delegate;

@property (nonatomic,readonly) BOOL isNewVersionAvailable;
@property (nonatomic,strong) NSString *localVersion;
@property (nonatomic,strong) NSString *remoteVersion;

+(AppUpdateHelper *)sharedInstance;

-(void)checkNowWithAppId:(NSString *)appId;
-(void)remindMeOneDayLater;
-(void)cancelRemindMeLater;

@end
