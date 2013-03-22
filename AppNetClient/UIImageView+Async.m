//
//  UIImageView+Async.m
//  AppNetClient
//
//  Created by Tom Dolan on 3/20/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import "ScaleAndCrop.h"
#import "UIImageView+Async.h"


static NSCache* sharedImageCache = nil;

@implementation UIImageView (Async)




-(void)setImageWithURL:(NSString*)url placeholder:(UIImage*)placeholder;
{
    if (placeholder)
    {
        [self setImage:[ScaleAndCrop image:placeholder ByScalingAndCroppingForSize:CGSizeMake(self.frame.size.width, self.frame.size.height)]] ;
    }
   
    [self setImageWithURL:url];
}

-(void)setImageWithURL:(NSString*)url
{
    
    UIImage* image = [[UIImageView imageCache]  objectForKey:url];
    if (image)
    {
        [self setImage:[ScaleAndCrop image:image ByScalingAndCroppingForSize:CGSizeMake(self.frame.size.width, self.frame.size.height)]];
    }
    else
    {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
        
        dispatch_async(queue, ^{
            NSURL *URL = [NSURL URLWithString:url];
            UIImage* processedImage = [ScaleAndCrop image:[UIImage imageWithData:[NSData dataWithContentsOfURL:URL]] ByScalingAndCroppingForSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (processedImage) {
                    [self setImage:processedImage];
                    [[UIImageView imageCache] setObject:processedImage forKey:url];
                }
            });
        });
    }
}

+(NSCache*)imageCache
{
    if(!sharedImageCache)
    {
        sharedImageCache = [[NSCache alloc]init];
    }
    return sharedImageCache;
}

@end
