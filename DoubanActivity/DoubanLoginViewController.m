//
//  DoubanLoginViewController.m
//  DoubanActivity
//
//  Created by Johnny iDay on 13-12-8.
//  Copyright (c) 2013年 Johnny iDay. All rights reserved.
//

#import "DoubanLoginViewController.h"

@interface DoubanLoginViewController ()

@end

static NSString * const kRedirectUrl = @"http://www.douban.com/location/mobile";

@interface NSString (ParseCategory)
- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue
                                           outterGlue:(NSString *)outterGlue;
@end

@implementation NSString (ParseCategory)

- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue
                                           outterGlue:(NSString *)outterGlue {
    // Explode based on outter glue
    NSArray *firstExplode = [self componentsSeparatedByString:outterGlue];
    NSArray *secondExplode;
    
    // Explode based on inner glue
    NSInteger count = [firstExplode count];
    NSMutableDictionary* returnDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        secondExplode =
        [(NSString*)[firstExplode objectAtIndex:i] componentsSeparatedByString:innerGlue];
        if ([secondExplode count] == 2) {
            [returnDictionary setObject:[secondExplode objectAtIndex:1]
                                 forKey:[secondExplode objectAtIndex:0]];
        }
    }
    return returnDictionary;
}

@end

@implementation DoubanLoginViewController

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
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:[kAuthUrl stringByAppendingString:@"?client_id=%@&redirect_uri=%@&response_type=code"], [DOUService sharedInstance].clientId, kRedirectUrl]]];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh:(id)sender
{
    [_webView reload];
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *urlObj =  [request URL];
    NSString *url = [urlObj absoluteString];
    
    
    if ([url hasPrefix:kRedirectUrl]) {
        
        NSString* query = [urlObj query];
        NSMutableDictionary *parsedQuery = [query explodeToDictionaryInnerGlue:@"="
                                                                    outterGlue:@"&"];
        
        //access_denied
        NSString *error = [parsedQuery objectForKey:@"error"];
        if (error) {
            return NO;
        }
        
        //access_accept
        NSString *code = [parsedQuery objectForKey:@"code"];
        DOUOAuthService *service = [DOUOAuthService sharedInstance];
        service.authorizationURL = kTokenUrl;
        service.clientId = [DOUService sharedInstance].clientId;
        service.clientSecret = [DOUService sharedInstance].clientSecret;
        service.callbackURL = kRedirectUrl;
        service.authorizationCode = code;
        
        [service validateAuthorizationCode];
        
        return NO;
    }
    
    return YES;
}

@end
