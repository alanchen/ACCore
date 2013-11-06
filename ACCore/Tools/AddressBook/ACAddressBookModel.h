//
//  ACAddressBookModel.h
//  ACDemo
//
//  Created by alan on 2013/11/6.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

@interface ACAddressBookModel : NSObject

-(id)initWithAddressBookRef:(ABRecordRef)AddressBookRecordRef;

@property (nonatomic, strong) NSNumber * id;
@property (nonatomic, strong) NSString * firstName;
@property (nonatomic, strong) NSString * lastName;
@property (nonatomic, strong) NSString * fullName;
@property (nonatomic, strong) NSMutableArray * emails;
@property (nonatomic, strong) NSMutableArray * phones;
@property (nonatomic, strong) NSMutableArray * addresses;

-(ABRecordRef)personABRecordRef;

+(ABRecordRef)createABRecordRefWithName:(NSString *)name
                                  phone:(NSString *)phone
                                  email:(NSString *)email;

@end
