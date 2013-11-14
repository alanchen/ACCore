//
//  GPSViewController.m
//  ACDemo
//
//  Created by alan on 2013/11/14.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "GPSViewController.h"

@interface GPSViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *array;

@end

@implementation GPSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"GPS";
    
    _array = [NSMutableArray array];
    for(int i= 0 ;i<10;i++){
        [_array addObject:@"GPS"];}
    
    self.tableView =[[UITableView alloc] initWithFrame:self.view.frame];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [ACGPSManager sharedInstance].timeout = 5;
    [[ACGPSManager sharedInstance] startUpdatingLocation];
    NotificationAdd(self, @selector(gpsSuccess:), GPSManagerNotificationDidUpdate, nil);
    NotificationAdd(self, @selector(gpsFailed:), GPSManagerNotificationDidFail, nil);
    NotificationAdd(self, @selector(gpsTimeout:), GPSManagerNotificationDidTimeout, nil);
}


-(void)gpsSuccess:(NSNotification *)noti
{
    [_array insertObject:@"Success" atIndex:0];
    [self.tableView reloadData];
}

-(void)gpsFailed:(NSNotification *)noti
{
    [_array insertObject:@"Failed" atIndex:0];
    [self.tableView reloadData];
}

-(void)gpsTimeout:(NSNotification *)noti
{
     [_array insertObject:@"Timeout" atIndex:0];
    [self.tableView reloadData];
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
