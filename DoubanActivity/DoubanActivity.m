//
//  DoubanActivity.m
//  DoubanActivity
//
//  Created by Johnny iDay on 13-12-6.
//  Copyright (c) 2013年 Johnny iDay. All rights reserved.
//

#import "DoubanActivity.h"
#import "REComposeViewController.h"
#import <libDoubanApiEngine/DOUAPIEngine.h>
#import "DoubanLoginViewController.h"

@implementation DoubanActivity

- (id)initWithViewController:(UIViewController *)viewController apiKey:(NSString *)apiKey privateKey:(NSString *)privateKey
{
    self = [self init];
    if (self) {
        if (viewController) {
            _viewController = viewController;
        } else {
            _viewController = [[UIApplication sharedApplication].delegate window].rootViewController;
        }
        [DOUService sharedInstance].clientId = apiKey;
        [DOUService sharedInstance].clientSecret = privateKey;
        [DOUService sharedInstance].apiBaseUrlString = kHttpsApiBaseUrl;
    }
    return self;
}

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityTitle
{
    return @"豆瓣";
}

- (NSString *)activityType
{
    return NSStringFromClass([self class]);
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"icon_douban.png"];
}

- (BOOL) canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id item in activityItems) {
        if ([item isKindOfClass:[NSString class]]) {
            return YES;
        }
        if ([item isKindOfClass:[UIImage class]]) {
            return YES;
        }
        if ([item isKindOfClass:[NSURL class]]) {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id item in activityItems) {
        if ([item isKindOfClass:[NSString class]]) {
            _title = item;
        }
        if ([item isKindOfClass:[UIImage class]]) {
            _image = item;
        }
        if ([item isKindOfClass:[NSURL class]]) {
            if ([IMAGE_EXTENSION containsObject:[[item pathExtension] lowercaseString]]) {
                _imageUrl = item;
            } else {
                _url = item;
            }
        }
    }
}

- (void)performActivity
{
    REComposeViewController *composeView = [[REComposeViewController alloc] init];
    if (!REUIKitIsFlatMode()) {
        composeView.navigationBar.tintColor = [UIColor colorWithRed:0.11f green:0.58f blue:0.22f alpha:1.0f];
    }
    if (_image) {
        composeView.text = _title;
    }
    composeView.title = self.activityTitle;
    if (_image) {
        composeView.attachmentImage = _image;
        composeView.hasAttachment = YES;
    } else if (_imageUrl) {
        composeView.attachmentImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:_imageUrl]];
        composeView.hasAttachment = YES;
    }
    [self activityDidFinish:YES];
    if ([[DOUOAuthStore sharedInstance] userId] == 0) {
        [[composeView.navigationItem.rightBarButtonItems lastObject] setTitle:@"登录"];
    }
    
    composeView.completionHandler = ^(REComposeViewController *composeViewController, REComposeResult result) {
        [composeViewController dismissViewControllerAnimated:YES completion:nil];
        switch (result) {
            case REComposeResultPosted:
                if ([[DOUOAuthStore sharedInstance] userId] == 0) {
                    DoubanLoginViewController *loginView = [[DoubanLoginViewController alloc] init];
                    UINavigationController *navView = [[UINavigationController alloc] initWithRootViewController:loginView];
                    [_viewController presentViewController:navView animated:YES completion:^{
                    }];
                } else {
                    DOUQuery *query = [[DOUQuery alloc] initWithSubPath:@"/shuo/v2/statuses/" parameters:nil];
                    if (_image) {
                        [[DOUService sharedInstance] post2:query photoData:UIImageJPEGRepresentation(_image, 1.0f) description:_title callback:^(DOUHttpRequest *req) {
                            if (req.error) {
                                NSLog(@"%@", [req.error description]);
                            }
                        } uploadProgressDelegate:nil];
                    } else {
                        NSMutableString *bodyStr = [NSMutableString stringWithFormat:@"text=%@&rec_title=%@", composeViewController.text, _title];
                        if (_url) {
                            [bodyStr appendFormat:@"&rec_url=%@", _url];
                        }
                        if (_imageUrl) {
                            [bodyStr appendFormat:@"&rec_image=%@", _imageUrl];
                        }
                        [[DOUService sharedInstance] post:query postBody:bodyStr callback:^(DOUHttpRequest *req) {
                            if (req.error) {
                                NSLog(@"%@", [req.error description]);
                            }
                        }];
                    }
                }
                break;
            default:
                break;
        }
    };
    [composeView presentFromViewController:_viewController];
}

@end
