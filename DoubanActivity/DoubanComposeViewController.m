//
//  DoubanComposeViewController.m
//  DoubanActivity
//
//  Created by Johnny iDay on 13-12-17.
//  Copyright (c) 2013年 Johnny iDay. All rights reserved.
//

#import "DoubanComposeViewController.h"
#import <libDoubanApiEngine/DOUAPIEngine.h>

@interface DoubanComposeViewController ()

@end


@implementation DoubanComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[DOUOAuthStore sharedInstance] userId] > 0) {
        [[self.navigationItem.rightBarButtonItems lastObject] setTitle:NSLocalizedStringWithDefaultValue(@"REComposeSheetView_Post", nil, [NSBundle mainBundle], @"Post", @"Post")];
    } else {
        [[self.navigationItem.rightBarButtonItems lastObject] setTitle:NSLocalizedStringWithDefaultValue(@"REComposeSheetView_Login", nil, [NSBundle mainBundle], @"Login", @"Login")];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
