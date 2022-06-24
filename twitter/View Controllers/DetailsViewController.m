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

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.cell refreshData];
    
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
    self.cell.btnFavorite.selected = self.tweet.favorited;
    self.cell.btnRetweet.selected = self.tweet.retweeted;
    if (self.cell.btnFavorite.selected)
    {
        favoriteIcon = [UIImage imageNamed:@"favor-icon-red.png"];
    }
    else{
        favoriteIcon = [UIImage imageNamed:@"favor-icon.png"];
    }
    if (self.cell.btnRetweet.selected)
    {
        retweetIcon = [UIImage imageNamed:@"retweet-icon-green.png"];
    }
    else
    {
        retweetIcon = [UIImage imageNamed:@"retweet-icon.png"];
    }
    [self.cell.btnFavorite setImage:favoriteIcon forState:UIControlStateNormal];
    [self.cell.btnRetweet setImage:retweetIcon forState:UIControlStateNormal];
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
