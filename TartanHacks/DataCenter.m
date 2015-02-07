
//
//  DataCenter.m
//  TartanHacks
//
//  Created by Zhichun Li on 2/6/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "DataCenter.h"
#import "Deal.h"
#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>
@interface DataCenter () <CLLocationManagerDelegate>
//@property (strong, nonatomic) CLLocationManager *locationManager;
@end
@implementation DataCenter

+ (instancetype)sharedCenter {
    static DataCenter *sharedCenter = nil;
    
    if (sharedCenter == nil) {
        sharedCenter = [[DataCenter alloc] init];
        sharedCenter.locationManager = [[CLLocationManager alloc] init];
        sharedCenter.locationManager.delegate = sharedCenter;
    }
    
    return sharedCenter;
}

// fetches the deals excluding the deals that the current user is part of
-(void) fetchDealsForUser: (id<SAVMainDealDelegate>) delegate
                   radius: (double)rad
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        PFQuery *query = [Deal query];
        // used to find location
        [self.locationManager startUpdatingLocation];
        CLLocation *location = self.locationManager.location;
        if (rad == 0.0) {
            [query whereKey:@"dealLocation" nearGeoPoint:[PFGeoPoint geoPointWithLocation:location] withinKilometers:[(NSNumber *)([PFUser currentUser][@"searchRadius"]) intValue]];
        } else {
            [query whereKey:@"dealLocation" nearGeoPoint:[PFGeoPoint geoPointWithLocation:location] withinKilometers:rad];
        }
        [query whereKey:@"participants" notEqualTo:[PFUser currentUser]];
        [query orderByDescending:@"dealExpirationTime"];
        NSMutableArray *dealList = [[query findObjects] mutableCopy];
        [self.locationManager stopUpdatingLocation];
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate dealDataFetched:dealList];
        });
    });
        
}

-(void)fetchDealsOfUser: (id<SAVHistoryDelegate>) delegate {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        PFQuery *query = [Deal query];
        // used to find location
        [query whereKey:@"participants" equalTo:[PFUser currentUser]];
        [query orderByDescending:@"dealExpirationTime"];
        NSMutableArray *dealList = [[query findObjects] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate dealDataFetched:dealList];
        });
    });

}

-(void)addDealParticipant:(Deal *)deal numItems: (NSInteger)num
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        PFUser *user = [PFUser currentUser];
        PFRelation *dealsRelation = [user relationForKey:@"dealsAsso"];
        [dealsRelation addObject:deal];
        NSMutableDictionary *curDict = user[@"dealNumDict"];
        if (curDict == nil){
            curDict = [[NSMutableDictionary alloc] init];
        }
        [curDict setObject:[NSNumber numberWithInteger:num] forKey:deal.objectId];
        user[@"dealNumDict"] = curDict;
        [user save];
        PFRelation *participantsRelation = [deal relationForKey:@"participants"];
        [participantsRelation addObject:user];
        NSNumber *num1 = deal[@"numberOfItemsLeft"];
        NSInteger left = [num1 integerValue] - num;
        deal[@"numberOfItemsLeft"] = [NSNumber numberWithInteger:left];
        [deal save];
        
        PFUser *initiator = deal.initiator;
        PFQuery *pushQuery = [PFInstallation query];
        [pushQuery whereKey:@"user" equalTo:initiator];
        PFPush *push = [[PFPush alloc] init];
        [push setQuery:pushQuery];
        [push setMessage:@"A new person joined your deal!"];
        [push sendPush:nil];
    });
    
}

-(void)updateRadius:(int)radius
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        PFUser *currentUser = [PFUser currentUser];
        currentUser[@"searchRadius"] = [NSNumber numberWithInt:radius];
        [currentUser save];
    });
}

-(void)removeDeal:(Deal *)deal
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        PFUser *currentUser = [PFUser currentUser];
        PFRelation *confirmedUs = deal[@"confirmedUsers"];
        [confirmedUs addObject:currentUser];
        [deal save];
    });
}
@end
