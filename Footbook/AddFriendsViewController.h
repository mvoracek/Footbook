//
//  AddFriendsViewController.h
//  Footbook
//
//  Created by Matthew Voracek on 1/29/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendsViewController : UIViewController
@property IBOutlet UITableView *addFriendsTableView;
@property NSArray *potentialFriendsArray;
@property NSArray *selectedFriendsArray;
@end
