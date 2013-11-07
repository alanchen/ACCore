//
//  ACAddressBookManager.h
//  ACDemo
//
//  Created by alan on 2013/11/7.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@class ACAddressBookModel;

@interface ACAddressBookManager : NSObject

@property (nonatomic,strong) NSMutableArray *contacts;    // ACAddressBookModel array

+ (ACAddressBookManager *)sharedInstance;
- (ACAddressBookModel *) getContactByDeviceID:(NSNumber *)personId;

- (void)fetch:(void (^)(BOOL success , NSArray *results))completionHandler;



@end
