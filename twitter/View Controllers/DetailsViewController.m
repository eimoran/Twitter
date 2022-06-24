//
//  DetailsViewController.m
//  twitter
//
//  Created by Eric Moran on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *retweets;
@property (weak, nonatomic) IBOutlet UILabel *favorites;
@property (nonatomic) BOOL *favorited;
@property (nonatomic) BOOL *retweeted;
@property (weak, nonatomic) IBOutlet UIButton *btnRetweet;
- (IBAction)didTapRetweet:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorite;
- (IBAction)didTapFavorite:(id)sender;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshData];
    
}

- (void)refreshData {
    self.text.text = self.tweet.text;
    self.displayName.text = self.tweet.user.name;
    self.userName.text = [NSString stringWithFormat:@"@%@·", self.tweet.user.screenName];
    self.date.text = self.tweet.createdAtString;
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
    
    [self.cell refreshData];
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
    
    
    if (self.tweet.retweeted) {
            [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if (error) {
                    NSLog(@"Error retweetinge tweet: %@", error.localizedDescription);
                } else if (tweet) {
                    NSLog(@"Successfully retweeted the following Tweet: \n%@", tweet.text);
                }
            }];
        } else {
            [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
                if (error) {
                    NSLog(@"Error unretweeted tweet: %@", error.localizedDescription);
                } else if (tweet) {
                    NSLog(@"Successfully unretweeted the following Tweet: \n%@", tweet.text);
                }
            }];
        }
    [self.cell refreshData];
//    [self.delegate getTimeline];
}
- (IBAction)didTapFavorite:(id)sender {
    if (self.tweet.favorited) {
            self.tweet.favorited = false;
            self.tweet.favoriteCount -= 1;
        } else {
            self.tweet.favorited = true;
            self.tweet.favoriteCount += 1;
        }
    
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
    [self.cell refreshData];
}

- (IBAction)didTapReply:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
