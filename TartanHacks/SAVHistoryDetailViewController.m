//
//  SAVHistoryDetailViewController.m
//  TartanHacks
//
//  Created by Ruoxi Tan on 2/7/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "SAVHistoryDetailViewController.h"
#import "DataCenter.h"

@interface SAVHistoryDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UILabel *selfItemsClaimed;
@property (weak, nonatomic) IBOutlet UILabel *totalItemsClaimed;
@property (weak, nonatomic) IBOutlet UILabel *numSelfItemsClaimed;
@property (weak, nonatomic) IBOutlet UILabel *numTotalItemsClaimed;
@property (strong, nonatomic) Deal *curDeal;
@end

@implementation SAVHistoryDetailViewController
- (id) initWithDeal:(Deal *)deal {
    if (self) {
        self.curDeal = deal;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.storeLabel.text = self.curDeal.storeName;
    self.itemLabel.text = self.curDeal.itemName;
    self.descriptionLabel.text = self.curDeal.descript;
    PFFile *imageFile = self.curDeal.image;
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            self.imageView.image = [UIImage imageWithData:data];
            // image can now be set on a UIImageView
        }
    }];
    PFRelation *confirmedRelation = self.curDeal.confirmedUsers;
    PFQuery *relationQuery = [confirmedRelation query];
    [relationQuery whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
    [relationQuery countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (number > 0 || [PFUser currentUser].objectId == self.curDeal.initiator.objectId) {
            self.confirmButton.hidden = YES;
        } else {
            self.confirmButton.hidden = NO;
        }
        NSNumber *countNum = [(NSMutableDictionary *)([PFUser currentUser][@"dealNumDict"]) objectForKey:self.curDeal.objectId];
        self.numTotalItemsClaimed.text = [NSString stringWithFormat:@"%d/%d", ([self.curDeal.numberOfItems intValue] - [self.curDeal.numberOfItemsLeft intValue]), [self.curDeal.numberOfItems intValue]];
        self.totalItemsClaimed.text = @"Total Claimed";
        self.numSelfItemsClaimed.text = [NSString stringWithFormat:@"%d/%d", [countNum intValue], [self.curDeal.numberOfItems intValue]];
        self.selfItemsClaimed.text = @"You Claimed";
    }];
}
- (IBAction)confirmTouched:(UIButton *)sender {
    [[DataCenter sharedCenter] removeDeal:self.curDeal];
    sender.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
