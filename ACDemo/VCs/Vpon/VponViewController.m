//
//  VponViewController.m
//  ACDemo
//
//  Created by alan on 2013/11/14.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "VponViewController.h"
#import "VponBanner.h"
#import "VponInterstitial.h"
#import "GADBannerView.h"

@interface VponViewController ()<UITableViewDataSource,UITableViewDelegate,VponBannerDelegate>
{
    GADBannerView *bannerView_;
    
    VponBanner *          vponAd ;  //宣告使用VponBanner廣告
    VponInterstitial *    vponInterstitial ;  //宣告使用Vpon插屏廣告
    Platform plat ;  //宣告使用拉取廣告的地區
}

@property(nonatomic,strong)IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *array;

@end


@implementation VponViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title  = @"Vpon";
    
    _array = [NSMutableArray array];
    for(int i= 0 ;i<20;i++){
        [_array addObject:@"Vpon"];}
    
    self.tableView =[[UITableView alloc] initWithFrame:self.view.frame];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
//    [self vponTesting];
    [self admobWithVponTesting];
}

-(void)admobWithVponTesting
{
    bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            self.view.frame.size.height -
                                            GAD_SIZE_320x50.height,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
    
    bannerView_.adUnitID = @"50d56c9da71e4cab";//admob+vpon: 50d56c9da71e4cab  admob: a152847e82f22d8
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:
                           GAD_SIMULATOR_ID,
                           @"c3a9ad3b80cc93e9d2d23b840b6e72d9a1f209cc",
                           nil];
    [bannerView_ loadRequest:request];
}


-(void)vponTesting
{
    BOOL bStatusBarHide =  [UIApplication sharedApplication ] . statusBarHidden ;
    float screenHeight =  [[ UIScreen mainScreen ] bounds ] . size . height ;
    if ( ! bStatusBarHide ) screenHeight -=  20 ;
    CGPoint origin = CGPointMake ( 0.0 ,screenHeight - CGSizeFromVponAdSize ( VponAdSizeSmartBannerPortrait ) . height ) ;
    vponAd =  [ [ VponBanner alloc ] initWithAdSize : VponAdSizeSmartBannerPortrait origin : origin ];
    vponAd. strBannerId  = @"8a808182422c2d7301425645198719c3" ;
    vponAd. delegate  = self ;
    vponAd. platform  = TW ;            //台灣地區請填TW大陸則填CN
    [vponAd setAdAutoRefresh : YES ] ;  //如果為mediation則set NO
    [vponAd setRootViewController : self ] ;
    [self.view addSubview:[vponAd getVponAdView]];  //將VponBanner的View加入此ViewController中
    [vponAd startGetAd : [self getTestIdentifiers]];

}

- ( NSArray * ) getTestIdentifiers
{
    return  [ NSArray arrayWithObjects :
             @"c3a9ad3b80cc93e9d2d23b840b6e72d9a1f209cc",
             nil ] ;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
