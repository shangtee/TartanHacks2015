//
//  SAVFeedDetailView.m
//  TartanHacks
//
//  Created by Zhichun Li on 2/7/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "SAVFeedDetailView.h"
#import "DataCenter.h"

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
    [super viewDidLoad];
    self.storeName.text = self.curDeal.storeName;
    self.itemName.text = self.curDeal.itemName;
    [self.curDeal.imageData getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            self.imageView.image = [UIImage imageWithData:data];
            // image can now be set on a UIImageView
        }
    }];
    self.descript.text = self.curDeal.descript;
}
- (IBAction)participate:(id)sender {
    [[DataCenter sharedCenter] addDealParticipant:self.curDeal numItems:[self.numItem.text intValue]];
}

@end
