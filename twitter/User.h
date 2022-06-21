//
//  User.h
//  twitter
//
//  Created by Eric Moran on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

// MARK: Properties

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profilePicture;


// Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

// Add any additional properties here
@end
