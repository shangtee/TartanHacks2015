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
    if (![(NSMutableDictionary *)([PFUser currentUser][@"dealNumDict"]) objectForKey:self.curDeal.objectId]) {
        self.confirmButton.hidden = YES;
        self.countLabel.hidden = YES;
    } else {
        self.confirmButton.hidden = NO;
        NSNumber *countNum = [(NSMutableDictionary *)([PFUser currentUser][@"dealNumDict"]) objectForKey:self.curDeal.objectId];
        self.countLabel.text = countNum.description;

    }
    
}
- (IBAction)confirmTouched:(UIButton *)sender {
    [[DataCenter sharedCenter] removeDeal:self.curDeal];
    sender.hidden = YES;
    self.countLabel.hidden = YES;
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
