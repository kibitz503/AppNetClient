//
//  PostDetailViewController.m
//  AppNetClient
//
//  Created by Tom Dolan on 3/21/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import "PostDetailViewController.h"

@interface PostDetailViewController ()

@end

@implementation PostDetailViewController

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
    [self setupNav];
    [self setupWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegates
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.loadingLabel setHidden:NO];
    [self.activityIndicator startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    [self.loadingLabel setHidden:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
    [self.loadingLabel setHidden:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  
}

#pragma mark - Utilites

-(void)setupNav
{
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectZero];
    title.textColor = [UIColor colorWithRed:(209/255.f) green:(188/255.f)  blue:(84/255.f)  alpha:1];
    title.text = self.userName;
    title.font = [UIFont boldSystemFontOfSize:20];
    title.backgroundColor = [UIColor clearColor];
    [title sizeToFit];
    self.navigationItem.titleView = title;
}

-(void)setupWebView
{
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;

    if ([self.webView respondsToSelector:@selector(scrollView)]) {
        self.webView.scrollView.bounces = NO;
    }
    
    if ([self.webView respondsToSelector:@selector(suppressesIncrementalRendering)]) {
        self.webView.suppressesIncrementalRendering = YES;
    }
    
    //Create a URL object.
    NSURL *url = [NSURL URLWithString:self.url];
    
    //URL Requst Object
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    //Load the request in the UIWebView.
    [self.webView loadRequest:requestObj];
}
@end
