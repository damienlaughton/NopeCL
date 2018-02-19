//
//  CakeCell.m
//  Cake List
//
//  Created by Stewart Hart on 19/05/2015.
//  Copyright (c) 2015 Stewart Hart. All rights reserved.
//

#import "CakeCell.h"

@implementation CakeCell

- (void)configureWithCake:(Cake *)cake;
{
    self.titleLabel.text = cake.cakeName;
    self.descriptionLabel.text = cake.cakeDescription;
    self.cakeImageView.image = cake.cakeImage;
}

@end
