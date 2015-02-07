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

@interface SAVAddViewController () <GMSMapViewDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate>
@property (nonatomic, strong) PFObject *deal;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UITextField *storeNameField;
@property (weak, nonatomic) IBOutlet UITextField *itemNameField;
@property (weak, nonatomic) IBOutlet UITextField *buyNumItemsField;
@property (weak, nonatomic) IBOutlet UITextField *getNumItemsField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *discountField;
@property (weak, nonatomic) IBOutlet UITextField *reservedItemsField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UITextField *pricePerItem;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (nonatomic, strong) UIImage *pickedImage;
@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) GMSMarker *marker;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property BOOL fromCamera;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@end

@implementation SAVAddViewController
//- (void)loadView
//{
//    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    CGRect screenRect = [UIScreen mainScreen].bounds;
//    CGRect bigRect = screenRect;
//    bigRect.size.width *= 2.0;
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
//    scrollView.scrollEnabled = YES;
//    [self.view addSubview:scrollView];
//    
//    self.leftView = [[UIView alloc] initWithFrame:screenRect];
//    self.deal = [PFObject objectWithClassName:@"Deal"];
//    self.storeNameField = [[UITextField alloc] init];
//    self.itemNameField.text = @"";
//    self.buyNumItemsField.text = @"";
//    self.getNumItemsField.text = @"";
//    self.datePicker.date = [NSDate date];
//    self.discountField.text = @"";
//    self.reservedItemsField.text = @"";
//    self.descriptionField.text = @"";
//    self.pricePerItem.text = @"";
//    self.totalPrice.text = @"";
//    self.pickedImage = NULL;
//    self.marker = NULL;
//    
//    
//}

- (void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
    if (self.fromCamera == YES) {self.fromCamera = NO; return; }
    self.deal = [PFObject objectWithClassName:@"Deal"];
    self.storeNameField.text = @"";
    self.itemNameField.text = @"";
    self.buyNumItemsField.text = @"";
    self.getNumItemsField.text = @"";
    self.datePicker.date = [NSDate date];
    self.discountField.text = @"";
    self.reservedItemsField.text = @"";
    self.descriptionField.text = @"";
    self.pricePerItem.text = @"";
    self.totalPrice.text = @"";
    self.pickedImage = NULL;
    self.marker = NULL;
    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    CLLocation *location = self.locationManager.location;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                            longitude:location.coordinate.longitude
                                                                 zoom:6];
    self.mapView.camera = camera;
    self.mapView.myLocationEnabled = YES;
    
    // Creates a marker in the center of the map.
    self.marker = [[GMSMarker alloc] init];
    self.marker.position = self.mapView.myLocation.coordinate;
    self.marker.map = self.mapView;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*2, self.scrollView.frame.size.height);
    
    self.rightView.frame = CGRectMake(self.leftView.frame.size.width, 0, self.rightView.frame.size.width, self.rightView.frame.size.height);
    
    self.scrollView.pagingEnabled = YES;
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonTapped:)];

    self.getNumItemsField.delegate = self;
    self.buyNumItemsField.delegate = self;
    self.pricePerItem.delegate = self;

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:0.0 longitude:0.0 zoom:1.0];
    self.mapView = [GMSMapView mapWithFrame:CGRectMake(0, self.leftView.frame.size.height - 410, self.leftView.frame.size.width, 300) camera:camera];
    
    self.mapView.delegate = self;
    self.fromCamera = NO;
    [self.leftView addSubview:self.mapView];

}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    [self.mapView animateToLocation:coordinate];
    self.marker.position = coordinate;
    self.marker.map = self.mapView;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![self.buyNumItemsField.text isEqualToString:@""] && ![self.getNumItemsField.text isEqualToString:@""] && ![self.pricePerItem.text isEqualToString:@""] && ![self.discountField.text isEqualToString:@""]) {
        int buynum = [self.buyNumItemsField.text intValue];
        int getnum = [self.getNumItemsField.text intValue];
        double priceper = [self.pricePerItem.text doubleValue];
        double discount = [self.discountField.text doubleValue] / 100.0;
        
        double total = buynum * priceper + getnum * priceper * (1.0 - discount);
        self.totalPrice.text = [NSString stringWithFormat:@"%.2f", total];
    }
}

- (void)saveButtonTapped:(id)sender
{
    self.deal[@"itemName"] = self.itemNameField.text;
    PFRelation *newRelation = [self.deal relationForKey:@"participants"];
    [newRelation addObject:[PFUser currentUser]];
    self.deal[@"initiator"] = [PFUser currentUser];
    PFGeoPoint *currentLoc = [PFGeoPoint geoPointWithLatitude:self.marker.position.latitude longitude:self.marker.position.longitude];
    self.deal[@"dealLocation"] = currentLoc;
    self.deal[@"active"] = @YES;
    self.deal[@"storeName"] = self.storeNameField.text;
    self.deal[@"descript"] = self.descriptionField.text;
    self.deal[@"numberOfItems"] = [NSNumber numberWithInt:([self.buyNumItemsField.text intValue] + [self.getNumItemsField.text intValue])];
    self.deal[@"numberOfItemsLeft"] = [NSNumber numberWithInt:([self.buyNumItemsField.text intValue] + [self.getNumItemsField.text intValue] - [self.reservedItemsField.text intValue])];
    self.deal[@"totalPrice"] = [NSNumber numberWithDouble:[self.totalPrice.text doubleValue]];
    self.deal[@"dealExpirationTime"] = self.datePicker.date;
    if (self.pickedImage) {
        NSData *imageData = UIImagePNGRepresentation(self.pickedImage);
        PFFile *imageFile = [PFFile fileWithName:@"image" data:imageData];
        
        self.deal[@"image"] = imageFile;
    }
    
    [self.deal saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            PFUser *user = [PFUser currentUser];
            PFRelation *dealsRelation = [user relationForKey:@"dealsAsso"];
            [dealsRelation addObject:self.deal];
            NSMutableDictionary *curDict = user[@"dealNumDict"];
            if (curDict == nil){
                curDict = [[NSMutableDictionary alloc] init];
            }
            [curDict setObject:[NSNumber numberWithInteger:[self.reservedItemsField.text intValue]] forKey:self.deal.objectId];
            user[@"dealNumDict"] = curDict;
            [user save];
        }
    }];
    
    self.tabBarController.selectedIndex = 0;
}

- (IBAction)addPhotoButtonTapped:(id)sender
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"No camera, on simulator");
    } else {
        self.fromCamera = YES;
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.pickedImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
