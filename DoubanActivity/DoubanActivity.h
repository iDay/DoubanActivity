//
//  DoubanActivity.h
//  DoubanActivity
//
//  Created by Johnny iDay on 13-12-6.
//  Copyright (c) 2013年 Johnny iDay. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IMAGE_EXTENSION @[@"jpg", @"png"]

@interface DoubanActivity : UIActivity <UIAlertViewDelegate>

- (id)initWithViewController:(UIViewController *)viewController apiKey:(NSString *)apiKey privateKey:(NSString *)privateKey;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIViewController *viewController;

@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *privateKey;

@end

@protocol DoubanActivityDelegate <NSObject>

- (void)loginView;

@end