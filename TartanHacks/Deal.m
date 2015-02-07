//
//  Deal.m
//  TartanHacks
//
//  Created by Zhichun Li on 2/6/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "Deal.h"
#import <Parse/PFObject+Subclass.h>

@implementation Deal
+ (void) load{
    [self registerSubclass];
}

+ (NSString *) parseClassName{
    return @"Deal";
}

@dynamic dealLocation;
@dynamic numberOfItems;
@dynamic numberOfItemsLeft;
@dynamic totalPrice;
@dynamic dealExpirationTime;
@dynamic meetupExpirationTime;
@dynamic confirmedUsers;
@dynamic participants;
@dynamic initiator;
@dynamic storeName;
@dynamic itemName;
@dynamic description;



@end
