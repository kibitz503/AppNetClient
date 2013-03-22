//
//  NetworkParser.m
//  AppNetClient
//
//  Created by Tom Dolan on 3/19/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import "NetworkParser.h"
#import "UserData.h"

@implementation NetworkParser

-(NSArray*)parseNetworkData:(NSMutableData*)data WithSig:(NetworkSig)sig
{
    NSArray* toReturn = nil;
    if (sig == kPostRefresh)
    {
        toReturn = [self parsePostRefresh:data];
    }
    return toReturn;
}
-(NSArray*)parsePostRefresh:(NSMutableData*)data
{
    NSMutableArray* userArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSError* error;
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray* topLevelArray = [jsonDict valueForKey:@"data"];
    for (NSDictionary* dict in topLevelArray) {
        UserData* userData = [[UserData alloc]init];
        userData.postText = [dict valueForKey:@"text"];
        userData.name = [[dict valueForKey:@"user"] valueForKey:@"name"];
        userData.userID = [[dict valueForKey:@"user"] valueForKey:@"id"];
        userData.imageUrl = [[[dict valueForKey:@"user"] valueForKey:@"avatar_image"] valueForKey:@"url"];
        userData.appNetHomeUrl = [[dict valueForKey:@"user"] valueForKey:@"canonical_url"];
        [userArray addObject:userData];
    }
    return userArray;
}

@end


