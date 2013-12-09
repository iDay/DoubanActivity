//
//  DoubanLoginViewController.h
//  DoubanActivity
//
//  Created by Johnny iDay on 13-12-8.
//  Copyright (c) 2013年 Johnny iDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <libDoubanApiEngine/DOUAPIEngine.h>

@interface DoubanLoginViewController : UIViewController <UIWebViewDelegate, DOUOAuthServiceDelegate>

@property (nonatomic, strong) IBOutlet UIWebView *webView;

@end
