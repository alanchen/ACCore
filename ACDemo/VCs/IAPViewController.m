//
//  IAPViewController.m
//  ACDemo
//
//  Created by alan on 2014/2/25.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IAPViewController.h"

@interface IAPViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    IAPHelper *_helper;
    SKProduct *_skProduct;
}

@property(nonatomic,strong)IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *array;

@end

@implementation IAPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title  = @"IAP";
    
    _array = [NSMutableArray arrayWithObjects:@"Load list",@"Buy",@"Restore", nil];
    
    self.tableView =[[UITableView alloc] initWithFrame:self.view.frame];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
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

// test user: Opt12345@gmail.com, password: Opt12345

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row==0)
    {
        NSString *iapTestId  =@"com.tpblog.www.vip";
        
        _helper = [[IAPHelper alloc] initWithProductIdentifiers:[NSSet setWithObject:iapTestId]];
        [_helper requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
            
            NSLog(@"success =  %d products = %@",success,products);
            if([products count])
                _skProduct = [products objectAtIndex:0];
        }];
    }
    else if(indexPath.row==1)
    {
        [_helper buyProduct:_skProduct];
    }
    else if(indexPath.row==2)
    {
        [_helper restoreCompletedTransactions];
    }
}

@end
