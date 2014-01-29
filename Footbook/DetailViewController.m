//
//  DetailViewController.m
//  Footbook
//
//  Created by Matthew Voracek on 1/29/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "DetailViewController.h"
#import "Friend.h"

@interface DetailViewController ()
{
    Friend* friend;
    __weak IBOutlet UILabel *feetLabel;
    __weak IBOutlet UILabel *ratioLabel;
    
}
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(Friend*)newFriend
{
    friend = newFriend;
    self.title = friend.name;
}

- (void)configureView
{
    feetLabel.text = friend.feet.description;
    ratioLabel.text = [NSString stringWithFormat:@"%.1f : %i (%.2f)(Lower is better!)",friend.shoeSize.floatValue, friend.prowess.intValue, (friend.shoeSize.floatValue / friend.prowess.intValue)];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self configureView];
}


@end
