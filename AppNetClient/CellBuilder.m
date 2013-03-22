//
//  CellBuilder.m
//  AppNetClient
//
//  Created by Tom Dolan on 3/20/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import "CellBuilder.h"
#import "PostFeedCell.h"
#import "UserData.h"
#import "UIImageView+Async.h"
#import <QuartzCore/QuartzCore.h>

@implementation CellBuilder

+(void)loadCell:(PostFeedCell*)cell userData:(UserData*)data storyHeight:(CGFloat)storyHeight cellHeight:(CGFloat)cellHeight
{
    [cell clearCell];
    [CellBuilder setupBackGround:cell Height:cellHeight];
    [cell changeUserName:[CellBuilder setupName:data.name]];
    [cell changeUserPhoto:[CellBuilder setupImage:data.imageUrl]];
    [cell changeSeperator:[CellBuilder setupSeperator:cell Height:cellHeight]];
    [cell changeStoryText:[CellBuilder setupText:data.postText Height:storyHeight]];
}


+(void)setupBackGround:(PostFeedCell*)cell Height:(CGFloat)cellHeight
{
    UIView* newBackgroundView = [[UIView alloc]initWithFrame:CGRectZero];
    newBackgroundView.alpha = 0;
    [cell setSelectedBackgroundView:newBackgroundView];
    
    UIImageView* background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cellHeight)];
    background.image = [UIImage imageNamed:@"CellBackground.png"];
    [cell setBackgroundView:background];
}

+(UILabel*)setupText:(NSString*)text Height:(CGFloat)height
{
    UILabel* textLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 35, 210, height)];
    textLabel.text = text;
    textLabel.numberOfLines = 0;
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = [UIColor colorWithRed:(79/255.f) green:(49/255.f) blue:(35/255.f) alpha:1];
    textLabel.font = [UIFont systemFontOfSize:12];
    return textLabel;
}

+(UIImageView*)setupSeperator:(PostFeedCell*)cell Height:(CGFloat)cellHeight
{
    UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(0, cellHeight - 2, cell.frame.size.width, 2)];
    line.image = [UIImage imageNamed:@"CellSpacer.png"];
    return line;
}

+(UILabel*)setupName:(NSString*)name
{
    UILabel* nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, 180, 30)];
    nameLabel.text = name;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor colorWithRed:(102/255.f) green:(99/255.f) blue:(37/255.f) alpha:1];
    nameLabel.font = [UIFont boldSystemFontOfSize:18];
    return nameLabel;
}

+(UIImageView*)setupImage:(NSString*)url
{
    UIImageView* photo = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 50, 50)];
    [CellBuilder setRoundedView:photo toDiameter:50];
    [photo setImageWithURL:url placeholder:[UIImage imageNamed:@"placeholder.png"]];
    return photo;
}


+(void)setRoundedView:(UIImageView *)roundedView toDiameter:(float)newSize;
{
    roundedView.layer.masksToBounds = YES;
    CGPoint saveCenter = roundedView.center;
    CGRect newFrame = CGRectMake(roundedView.frame.origin.x, roundedView.frame.origin.y, newSize, newSize);
    roundedView.frame = newFrame;
    roundedView.layer.cornerRadius = 10;
    roundedView.center = saveCenter;
    [roundedView.layer setBorderColor:[UIColor colorWithRed:(79/255.f) green:(49/255.f) blue:(35/255.f) alpha:1].CGColor];
    [roundedView.layer setBorderWidth:2];
}
//@property (nonatomic, strong) NSString* name;
//@property (nonatomic, strong) NSString* imageUrl;
//@property (nonatomic, strong) NSString* appNetHomeUrl; //canonical_url
//@property (nonatomic, strong) NSString* postText;
//@property (nonatomic, strong) NSNumber* userID;
@end
