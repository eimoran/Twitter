//
//  ComposeViewController.m
//  twitter
//
//  Created by Eric Moran on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeField;
- (IBAction)didTapClose:(id)sender;
- (IBAction)didTapTweet:(id)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.composeField becomeFirstResponder];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.characterCount.text = @"0/280 Characters";
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString *substring = [NSString stringWithString:self.composeField.text];
    
    self.characterCount.hidden = false;
    
    self.characterCount.text = [NSString stringWithFormat:@"%lu/280 Characters", substring.length];
    
    
    
    if (substring.length == 280)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Character Count Reached" message:@"You have reached the maximum amount of characters" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        self.characterCount.textColor = [UIColor redColor];
    }
    else if (substring.length < 280)
    {
        self.characterCount.textColor = [UIColor blackColor];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapTweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.composeField.text completion:^(Tweet *tweet, NSError *error) {
        if (error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);

        }
        else {
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
        
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
