//
//  FMDBViewController.m
//  ACDemo
//
//  Created by alan on 2013/11/14.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "FMDBViewController.h"
#import "FMDatabase.h"

@interface FMDBViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *array;

@end

@implementation FMDBViewController


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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _array = [NSMutableArray array];
    
    self.tableView =[[UITableView alloc] initWithFrame:self.view.frame];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    [self databaseTesting];
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
