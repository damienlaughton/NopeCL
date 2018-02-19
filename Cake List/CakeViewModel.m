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

- (instancetype)initWithDictionaryObjects:(NSArray <NSDictionary *>*)objects;
{
    if (self == [super init])
    {
        self.cakes = [[NSMutableArray alloc] initWithCapacity:objects.count];
        
        for (NSDictionary *dictionary in objects) {
            Cake *cake = [[Cake alloc] initWithDictionary:dictionary];
            if (cake)
            {
                [self.cakes addObject:cake];
            }
        }
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

@end
