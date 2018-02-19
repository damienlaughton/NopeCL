//
//  MasterViewController.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "MasterViewController.h"
#import "CakeViewModel.h"
#import "CakeCell.h"
#import "Cake.h"

@interface MasterViewController ()

@property (strong, nonatomic) CakeViewModel *cakeViewModel;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
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

- (void)getData{
  
    NSURL *url = [CakeViewModel cakesURL];
    
    __block NSArray *objects;
  
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession]
                                          dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                              NSError *jsonError;
                                              id responseData = [NSJSONSerialization
                                                                 JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                 error:&jsonError];
                                              if (!jsonError){
                                                  objects = responseData;
                                                  
                                                  self.cakeViewModel = [[CakeViewModel alloc] initWithDictionaryObjects:objects];
                                               
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      [self.tableView reloadData];
                                                  });
                                                  
                                              } else {
                                              }
                                          }];
  
  
    [downloadTask resume];
}

@end
