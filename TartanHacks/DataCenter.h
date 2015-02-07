//
//  DataCenter.h
//  TartanHacks
//
//  Created by Zhichun Li on 2/6/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Deal.h"

@protocol SAVMainDealDelegate;
@protocol SAVHistoryDelegate;

@interface DataCenter : NSObject
@property (nonatomic, strong) CLLocationManager *locationManager;

+(instancetype)sharedCenter;
-(void) fetchDealsForUser: (id<SAVMainDealDelegate>) delegate radius:(double)rad;
-(void) fetchDealsOfUser: (id<SAVHistoryDelegate>) delegate;
-(void) addDealParticipant: (Deal *)deal numItems: (NSInteger)num;
-(void) updateRadius: (int)radius;
-(void) removeDeal: (Deal *)deal;
@end

@protocol SAVMainDealDelegate <NSObject>
-(void)dealDataFetched: (NSMutableArray *)data;
@end
@protocol SAVHistoryDelegate <NSObject>
-(void)dealDataFetched: (NSMutableArray *)data;
@end

