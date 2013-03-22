//
//  UIImageView+Async.h
//  AppNetClient
//
//  Created by Tom Dolan on 3/20/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Async)

-(void)setImageWithURL:(NSString*)url;
-(void)setImageWithURL:(NSString*)url placeholder:(UIImage*)placeholder;

@end
