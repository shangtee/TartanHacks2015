//
//  Deal.h
//  TartanHacks
//
//  Created by Zhichun Li on 2/6/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Deal : PFObject<PFSubclassing>
+ (NSString *) parseClassName;
@property (retain) PFGeoPoint* dealLocation;
@property (retain) NSNumber *numberOfItems;
@property (retain) NSNumber *numberOfItemsLeft;
@property (retain) NSNumber *totalPrice;
@property (retain) NSDate *dealExpirationTime;
@property (retain) NSDate *meetupExpirationTime;
@property (retain) PFRelation *confirmedUsers;
@property (retain) PFRelation *participants;
@property (retain) PFUser *initiator;
@property (retain) NSString *storeName;
@property (retain) NSString *itemName;
@property (retain) NSString *description;
@end
