//
//  NetworkController.m
//  AppNetClient
//
//  Created by Tom Dolan on 3/18/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import "NetworkController.h"
#import "AppNetNetworkRequest.h"
#import "NetworkParser.h"


static NetworkController* singleton = nil;

@interface NetworkController() 

-(id)init;
@property (strong, nonatomic) NSMutableSet* observerSet;

@end

@implementation NetworkController

#pragma mark - Life Cycle
+(NetworkController*)sharedInstance;
{
    @synchronized(self)
    {
        if (!singleton)
        {
            singleton = [[NetworkController alloc] init];
        }
        return singleton;
    }
}

-(id)init
{
    if (self = [super init])
    {
        //Setup internal stuff
    }
    return self;
}

#pragma mark - Network Calls

-(void)requestPostRefresh
{
    __block AppNetNetworkRequest* request = [[AppNetNetworkRequest alloc]init];
    
    [request setCallback:^(NSMutableData* postData, NetworkSig sig){
        [self postDataParser:postData WithSig:sig];
    }];
    
    [request createRequest:@"https://alpha-api.app.net/stream/0/posts/stream/global" withPayload:nil withMethod:@"GET"];
}

#pragma mark - Parser Call
-(void)postDataParser:(NSMutableData*)data WithSig:(NetworkSig)sig
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    __block NSArray* userArray = nil;
    dispatch_async(queue, ^{
        userArray = [[[NetworkParser alloc] init] parseNetworkData:data WithSig:sig];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self operationCompleted:userArray WithSig:sig];
        });
    });
}
#pragma mark - Observer Functions

-(void)operationCompleted:(NSArray*)input WithSig:(NetworkSig)sig
{
    for( id<NetworkObserver> observer in [NSSet setWithSet:self.observerSet] )
    {
        [observer operationCompleted:input WithSig:sig];
    }
}

-(void)subscribeObserver:(id<NetworkObserver>)input
{
    @synchronized(self.observerSet)
    {
        [self.observerSet addObject:input];
    }
}

-(void)unsubscribeObserver:(id<NetworkObserver>)input
{
    @synchronized(self.observerSet)
    {
        [self.observerSet removeObject:input];
    }
}

-(NSMutableSet*)observerSet
{
    //lay load the set
    if (!_observerSet) {
        [self setObserverSet:[[NSMutableSet alloc]initWithCapacity:0]];
    }
    return _observerSet;
}
@end
