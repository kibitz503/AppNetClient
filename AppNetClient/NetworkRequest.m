//
//  NetworkRequest.m
//  AppNetClient
//
//  Created by Tom Dolan on 3/18/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import "NetworkRequest.h"
@interface NetworkRequest()


@end

@implementation NetworkRequest

-(id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

-(void)createRequest:(NSString*)theURL withPayload:(NSString*)payload withMethod:(NSString*)method
{
    self.networkData = [[NSMutableData alloc]initWithCapacity:0];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    [self.networkData appendData:data];
}

-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self showNetworkError:error];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)showNetworkError:(NSError*)error
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Network Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
@end
