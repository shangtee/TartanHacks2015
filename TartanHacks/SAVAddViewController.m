//
//  SAVAddViewController.m
//  TartanHacks
//
//  Created by Ruoxi Tan on 2/6/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "SAVAddViewController.h"

#import <Parse/Parse.h>

@interface SAVAddViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *itemName;
@property (nonatomic, strong) NSString *finalItemName;
@property (weak, nonatomic) IBOutlet UIPickerView *saleType;
@end

@implementation SAVAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (IBAction)textFieldDidEndOnExit:(id)sender
{
    self.finalItemName = ((UITextField *)sender).text;
    PFObject *newDeal = [PFObject objectWithClassName:@"Deal"];
    newDeal[@"itemName"] = self.finalItemName;
    PFRelation *newRelation = [[PFUser currentUser] relationForKey:@"confirmedUsers"];
    [newRelation addObject:[PFUser currentUser]];
    newDeal[@"initiator"] = [PFUser currentUser];
    [newDeal saveInBackground];
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
