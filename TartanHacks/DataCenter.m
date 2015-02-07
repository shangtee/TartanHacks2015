
//
//  DataCenter.m
//  TartanHacks
//
//  Created by Zhichun Li on 2/6/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "DataCenter.h"

@implementation DataCenter

+ (instancetype)sharedCenter {
    static DataCenter *sharedCenter = nil;
    
    if (sharedCenter == nil) {
        sharedCenter = [[DataCenter alloc] init];
    }
    
    return sharedCenter;
}

@end
