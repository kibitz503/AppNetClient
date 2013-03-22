//
//  PostDetailViewController.h
//  AppNetClient
//
//  Created by Tom Dolan on 3/21/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostDetailViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSString* url;
@property (strong, nonatomic) NSString* userName;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
