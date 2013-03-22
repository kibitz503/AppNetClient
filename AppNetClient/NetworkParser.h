//
//  NetworkParser.h
//  AppNetClient
//
//  Created by Tom Dolan on 3/19/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkObserver.h"
@interface NetworkParser : NSObject

-(NSArray*)parseNetworkData:(NSMutableData*)data WithSig:(NetworkSig)sig;
-(NSArray*)parsePostRefresh:(NSMutableData*)data;
@end
