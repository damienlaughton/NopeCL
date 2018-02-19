//
//  CakeViewModel.h
//  Cake List
//
//  Created by Damien Laughton on 19/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cake.h"

@interface CakeViewModel : NSObject

+ (NSURL *)cakesURL;

- (instancetype)initWithDictionaryObjects:(NSArray <NSDictionary *>*)objects;

- (NSInteger)numberOfCakes;

- (Cake *)cakeAtIndexPath:(NSIndexPath *)indexPath;

@end
