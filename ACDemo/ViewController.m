//
//  ViewController.m
//  ACDemo
//
//  Created by alan on 2013/10/31.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FMDatabase.h"

@interface ViewController ()

@property (nonatomic,strong)NSMutableArray *array;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    _array = [NSMutableArray arrayWithObjects:@"Hello" ,@"world",@"Hello world", @"Alan", @"What's up",@"Speech" ,@"AVSpeechSynthesizer",@"An AVSpeechUtterance is the basic unit of speech synthesis. An utterance encapsulates some amount of text to be spoken and a set of parameters affecting its speech: voice, pitch, rate, and delay.",nil];
    
    [self databaseTesting];
    
    [ACGPSManager sharedInstance].timeout = 5;
    [[ACGPSManager sharedInstance] startUpdatingLocation];
    NotificationAdd(self, @selector(gpsSuccess:), GPSManagerNotificationDidUpdate, nil);
    NotificationAdd(self, @selector(gpsFailed:), GPSManagerNotificationDidFail, nil);
    NotificationAdd(self, @selector(gpsTimeout:), GPSManagerNotificationDidTimeout, nil);
}

-(void)gpsSuccess:(NSNotification *)noti
{
    id success = noti.object;
    ACDumpObj(success);
}

-(void)gpsFailed:(NSNotification *)noti
{
    id failed = noti.object;
    ACDumpObj(failed);
}

-(void)gpsTimeout:(NSNotification *)noti
{
    id timeout = noti.object;
    ACDumpObj(timeout);
}

-(void)databaseTesting
{
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"vocabulary.db"];
    FMDatabase* db = [FMDatabase databaseWithPath:dbPath];
    
    if (![db open]) {
        NSLog(@"Could not open db");}
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM toefl"];
    
    while ([rs next]) {
        [_array addObject:[rs stringForColumn:@"word"]]; }
    
    [rs close];
    [db close];
    
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableVieyw numberOfRowsInSection:(NSInteger)section
{
    return  [_array count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainMenuListCell" forIndexPath:indexPath];
//    NSDate *date = [NSDate date];
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *str= [_array objectAtIndex:indexPath.row];
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:str];
    utterance.rate= 0.2;
    
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
    [synth speakUtterance:utterance];
}



@end
