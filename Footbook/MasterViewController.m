//
//  MasterViewController.m
//  Footbook
//
//  Created by Matthew Voracek on 1/29/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import "MasterViewController.h"
#import "AddFriendsViewController.h"
#import "DetailViewController.h"
#import "Friend.h"

@interface MasterViewController () <UITableViewDelegate, UITableViewDataSource>
{
    
}

@end

@implementation MasterViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Friend"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"cache"];
    [self.fetchedResultsController performFetch:nil];
    self.fetchedResultsController.delegate = self;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Friend *friend = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.managedObjectContext deleteObject:friend];
        [self.managedObjectContext save:nil];
    }
}


-(IBAction)unwindFromAddingFriends:(UIStoryboardSegue *)segue
{
    AddFriendsViewController *vc = segue.sourceViewController;
    
    for (NSIndexPath* indexPath in vc.addFriendsTableView.indexPathsForSelectedRows)
    {
        [self addFriendWithName:vc.potentialFriendsArray[indexPath.row] feet:arc4random()%11+1 prowess:arc4random()%100+1 shoeSize:arc4random()%22/2.0f+5];
    }
    
}

-(void)addFriendWithName:(NSString*)name
                    feet:(int)feet
                 prowess:(int)prowess
                shoeSize:(float)shoeSize
{
    Friend* friend = [NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:self.managedObjectContext];
    friend.name = name;
    friend.feet = @(feet);
    friend.prowess = @(prowess);
    friend.shoeSize = @(shoeSize);
    
    [self.managedObjectContext save:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:object];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    Friend* friend = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = friend.name;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedResultsController.sections[section] numberOfObjects];
}

@end