//
//  PostFeedViewController.m
//  AppNetClient
//
//  Created by Tom Dolan on 3/18/13.
//  Copyright (c) 2013 TomDolan. All rights reserved.
//

#import "PostFeedViewController.h"
#import "NetworkController.h"
#import "PostFeedCell.h"
#import "UserData.h"
#import "CellBuilder.h"
#import "PostDetailViewController.h"

@interface PostFeedViewController ()
{
    UIImageView* _releaseToRefresh;
    UILabel* _refreshLabel;
    UIActivityIndicatorView* _refreshSpinner;
}

@property (strong, nonatomic) NSMutableArray* postFeedArray;
@property (strong, nonatomic) UIImageView* releaseToRefresh;
@property (strong, nonatomic) UILabel* refreshLabel;
@property (nonatomic, strong) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic) bool refreshing;

@end

@implementation PostFeedViewController
@synthesize releaseToRefresh = _releaseToRefresh;
@synthesize refreshLabel = _refreshLabel;
@synthesize refreshSpinner = _refreshSpinner;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self setupBackgrounds];
    [self setupNav];
    [self releaseToRefresh];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NetworkController sharedInstance] subscribeObserver:self];
    [[NetworkController sharedInstance] requestPostRefresh];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NetworkController sharedInstance] unsubscribeObserver:self];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 50 + [self getTextHeight:[(UserData*)self.postFeedArray[indexPath.row] postText]];
    
    if (height < 70)
    {
        height = 70;
    }
    
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.postFeedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PostFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
        cell = [[PostFeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    [CellBuilder loadCell:cell userData:self.postFeedArray[indexPath.row] storyHeight:[self getTextHeight:[(UserData*)self.postFeedArray[indexPath.row] postText]] cellHeight:[self tableView:tableView heightForRowAtIndexPath:indexPath]];
//    [self getTextHeight:[self.postFeedArray[indexPath.row] text]]
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     PostDetailViewController *detailViewController = [[PostDetailViewController alloc] initWithNibName:@"PostDetailViewController" bundle:[NSBundle mainBundle]];
    
     detailViewController.url = [(UserData*)self.postFeedArray[indexPath.row] appNetHomeUrl];
     detailViewController.userName = [(UserData*)self.postFeedArray[indexPath.row] name];
    
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     
}

#pragma mark - Newtwork Observer

- (void)operationCompleted:(NSArray*)input WithSig:(NetworkSig)sig;
{
    if (sig == kPostRefresh) {
        self.postFeedArray = [NSMutableArray arrayWithArray:input];
        [self resetRefreshOffset];
        [self.tableView reloadData];
    }
}
#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.refreshing != true)
    {
        if (self.tableView.contentOffset.y < -40) {
            self.refreshLabel.text = @"Release to Refresh";
        }
        else {
            self.refreshLabel.text = @"Pull to Refresh";
        }
    }
    
    if (self.tableView.contentOffset.y < -50) {
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x,-50);
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.tableView.contentOffset.y < -40)
    {
        self.refreshing = true;
        [self pullToRefresh];
    }
}
#pragma mark - Release to Refresh Stuff
-(UIImageView*)releaseToRefresh
{
    if(!_releaseToRefresh)
    {
        UIImageView* releaseView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -150, 320, 150)];
        releaseView.image = [UIImage imageNamed:@"ReleaseToRefresh.png"];
        [self setReleaseToRefresh:releaseView];
    }
    return _releaseToRefresh;
}
-(void)setReleaseToRefresh:(UIImageView *)input
{
    [_releaseToRefresh removeFromSuperview];
    [self.tableView addSubview:input];
    _releaseToRefresh = input;
}
-(UILabel*)refreshLabel
{
    if(!_refreshLabel)
    {
        UILabel* temp = [[UILabel alloc]initWithFrame:CGRectMake(60, 100, 200, 50 )];
        temp.textColor = [UIColor colorWithRed:(209/255.f) green:(188/255.f)  blue:(84/255.f)  alpha:1];
        temp.text = @"Release to Refresh";
        temp.backgroundColor = [UIColor clearColor];
        temp.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:18];
        temp.textAlignment = NSTextAlignmentCenter;
        [self setRefreshLabel:temp];
    }
    return _refreshLabel;
}
-(void)setRefreshLabel:(UILabel*)input
{
   
    [_refreshLabel removeFromSuperview];
    _refreshLabel = input;
    [self.releaseToRefresh addSubview:_refreshLabel];
    [self.releaseToRefresh bringSubviewToFront:_refreshLabel];
}
-(UIActivityIndicatorView*)refreshSpinner
{
    if(!_refreshSpinner)
    {
        UIActivityIndicatorView* tempSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        tempSpinner.frame = CGRectMake(80, 115, 20, 20);
        tempSpinner.hidesWhenStopped = YES;
        if ([tempSpinner respondsToSelector:@selector(setColor:)]) {
            tempSpinner.color = [UIColor colorWithRed:(209/255.f) green:(188/255.f)  blue:(84/255.f)  alpha:1];
        }
        
        [self setRefreshSpinner:tempSpinner];
    }
    return _refreshSpinner;
}
-(void)setRefreshSpinner:(UIActivityIndicatorView *)input
{
    [_refreshSpinner removeFromSuperview];
    [self.releaseToRefresh addSubview:input];
    _refreshSpinner = input;
}
-(void)pullToRefresh
{
    self.refreshLabel.text = @"Refreshing...";
    [self.refreshSpinner startAnimating];
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        [[NetworkController sharedInstance] requestPostRefresh];
    }];
}
-(void)resetRefreshOffset
{
    self.refreshing = false;
    self.refreshLabel.text = @"Pull to Refresh";
    [self.refreshSpinner stopAnimating];
    [self setRefreshSpinner:nil];
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
}
#pragma mark - Utilites

-(NSMutableArray*)postFeedArray
{
    //lazy load the array on demand
    if (!_postFeedArray) {
        [self setPostFeedArray:[[NSMutableArray alloc]initWithCapacity:0]];
    }
    return _postFeedArray;
}
-(CGFloat)getTextHeight:(NSString*)text
{
    CGSize labelsize = [text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(210, 2000.0) lineBreakMode:NSLineBreakByCharWrapping];
    return labelsize.height;
}

-(void)setupNav
{
    UILabel* title = [[UILabel alloc]initWithFrame:CGRectZero];
    title.textColor = [UIColor colorWithRed:(209/255.f) green:(188/255.f)  blue:(84/255.f)  alpha:1];
    title.text = @"Latest Posts";
    title.font = [UIFont boldSystemFontOfSize:20];
    title.backgroundColor = [UIColor clearColor];
    [title sizeToFit];
    self.navigationItem.titleView = title;
}

-(void)setupBackgrounds
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ReleaseToRefresh.png"]];
}

@end
