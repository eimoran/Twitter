//
//  TweetCell.m
//  twitter
//
//  Created by Eric Moran on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@implementation TweetCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshData {
    self.text.text = self.tweet.text;
    self.displayName.text = self.tweet.user.name;
    self.userName.text = [NSString stringWithFormat:@"@%@ · %@", self.tweet.user.screenName, self.tweet.createdAtString];
//    self.date.text = self.tweet.createdAtString;
    NSURL *url = [NSURL URLWithString:self.tweet.user.profilePicture];
    [self.profilePic setImageWithURL:url];
    self.retweets.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favorites.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    UIImage *favoriteIcon;
    UIImage *retweetIcon;
    self.btnFavorite.selected = self.tweet.favorited;
    self.btnRetweet.selected = self.tweet.retweeted;
    if (self.btnFavorite.selected)
    {
        favoriteIcon = [UIImage imageNamed:@"favor-icon-red.png"];
    }
    else{
        favoriteIcon = [UIImage imageNamed:@"favor-icon.png"];
    }
    if (self.btnRetweet.selected)
    {
        retweetIcon = [UIImage imageNamed:@"retweet-icon-green.png"];
    }
    else
    {
        retweetIcon = [UIImage imageNamed:@"retweet-icon.png"];
    }
    [self.btnFavorite setImage:favoriteIcon forState:UIControlStateNormal];
    [self.btnRetweet setImage:retweetIcon forState:UIControlStateNormal];
}

- (IBAction)didTapMessage:(id)sender {
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted) {
            self.tweet.retweeted = false;
            self.tweet.retweetCount -= 1;
        } else {
            self.tweet.retweeted = true;
            self.tweet.retweetCount += 1;
        }
    
    [self refreshData];
    
    if (self.tweet.retweeted) {
            [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if (error) {
                    NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
                } else if (tweet) {
                    NSLog(@"Successfully retweeted the following Tweet: \n%@", tweet.text);
                }
            }];
        } else {
            [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if (error) {
                    NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
                } else if (tweet) {
                    NSLog(@"Successfully unfavorited the following Tweet: \n%@", tweet.text);
                }
            }];
        }
}
- (IBAction)didTapFavorite:(id)sender {
    if (self.tweet.favorited) {
            self.tweet.favorited = false;
            self.tweet.favoriteCount -= 1;
        } else {
            self.tweet.favorited = true;
            self.tweet.favoriteCount += 1;
        }
    [self refreshData];
    
    if (self.tweet.favorited) {
            [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if (error) {
                    NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
                } else if (tweet) {
                    NSLog(@"Successfully favorited the following Tweet: \n%@", tweet.text);
                }
            }];
        } else {
            [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if (error) {
                    NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
                } else if (tweet) {
                    NSLog(@"Successfully unfavorited the following Tweet: \n%@", tweet.text);
                }
            }];
        }
}

- (IBAction)didTapReply:(id)sender {
}
@end
