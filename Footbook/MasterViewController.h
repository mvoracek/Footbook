//
//  MasterViewController.h
//  Footbook
//
//  Created by Matthew Voracek on 1/29/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
