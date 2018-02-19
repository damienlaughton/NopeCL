//
//  Cake.h
//  Cake List
//
//  Created by Damien Laughton on 19/02/2018.
//  Copyright © 2018 Stewart Hart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Cake : NSObject

    @property (strong, nonatomic) NSString *cakeName;
    @property (strong, nonatomic) NSString *cakeDescription;
    @property (strong, nonatomic) NSString *cakeImagePath;
    @property (readonly, nonatomic) UIImage *cakeImage;

    - (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
