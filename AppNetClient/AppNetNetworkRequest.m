//
//  AppNetNetworkRequest.m
//  AppNetClient
//
//  Created by Tom Dolan on 3/18/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import "AppNetNetworkRequest.h"

@implementation AppNetNetworkRequest

-(void)createRequest:(NSString*)theURL withPayload:(NSString*)payload withMethod:(NSString*)method
{
    [super createRequest:theURL withPayload:payload withMethod:method];
    NSURL* url = [NSURL URLWithString:theURL];
    NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [urlRequest setHTTPMethod:method];
    
    //if there is a payload to send
    if(payload)
    {
        [urlRequest setHTTPBody:[payload dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [super connectionDidFinishLoading:connection];
    self.callback([super.networkData copy], self.sig );
}



@end
