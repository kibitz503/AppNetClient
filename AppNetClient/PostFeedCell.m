//
//  PostFeedCell.m
//  AppNetClient
//
//  Created by Tom Dolan on 3/20/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import "PostFeedCell.h"

@interface PostFeedCell()

@property (retain, nonatomic) UIView* selectedView;
@property (retain, nonatomic) UIImageView* userPhoto;
@property (retain, nonatomic) UILabel* storyText;
@property (retain, nonatomic) UILabel* userName;
@property (retain, nonatomic) UIImageView* seperator;

@end

@implementation PostFeedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    // Configure the view for the selected state
    if (selected) {
        [self cellWasTapped];
    }
}

-(void)changeUserPhoto:(UIImageView *)input
{
    [self.userPhoto removeFromSuperview];
    [self.contentView addSubview:input];
    [self setUserPhoto:input];
}

-(void)changeSeperator:(UIImageView *)input
{
    [self.seperator removeFromSuperview];
    [self.contentView addSubview:input];
    [self setSeperator:input];
}

-(void)changeStoryText:(UILabel *)input
{
    [self.storyText removeFromSuperview];
    [self.contentView addSubview:input];
    [self setStoryText:input];
}
-(void)changeUserName:(UILabel *)input
{
    [self.userName removeFromSuperview];
    [self.contentView addSubview:input];
    [self setUserName:input];
}

-(void)loadSelectedView
{
    if (!self.selectedView) {
        UIView* temp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 3)];
        temp.backgroundColor = [UIColor blackColor];
        temp.alpha = .5;
        temp.userInteractionEnabled = YES;
        [self changeSelectedView:temp];
    }
}
-(void)changeSelectedView:(UIView *)input
{
    [self.selectedView removeFromSuperview];
    [self addSubview:input];
    [self bringSubviewToFront:input];
    [self setSelectedView:input];
}
-(void)cellWasTapped
{
    [self loadSelectedView];
    [self performSelector:@selector(untapCell) withObject:nil afterDelay:.25];
}
-(void)untapCell
{
    [self changeSelectedView:nil];
}

-(void)clearCell
{
    [self changeUserPhoto:nil];
    [self changeStoryText:nil];
    [self changeSeperator:nil];
    [self changeSelectedView:nil];
    [self changeUserName:nil];
}
@end
