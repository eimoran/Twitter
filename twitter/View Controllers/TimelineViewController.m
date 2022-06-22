//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSMutableArray *arrayOfTweets;
- (IBAction)didTapLogout:(id)sender;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.arrayOfTweets = [[NSMutableArray alloc] init];
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
//            NSLog(@"%@", tweets);
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
//                NSString *text = tweet.text;
//                NSString *favorites = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
                [self.arrayOfTweets addObject:tweet];
//                NSLog(@"%@", text);
//                NSLog(@"%d", tweet.favoriteCount);
            }
//            NSLog(@"%d", self.arrayOfTweets.count);
//            NSLog(@"%@", self.arrayOfTweets);
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"HELLO");
//    NSLog(@"%@", self.arrayOfTweets);
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    cell.tweet = self.arrayOfTweets[indexPath.row];
//    NSLog(@"%@", cell.tweet);
    
//    NSLog(@"%@", user.screenName);
    cell.displayName.text = cell.tweet.user.screenName;
    cell.date.text = [NSString stringWithFormat:@" %@", cell.tweet.createdAtString];
    cell.text.text = cell.tweet.text;
    cell.userName.text = [NSString stringWithFormat:@"@%@", cell.tweet.user.name];
    cell.retweets.text = [NSString stringWithFormat:@"%d", cell.tweet.retweetCount];
    cell.favorites.text = [NSString stringWithFormat:@"%d", cell.tweet.favoriteCount];
    
    
    // Set Profile Pic
    NSString *URLString = cell.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
//    NSData *urlData = [NSData dataWithContentsOfURL:url];
    cell.profilePic.image = nil;
    [cell.profilePic setImageWithURL:url];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfTweets.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}
@end
