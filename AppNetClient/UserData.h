//
//  UserData.h
//  AppNetClient
//
//  Created by Tom Dolan on 3/19/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject


@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* imageUrl;
@property (nonatomic, strong) NSString* appNetHomeUrl; //canonical_url
@property (nonatomic, strong) NSString* postText;
@property (nonatomic, strong) NSNumber* userID;

@end
