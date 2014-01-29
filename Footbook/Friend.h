//
//  Friend.h
//  Footbook
//
//  Created by Matthew Voracek on 1/29/14.
//  Copyright (c) 2014 Matthew Voracek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Friend : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * feet;
@property (nonatomic, retain) NSNumber * prowess;
@property (nonatomic, retain) NSNumber * shoeSize;

@end
