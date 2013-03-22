//
//  NetworkController.h
//  AppNetClient
//
//  Created by Tom Dolan on 3/18/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkObserver.h"



@interface NetworkController : NSObject

+(NetworkController*)sharedInstance;
-(void)requestPostRefresh;
-(void)subscribeObserver:(id<NetworkObserver>)input;
-(void)unsubscribeObserver:(id<NetworkObserver>)input;

@end
