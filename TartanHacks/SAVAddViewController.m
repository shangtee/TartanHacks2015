//
//  SAVAddViewController.m
//  TartanHacks
//
//  Created by Ruoxi Tan on 2/6/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "SAVAddViewController.h"
#import "DataCenter.h"

#import <Parse/Parse.h>
#import <CoreLocation/CoreLocation.h>

@interface SAVAddViewController ()
@property (nonatomic, strong) PFObject *deal;
@property (weak, nonatomic) IBOutlet UIPickerView *itemName;
@property (nonatomic, strong) NSString *finalItemName;
@property (weak, nonatomic) IBOutlet UIPickerView *saleType;
@end

@implementation SAVAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped:)];
    self.deal = [PFObject objectWithClassName:@"Deal"];
    
    DataCenter *sharedCenter = [DataCenter sharedCenter];
    [sharedCenter.locationManager startUpdatingLocation];
    CLLocation *location = sharedCenter.locationManager.location;
    
    PFGeoPoint *currentLoc = [PFGeoPoint geoPointWithLocation:location];
    self.deal[@"dealLocation"] = currentLoc;
}

- (IBAction)textFieldDidEndOnExit:(id)sender
{
    self.finalItemName = ((UITextField *)sender).text;
    self.deal[@"itemName"] = self.finalItemName;
}

- (void)saveButtonTapped:(id)sender
{
//    self.deal[@"itemName"] = ((UITextField *)self.itemName).text;
    PFRelation *newRelation = [self.deal relationForKey:@"participants"];
    [newRelation addObject:[PFUser currentUser]];
    self.deal[@"initiator"] = [PFUser currentUser];
    [self.deal saveInBackground];
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
