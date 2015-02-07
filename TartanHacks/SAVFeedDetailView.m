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
@property int itemsSoFar;
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
    
    self.storeName.text = self.curDeal.storeName.uppercaseString;
    self.itemName.text = self.curDeal.itemName;
    PFFile *imageFile = self.curDeal.image;
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            self.imageView.image = [UIImage imageWithData:data];
            // image can now be set on a UIImageView
        }
    }];
    self.descript.text = self.curDeal.descript;
    self.toClaimNumItems.text = @"0";
    self.itemsSoFar = 0;
    [self.toClaimStepper addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventValueChanged];
    self.toClaimStepper.value = 0.0;
    self.toClaimStepper.maximumValue = [self.curDeal.numberOfItemsLeft doubleValue];
    self.totalPrice.text = @"$0.0";
}

- (void)addItem:(id)sender
{
    if ((self.toClaimStepper.value - self.itemsSoFar) > 0) {
        self.itemsSoFar+= 1;
    } else {
        self.itemsSoFar = MAX(0, self.itemsSoFar - 1);
    }
    
    self.toClaimNumItems.text = [NSString stringWithFormat:@"%d", self.itemsSoFar];
    self.totalPrice.text = [NSString stringWithFormat:@"$%.2d", (self.itemsSoFar * [self.curDeal.totalPrice intValue])];
}

- (IBAction)participate:(id)sender {
    [[DataCenter sharedCenter] addDealParticipant:self.curDeal numItems:[self.toClaimNumItems.text intValue]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
