//
//  PostFeedCell.h
//  AppNetClient
//
//  Created by Tom Dolan on 3/20/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostFeedCell : UITableViewCell

-(void)changeUserPhoto:(UIImageView *)input;
-(void)changeSeperator:(UIImageView *)input;
-(void)changeStoryText:(UILabel *)input;
-(void)changeUserName:(UILabel *)input;
-(void)clearCell;

@end


