//
//  NetworkObserver.h
//  AppNetClient
//
//  Created by Tom Dolan on 3/18/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kPostRefresh
}NetworkSig;

@protocol NetworkObserver

- (void)operationCompleted:(NSArray*)input WithSig:(NetworkSig)sig;

@end
