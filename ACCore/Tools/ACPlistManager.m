//
//  ACPlistManager.m
//  ACDemo
//
//  Created by alan on 2013/11/6.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "ACPlistManager.h"

@implementation ACPlistManager

+(ACPlistManager *)sharedInstance
{
    static ACPlistManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ACPlistManager alloc] init];
    });
    
    return sharedInstance;
}


-(id)init
{
    self = [super init];
    
    if(self)
    {        
        ///Users/alan/Library/Application Support/iPhone Simulator/7.0.3-64/Applications/61DFFEEC-190C-43A5-9433-267112F535B9/Documents/plists
        
        NSString *plistsRootPath =  [self plistsRootPath];
        [ACPlistManager createFolderIfNeed:plistsRootPath];
    }
    
    return self;
}

-(NSString *)plistsRootPath
{
    return [[ACPlistManager documentsDirectoryPath] stringByAppendingPathComponent:@"plists"];
}

+(NSString *)documentsDirectoryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    return documentsDirectory;
}


+(NSString *)createFolderIfNeed:(NSString *)path
{
    NSError *error = nil;
   
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        if([[NSFileManager defaultManager] createDirectoryAtPath:path
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:&error])
        {
            
        }
        else
        {
            NSLog(@"ERROR: createDirectoryAtPath %@ failed.",path);
            return nil;
        }
    }
    
    return path;
}

-(NSArray *)allExistedFiles
{
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:[self plistsRootPath]];
    
    NSMutableArray *array= [NSMutableArray array];
    NSString *filename;
    
    while ((filename = [direnum nextObject])) {
        if ([filename hasSuffix:@"plist"])
        {
            [array addObject:[[self plistsRootPath] stringByAppendingPathComponent:filename]];
        }
    }
    
    return [NSArray arrayWithArray:array];
}

-(BOOL) writeObject:(id)obj toPlist:(NSString*)plistName 
{
    if (![plistName hasSuffix:@"plist"]) {
        plistName = [plistName stringByAppendingPathExtension:@"plist"];
    }
    
    NSString *plistsRootPath =  [self plistsRootPath];
    NSString *path = [plistsRootPath stringByAppendingPathComponent:plistName];
    
    if([obj respondsToSelector:@selector(writeToFile: atomically:)] && path)
    {
        return [obj writeToFile:path atomically:YES];
    }
    
    return NO;
}

-(NSArray *) getArrayFromPlistName:(NSString*)plistName
{
    if (![plistName hasSuffix:@"plist"]) {
        plistName = [plistName stringByAppendingPathExtension:@"plist"];
    }
    
    NSString *path =  [[self plistsRootPath] stringByAppendingPathComponent:plistName];
    
    BOOL isFileExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    NSArray *array =  nil;
    
    if (isFileExist) {
        array = [NSArray arrayWithContentsOfFile:path];
    }
    
    return array;
}


-(NSDictionary *) getDictionaryFromPlistName:(NSString*)plistName
{
    if (![plistName hasSuffix:@"plist"]) {
        plistName = [plistName stringByAppendingPathExtension:@"plist"];
    }
    
    NSString *path =  [[self plistsRootPath] stringByAppendingPathComponent:plistName];
    
    BOOL isFileExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    NSDictionary *dict =  nil;
    
    if (isFileExist) {
        dict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    return dict;
}

-(BOOL)removePlistWithName:(NSString *)plistName
{
    if (![plistName hasSuffix:@"plist"]) {
        plistName = [plistName stringByAppendingPathExtension:@"plist"];
    }
    
    NSString *path = [[self plistsRootPath] stringByAppendingPathComponent:plistName];
    
    if ([[NSFileManager defaultManager] isDeletableFileAtPath:path]) {
        return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    
    return NO;
}

-(void)removeAllPlist
{
    NSArray *allPlist = [self allExistedFiles];
    
    [allPlist enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *path = obj;
        
        if ([[NSFileManager defaultManager] isDeletableFileAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
    }];
}

@end
