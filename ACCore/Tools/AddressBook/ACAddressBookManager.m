//
//  ACAddressBookManager.m
//  ACDemo
//
//  Created by alan on 2013/11/7.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "ACAddressBookManager.h"
#import "ACAddressBookModel.h"

@implementation ACAddressBookManager

+ (ACAddressBookManager *)sharedInstance {
    static ACAddressBookManager *sharedAddressBook = nil;
    
    @synchronized(self) {
        if (sharedAddressBook == nil) {
            sharedAddressBook =  [[self alloc] init];
        }
    }
    return sharedAddressBook;
}

-(ACAddressBookModel *) getContactByDeviceID:(NSNumber *)personId
{
    if(personId==nil) return nil;
    
    __block ACAddressBookModel *result ;
    
    [self.contacts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        ACAddressBookModel *contact = obj;
        
        if([contact.id isEqualToNumber:personId]){
            result = contact;
            *stop = YES;
        }
    }];
    
    return  result;
}

-(void)fetch:(void (^)(BOOL success , NSArray *results))completionHandler
{
    ABAddressBookRef myAddressBook = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        myAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(myAddressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_semaphore_signal(sema);
                                                 });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    
    if(myAddressBook==nil){
        NSLog(@"******* CAN NOT GET CONTACT LIST ******* ");
        if(completionHandler){completionHandler(NO,nil);}
        return ;
    }
    
    NSMutableArray *contacts = [NSMutableArray array];
    CFArrayRef arrayOfEntries = ABAddressBookCopyArrayOfAllPeople(myAddressBook);
    CFIndex countOfEntries = CFArrayGetCount(arrayOfEntries);
    
    for (int i=0; i!=countOfEntries; i++){
        ABRecordRef currentRecord = CFArrayGetValueAtIndex(arrayOfEntries, i);
        ACAddressBookModel *contact = [[ACAddressBookModel alloc] initWithAddressBookRef:currentRecord];
        [contacts addObject:contact];
    }
    
    _contacts = contacts;
    
    if(completionHandler){completionHandler(YES,contacts);}
    
    CFRelease(arrayOfEntries);
    CFRelease(myAddressBook);
}



@end
