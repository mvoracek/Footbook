//
//  AddFriendsViewController.m
//  Footbook
//
//  Created by Matthew Voracek on 1/29/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "AddFriendsViewController.h"

@interface AddFriendsViewController () <UITableViewDataSource, UITableViewDelegate>
{
    
    
}
@end

@implementation AddFriendsViewController
@synthesize addFriendsTableView, selectedFriendsArray, potentialFriendsArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadFromJSON];
}

-(void)loadFromJSON
{
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/3/friends.json"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        potentialFriendsArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        [addFriendsTableView reloadData];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FootbookID"];
    cell.textLabel.text = potentialFriendsArray[indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return potentialFriendsArray.count;
}
@end
