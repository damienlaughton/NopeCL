//
//  CakeViewModel.h
//  Cake List
//
//  Created by Damien Laughton on 19/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cake.h"

@protocol CakeViewModelDelegate <NSObject>

- (void)cakeViewModelUpdated;

@end

@interface CakeViewModel : NSObject

@property (weak, nonatomic) id<CakeViewModelDelegate> delegate;

+ (NSURL *)cakesURL;

- (instancetype)initWithDelegate:(id<CakeViewModelDelegate>)delegate;

- (NSInteger)numberOfCakes;

- (Cake *)cakeAtIndexPath:(NSIndexPath *)indexPath;

@end
