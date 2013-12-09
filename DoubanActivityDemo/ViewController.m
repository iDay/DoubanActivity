//
//  ViewController.m
//  DoubanActivity
//
//  Created by Johnny iDay on 13-12-6.
//  Copyright (c) 2013年 Johnny iDay. All rights reserved.
//

#import "ViewController.h"
#import "DoubanActivity.h"
#import <libDoubanApiEngine/DOUAPIEngine.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)share:(id)sender
{
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[@"这里是标题", [NSURL URLWithString:@"http://www.google.com"], [UIImage imageNamed:@"OAuth"]] applicationActivities:@[[[DoubanActivity alloc] initWithViewController:self apiKey:@"04e0b2ab7ca02a8a0ea2180275e07f9e" privateKey:@"4275ee2fa3689a2f"]]];
    activityView.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint];
    [self presentViewController:activityView animated:YES completion:nil];
}

- (IBAction)share2:(id)sender
{
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[@"这里是标题", [NSURL URLWithString:@"http://www.google.com"], [NSURL URLWithString:@"https://www.google.com/images/srpr/logo11w.png"]] applicationActivities:@[[[DoubanActivity alloc] initWithViewController:self apiKey:@"04e0b2ab7ca02a8a0ea2180275e07f9e" privateKey:@"4275ee2fa3689a2f"]]];
    activityView.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint];
    [self presentViewController:activityView animated:YES completion:nil];
}

- (IBAction)logout:(id)sender
{
    [[DOUOAuthService sharedInstance] logout];
}

@end
