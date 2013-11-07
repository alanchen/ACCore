//
//  ACAddressBookModel.m
//  ACDemo
//
//  Created by alan on 2013/11/6.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "ACAddressBookModel.h"

@interface ACAddressBookModel()
{
    ABRecordID _recordID;
    ABRecordRef _person;
}

@end

@implementation ACAddressBookModel

+(ABRecordRef)createABRecordRefWithName:(NSString *)name
                                  phone:(NSString *)phone
                                  email:(NSString *)email
{
    ABRecordRef person = ABPersonCreate();
    CFErrorRef  error = NULL;
    
    if(name)
    {
        ABRecordSetValue(person, kABPersonFirstNameProperty,(__bridge CFTypeRef)name, NULL);
    }
    
    if(email)
    {
        ABMutableMultiValueRef emailRef = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(emailRef, (__bridge CFTypeRef)(email), CFSTR("E-mail"), NULL);
        ABRecordSetValue(person, kABPersonEmailProperty, emailRef, &error);
        CFRelease(emailRef);
    }
    
    if(phone)
    {
        ABMutableMultiValueRef Phone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(Phone, (__bridge CFTypeRef)(phone), CFSTR("Phone"), NULL);
        ABRecordSetValue(person,kABPersonPhoneProperty, Phone, &error);
        CFRelease(Phone);
    }
    
    if (error != NULL) {
        NSLog(@"Error: %@", error);
    }
    
    return person;
}

-(void)importAddressBookRef:(ABRecordRef)AddressBookRecordRef
{
    ABRecordRef currentRecord = AddressBookRecordRef;
    
    CFTypeRef lastNameRef   = ABRecordCopyValue(currentRecord, kABPersonLastNameProperty);
    CFTypeRef firstNameRef  = ABRecordCopyValue(currentRecord, kABPersonFirstNameProperty);
    CFTypeRef fullNameRef   = ABRecordCopyCompositeName(currentRecord);
    
    NSString *lastName      =  (__bridge_transfer NSString *)lastNameRef;
    NSString *firstName     =  (__bridge_transfer NSString *)firstNameRef;
    NSString *fullName      =  (__bridge_transfer NSString *)fullNameRef;
    
    ABMultiValueRef mail    = ABRecordCopyValue(currentRecord, kABPersonEmailProperty);
    NSMutableArray *mailArr =  [[NSMutableArray alloc] init];
    for(CFIndex x=0; x!=ABMultiValueGetCount(mail); x++) {
        CFTypeRef mailRef = ABMultiValueCopyValueAtIndex(mail, x);
        NSString *mailStr = (__bridge_transfer NSString *)mailRef;
        [mailArr addObject:mailStr];
//        CFRelease(mailRef);
    }
    
    ABMultiValueRef phone   = ABRecordCopyValue(currentRecord, kABPersonPhoneProperty);
    NSMutableArray *phoneArr=  [[NSMutableArray alloc] init];
    for(CFIndex x=0; x!=ABMultiValueGetCount(phone); x++) {
        CFTypeRef phoneRef = ABMultiValueCopyValueAtIndex(phone, x);
        NSString *phoneStr = (__bridge_transfer NSString *)phoneRef;
        [phoneArr addObject:phoneStr];
//        CFRelease(phoneRef);
    }
    
    ABMultiValueRef address   = ABRecordCopyValue(currentRecord, kABPersonAddressProperty);
    NSMutableArray *addressArr=  [[NSMutableArray alloc] init];
    for(CFIndex x=0; x!=ABMultiValueGetCount(address); x++) {
        
        CFTypeRef personAddressRef = ABMultiValueCopyValueAtIndex(address, x);
        NSDictionary *personAddress= (__bridge_transfer NSDictionary *)personAddressRef;
        
        NSString *country = [personAddress valueForKey:(__bridge_transfer NSString *)kABPersonAddressCountryKey];
        NSString *city = [personAddress valueForKey:(__bridge_transfer NSString *)kABPersonAddressCityKey];
        NSString *street = [personAddress valueForKey:(__bridge_transfer NSString *)kABPersonAddressStreetKey];
        
        country = country?country:@"";
        city = city?city:@"";
        street = street?street:@"";
        
        NSString *addressStr = [NSString stringWithFormat:@"%@ %@ %@",country,city,street];
        [addressArr addObject:addressStr];
//        CFRelease(personAddressRef);
    }
    
    self.id= [NSNumber numberWithInt:ABRecordGetRecordID(currentRecord)];
    self.firstName = firstName;
    self.lastName = lastName;
    self.fullName = fullName;
    self.emails = mailArr;
    self.phones = phoneArr;
    self.addresses = addressArr;
    
//    CFRelease(firstNameRef);
//    CFRelease(lastNameRef);
//    CFRelease(fullNameRef);
    
    CFRelease(mail);
    CFRelease(phone);
    CFRelease(address);
}

-(id)initWithAddressBookRef:(ABRecordRef)addressBookRecordRef
{
    self = [super init];
    
    if(self)
    {
        _recordID = ABRecordGetRecordID(addressBookRecordRef);
        _person = addressBookRecordRef;
        [self importAddressBookRef:addressBookRecordRef];
    }
    
    return self;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@",self.id,self.fullName];
}

-(ABRecordRef)personABRecordRef
{
    return _person;
}

@end
