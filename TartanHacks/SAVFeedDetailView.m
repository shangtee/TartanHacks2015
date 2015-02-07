//
//  SAVFeedDetailView.m
//  TartanHacks
//
//  Created by Zhichun Li on 2/7/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "SAVFeedDetailView.h"

@interface SAVFeedDetailView ()
@property (strong, nonatomic) Deal *curDeal;
@end

@implementation SAVFeedDetailView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id) initWithDeal: (Deal *) curDeal{
    self = [super init];
    if (self) {
        self.curDeal = curDeal;
    }
    return self;
}

-(void)viewDidLoad{
    
}
@end
