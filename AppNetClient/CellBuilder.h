//
//  CellBuilder.h
//  AppNetClient
//
//  Created by Tom Dolan on 3/20/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PostFeedCell;
@class UserData;

@interface CellBuilder : NSObject

+(void)loadCell:(PostFeedCell*)cell userData:(UserData*)data storyHeight:(CGFloat)storyHeight cellHeight:(CGFloat)cellHeight;

@end
