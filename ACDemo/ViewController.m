//
//  ViewController.m
//  ACDemo
//
//  Created by alan on 2013/10/31.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "AdMobViewController.h"
#import "TestingViewController.h"
#import "GPSViewController.h"
#import "FMDBViewController.h"
#import "VponViewController.h"
#import "IAPViewController.h"

@interface ViewController ()

@property (nonatomic,strong)NSMutableArray *array;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"ACDemo";
    
    _array = [NSMutableArray arrayWithObjects:@"Test" ,@"GPS",@"FMDB", @"ADMob",@"Vpon",@"IAP",nil];
}

-(void)speak:(NSString *)str
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:str];
    utterance.rate= 0.2;
    
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
    [synth speakUtterance:utterance];
}

#pragma mark - table

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
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSString *str= [_array objectAtIndex:indexPath.row];
//    [self speak:str];
    
    if(indexPath.row ==0)
    {
        TestingViewController *vc= [[TestingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.row ==1)
    {
        GPSViewController *vc= [[GPSViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.row ==2)
    {
        FMDBViewController *vc= [[FMDBViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.row ==3)
    {
        AdMobViewController *vc= [[AdMobViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.row ==4)
    {
        VponViewController *vc= [[VponViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.row ==5)
    {
        IAPViewController *vc = [[IAPViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



@end
