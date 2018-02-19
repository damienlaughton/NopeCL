//
//  CakeViewModel.m
//  Cake List
//
//  Created by Damien Laughton on 19/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "CakeViewModel.h"

@interface CakeViewModel ()

@property (strong, nonatomic) NSMutableArray <Cake *>*cakes;

@end

@implementation CakeViewModel

+ (NSURL *)cakesURL;
{
    NSURL *cakesURL = [NSURL URLWithString:@"https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"];
    
    return cakesURL;
}

- (instancetype)initWithDelegate:(id<CakeViewModelDelegate>)delegate;
{
    if (self == [super init]) {
        self.delegate = delegate;
        [self fetchCakes];
    }
    
    return self;
}

- (NSInteger)numberOfCakes;
{
    return self.cakes.count;
}

- (Cake *)cakeAtIndexPath:(NSIndexPath *)indexPath;
{
    Cake *cake = self.cakes[indexPath.row];
    
    return cake;
}

- (void)refreshRequest;
{
    [self fetchCakes];
}

// Get ALL the cake

- (void)fetchCakes;
{
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
                                                  
                                                  NSMutableArray <Cake *>*newCakes =
                                                  
                                                   [[NSMutableArray alloc] initWithCapacity:objects.count];
                                                  
                                                  for (NSDictionary *dictionary in objects) {
                                                      Cake *cake = [[Cake alloc] initWithDictionary:dictionary];
                                                      if (cake)
                                                      {
                                                          [newCakes addObject:cake];
                                                      }
                                                  }
                                                  
                                                  self.cakes = newCakes;
                                                  
                                                  if ([self.delegate respondsToSelector:@selector(cakeViewModelUpdated)]) {
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          [self.delegate cakeViewModelUpdated];
                                                      });
                                                  }
                                                  
                                              } else {
                                              }
                                          }];
    
    
    [downloadTask resume];
}

@end
