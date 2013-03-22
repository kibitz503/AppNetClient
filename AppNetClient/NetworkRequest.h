//
//  NetworkRequest.h
//  AppNetClient
//
//  Created by Tom Dolan on 3/18/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequest : NSObject <NSURLConnectionDelegate>

-(void)createRequest:(NSString*)theURL withPayload:(NSString*)payload withMethod:(NSString*)method;
-(void)connectionDidFinishLoading:(NSURLConnection *)connection;

@property (strong, nonatomic) NSMutableData* networkData;

@end
