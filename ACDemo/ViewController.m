//
//  ViewController.m
//  ACDemo
//
//  Created by alan on 2013/10/31.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic,strong)NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    _array = [NSArray arrayWithObjects:@"Hello" ,@"world",@"Hello world", @"Alan", @"What's up",@"Speech" ,@"AVSpeechSynthesizer",@"An AVSpeechUtterance is the basic unit of speech synthesis. An utterance encapsulates some amount of text to be spoken and a set of parameters affecting its speech: voice, pitch, rate, and delay.",nil];
}

-(void)test
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://162.243.45.45/api/blog/?latlng=25.0396556%2C121.55261480000001" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    
    NSURLSessionConfiguration  * defaultConfigObject  =  [ NSURLSessionConfiguration  defaultSessionConfiguration ];
    NSString  * cachePath  =  @"/MyCacheDirectory" ;
//    NSArray  * myPathList  =  NSSearchPathForDirectoriesInDomains ( NSCachesDirectory ,  NSUserDomainMask ,  YES );
//    NSString  * myPath     =  [ myPathList   objectAtIndex: 0 ];
//    NSString  * bundleIdentifier  =  [[ NSBundle  mainBundle ]  bundleIdentifier ];
//    NSString  * fullCachePath  =  [[ myPath  stringByAppendingPathComponent: bundleIdentifier ]  stringByAppendingPathComponent: cachePath ];
    NSURLCache  * myCache  =  [[ NSURLCache  alloc ]  initWithMemoryCapacity :  16384  diskCapacity:  268435456  diskPath:  cachePath ];
    defaultConfigObject . URLCache  =  myCache ;
    
    NSURLSession  * delegateFreeSession  =  [ NSURLSession  sessionWithConfiguration:  defaultConfigObject  delegate:  nil  delegateQueue:  [ NSOperationQueue  mainQueue ]];
    
    [[ delegateFreeSession  dataTaskWithURL:  [ NSURL  URLWithString:  @"http://162.243.45.45/api/blog/?latlng=25.0396556%2C121.55261480000001" ]
                          completionHandler: ^ ( NSData  * data ,  NSURLResponse  * response ,
                                                NSError  * error )  {
                              NSLog ( @"Got response %@ with error %@. \n " ,  response ,  error );
                              NSLog ( @"DATA: \n %@ \n END DATA \n " ,
                                     [[ NSString  alloc ]  initWithData:  data
                                                               encoding:  NSUTF8StringEncoding ]);
                          }]  resume ];


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
