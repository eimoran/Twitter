//
//  DetailsViewController.h
//  twitter
//
//  Created by Eric Moran on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetailsViewControllerDelegate

- (void)updateTimeline;

@end

@interface DetailsViewController : UIViewController

@property (nonatomic, weak) id<DetailsViewControllerDelegate> delegate;
@property (weak, nonatomic) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
