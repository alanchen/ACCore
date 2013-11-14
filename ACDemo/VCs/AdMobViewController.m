//
//  AdMobViewController.m
//  ACDemo
//
//  Created by alan on 2013/11/14.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "AdMobViewController.h"
#import "GADBannerView.h"
#import "GADInterstitial.h"

@interface AdMobViewController ()<UITableViewDataSource,UITableViewDelegate,GADBannerViewDelegate,GADInterstitialDelegate>
{
    GADBannerView *bannerView_;
    GADInterstitial *interstitial_;
}

@property(nonatomic,strong)IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *array;

@end

@implementation AdMobViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _array = [NSMutableArray array];
    for(int i= 0 ;i<50;i++){
        [_array addObject:@"AdMob"];}
    
    self.tableView =[[UITableView alloc] initWithFrame:self.view.frame];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self admobTesting];
    [self admobTesting2];
}

-(void)admobTesting
{
    bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            self.view.frame.size.height -
                                            GAD_SIZE_320x50.height,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
    
    bannerView_.adUnitID = @"a152847e82f22d8";
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:
                           GAD_SIMULATOR_ID,
                           @"c3a9ad3b80cc93e9d2d23b840b6e72d9a1f209cc",
                           nil];
    
    bannerView_.delegate  = self;
    [bannerView_ loadRequest:request];
}

-(void)admobTesting2
{
    interstitial_ = [[GADInterstitial alloc] init];
    interstitial_.adUnitID = @"a152847e82f22d8";
    
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:
                           GAD_SIMULATOR_ID,
                           @"c3a9ad3b80cc93e9d2d23b840b6e72d9a1f209cc",
                           nil];
    
    [interstitial_ loadRequest:request];
    interstitial_.delegate = self;
}

#pragma mark - adDelegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    [UIView beginAnimations:@"BannerSlide" context:nil];
    bannerView.frame = CGRectMake(0.0,
                                  self.view.frame.size.height -
                                  bannerView.frame.size.height,
                                  bannerView.frame.size.width,
                                  bannerView.frame.size.height);
    [UIView commitAnimations];
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial
{
     [interstitial_ presentFromRootViewController:self];
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
