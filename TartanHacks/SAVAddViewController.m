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
#import <GoogleMaps/GoogleMaps.h>

@interface SAVAddViewController () <GMSMapViewDelegate>
@property (nonatomic, strong) PFObject *deal;
@property (weak, nonatomic) IBOutlet UITextField *itemName;
@property (nonatomic, strong) NSString *finalItemName;
@property (weak, nonatomic) IBOutlet UIPickerView *saleType;
@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) GMSMarker *marker;
@end

@implementation SAVAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped:)];
    self.deal = [PFObject objectWithClassName:@"Deal"];
    
    DataCenter *dataCenter = [DataCenter sharedCenter];
    CLLocation *location = dataCenter.locationManager.location;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                            longitude:location.coordinate.longitude
                                                                 zoom:6];
    self.mapView = [GMSMapView mapWithFrame:CGRectMake(0, self.view.frame.size.height - 410, self.view.frame.size.width, 300) camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.mapView.delegate = self;
    
    // Creates a marker in the center of the map.
    self.marker = [[GMSMarker alloc] init];
    self.marker.position = self.mapView.myLocation.coordinate;
    self.marker.map = self.mapView;
    
    [self.view addSubview:self.mapView];

}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self.mapView animateToLocation:coordinate];
    self.marker.position = coordinate;
    self.marker.map = self.mapView;
}

- (IBAction)textFieldDidEndOnExit:(id)sender
{
    self.finalItemName = ((UITextField *)sender).text;
    self.deal[@"itemName"] = self.finalItemName;
}

- (void)saveButtonTapped:(id)sender
{
    self.deal[@"itemName"] = self.itemName.text;
    PFRelation *newRelation = [self.deal relationForKey:@"participants"];
    [newRelation addObject:[PFUser currentUser]];
    self.deal[@"initiator"] = [PFUser currentUser];
    PFGeoPoint *currentLoc = [PFGeoPoint geoPointWithLatitude:self.marker.position.latitude longitude:self.marker.position.longitude];
    self.deal[@"dealLocation"] = currentLoc;
    self.deal[@"active"] = @YES;
    [self.deal saveInBackground];
    
    self.tabBarController.selectedIndex = 0;
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
