//
//  ACPlistManager.h
//  ACDemo
//
//  Created by alan on 2013/11/6.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACPlistManager : NSObject

+(ACPlistManager *)sharedInstance;
-(NSString *)plistsRootPath;
-(NSArray *)allExistedFiles;

-(BOOL) writeObject:(id)obj toPlist:(NSString*)plistName;
-(NSArray *) getArrayFromPlistName:(NSString*)plistName;
-(NSDictionary *) getDictionaryFromPlistName:(NSString*)plistName;

-(BOOL)removePlistWithName:(NSString *)plistName;
-(void)removeAllPlist;

@end