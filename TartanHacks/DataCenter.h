//
//  DataCenter.h
//  TartanHacks
//
//  Created by Zhichun Li on 2/6/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SAVMainDealDelegate;
@protocol SAVHistoryDelegate;

@interface DataCenter : NSObject
+(instancetype)sharedCenter;
-(void) fetchDealsForUser: (id<SAVMainDealDelegate>) delegate;
-(void) fetchDealsOfUser: (id<SAVHistoryDelegate>) delegate;
@end

@protocol SAVMainDealDelegate <NSObject>
-(void)dealDataFetched: (NSMutableArray *)data;
@end
@protocol SAVHistoryDelegate <NSObject>
-(void)dealDataFetched: (NSMutableArray *)data;
@end

