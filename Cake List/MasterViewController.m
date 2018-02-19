//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"

#import "CakeCell.h"
#import "Cake.h"

@interface MasterViewController ()

@property (strong, nonatomic) CakeViewModel *cakeViewModel;
@property (strong, nonatomic) UILabel *backgroundLabel;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureBackgroundLabel];
    [self showBackgroundLabel];
    
    self.cakeViewModel = [[CakeViewModel alloc] initWithDelegate:self];
}

- (void)configureBackgroundLabel;
{
    self.backgroundLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height)];
    self.backgroundLabel.text             = @"Fetching Cakes ...";
    self.backgroundLabel.textColor        = [UIColor blackColor];
    self.backgroundLabel.textAlignment    = NSTextAlignmentCenter;
}

- (void)showBackgroundLabel;
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = self.backgroundLabel;
}

- (void)hideBackgroundLabel;
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundView = nil;
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRowsInSection = [self.cakeViewModel numberOfCakes];
    
    return numberOfRowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CakeCell *cell = (CakeCell*)[tableView dequeueReusableCellWithIdentifier:@"CakeCell"];
    
    Cake *cake = [self.cakeViewModel cakeAtIndexPath:indexPath];
    
    [cell configureWithCake:cake];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)refreshPulled:(id)sender;
{
    [self.cakeViewModel refreshRequest];
}

// CakeViewModelDelegate Method(s)

- (void)cakeViewModelUpdated;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
        
        if ([self.cakeViewModel numberOfCakes] > 0) {
            [self hideBackgroundLabel];
        }
        
        [self.tableView reloadData];
    });
}

@end
