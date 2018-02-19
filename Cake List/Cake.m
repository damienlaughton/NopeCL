//
//  Cake.m
//  Cake List
//
//  Created by Damien Laughton on 19/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import "Cake.h"

@interface Cake (Private)

    @property (strong, nonatomic) UIImage *cakeImage;

@end

@implementation Cake

@synthesize cakeImage = _cakeImage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
{
    if (self == [super init])
    {
        self.cakeName = dictionary[@"title"];
        self.cakeDescription = dictionary[@"desc"];
        self.cakeImagePath = dictionary[@"image"];
        
        [self fetchCakeImageForPath:self.cakeImagePath];
    }
    
    return self;
}

- (void)fetchCakeImageForPath:(NSString *)path;
{
    NSURL *URL = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:URL];
    _cakeImage = [UIImage imageWithData:data];
}

@end
