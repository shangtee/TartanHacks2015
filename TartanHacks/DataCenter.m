
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
-(void) fetchDealsForUser: (id<SAVMainDealDelegate>) delegate{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        PFQuery *query = [Deal query];
        // used to find location
        [self.locationManager startUpdatingLocation];
        CLLocation *location = self.locationManager.location;
        [query whereKey:@"dealLocation" nearGeoPoint:[PFGeoPoint geoPointWithLocation:location] withinKilometers:10];
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

-(void)addDealParticipant:(Deal *)deal
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        PFUser *user = [PFUser currentUser];
        PFRelation *dealsRelation = [user relationForKey:@"dealsAsso"];
        [dealsRelation addObject:user];
        [user save];
        PFRelation *participantsRelation = [deal relationForKey:@"participants"];
        [participantsRelation addObject:deal];
        [deal save];
    });
    
}

@end
