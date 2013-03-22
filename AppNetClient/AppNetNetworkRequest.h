//
//  AppNetNetworkRequest.h
//  AppNetClient
//
//  Created by Tom Dolan on 3/18/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import "NetworkRequest.h"
#import "NetworkObserver.h"

typedef void (^CallbackBlock) (NSMutableData*, NetworkSig);

@interface AppNetNetworkRequest : NetworkRequest

@property (strong, nonatomic) CallbackBlock callback;
@property (nonatomic) NetworkSig sig;

@end
