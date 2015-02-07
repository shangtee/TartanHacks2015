//
//  SAVFeedViewController.m
//  TartanHacks
//
//  Created by Ruoxi Tan on 2/6/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "SAVFeedViewController.h"
#import "SAVLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "DataCenter.h"
#import "SAVFeedTableViewCell.h"
#import "SAVFeedDetailView.h"
#import "Deal.h"

@interface SAVFeedViewController () <SAVMainDealDelegate>
@property NSMutableArray *dealList;
@property (nonatomic, strong) UISlider *radiusSlider;
@property (nonatomic, strong) UILabel *radiusLabel;
@end

@implementation SAVFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dealList = [NSMutableArray array];
    UINib *nib = [UINib nibWithNibName:@"SAVFeedTableViewCell" bundle:nil];
    // Register this NIB, which contains the cell
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"SAVFeedTableViewCell"];
    [[DataCenter sharedCenter] fetchDealsForUser:self radius:0.0];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    
    self.radiusSlider = [[UISlider alloc] initWithFrame: CGRectMake(35, 30, self.view.frame.size.width - 100, 40)];
    self.radiusSlider.value = [(NSNumber *)([PFUser currentUser][@"searchRadius"]) floatValue];
    self.radiusSlider.minimumValue = 0.0;
    self.radiusSlider.maximumValue = 10.0;
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 80)];
    [self.tableView.tableHeaderView addSubview:self.radiusSlider];
    
    self.radiusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width, 30)];
    self.radiusLabel.text = [NSString stringWithFormat:@"Search radius: %d km", (int)self.radiusSlider.value];
    self.radiusLabel.font = [UIFont fontWithName:@"Helvetica Light" size:15];
    [self.tableView.tableHeaderView addSubview:self.radiusLabel];

    [self.radiusSlider addTarget:self action:@selector(sliderValueConfirmed:) forControlEvents:UIControlEventValueChanged];
    self.radiusSlider.continuous = NO;
//    [self.radiusSlider addTarget:self action:@selector(sliderValueConfirmed:) forControlEvents:UIControlEventEditingDidEnd];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refreshTableView];
}

-(void)sliderValueChanged:(UISlider *)slider
{
    self.radiusLabel.text = [NSString stringWithFormat:@"Search Radius: %d km", (int)self.radiusSlider.value];
}

- (void)sliderValueConfirmed:(UISlider *)slider
{
    [self sliderValueChanged:slider];
    PFUser *me = [PFUser currentUser];
    me[@"searchRadius"] = @(self.radiusSlider.value);
    [me saveInBackground];
    [[DataCenter sharedCenter] fetchDealsForUser:self radius:self.radiusSlider.value];
}

-(void)dealDataFetched:(NSMutableArray *)data{
    self.dealList = data;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dealList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAVFeedTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SAVFeedTableViewCell" forIndexPath:indexPath];
    Deal *curDeal = self.dealList[indexPath.row];
    cell.dealLabel.text = curDeal.storeName;
    cell.itemLabel.text = curDeal.itemName.uppercaseString;
    cell.descriptionLabel.text = curDeal.descript;
    // MAKE A RANDOM COLOR for the bar
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 );  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.8 ;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    cell.color.backgroundColor = color;

    NSInteger interval = (NSInteger)[curDeal.dealExpirationTime timeIntervalSinceNow];
    NSInteger seconds = interval % 60;
    NSInteger minutes = (interval / 60) % 60;
    NSInteger hours = interval / 3600;
    cell.timeRemainingLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:curDeal.dealLocation.latitude longitude:curDeal.dealLocation.longitude];
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        // location services turned off for this app
        if (error) {
            
        } else { // location services on for this app. make a closet object and set its FormattedAddressLinesField. enable using current city
            CLPlacemark *placemark = [placemarks lastObject];
            if (!placemark) {
                cell.proximityLabel.text = @"Pittsburgh";
            } else {
                // only save the city of the current location.
                NSMutableString *cityString = [[NSMutableString alloc] init];
                if (placemark.addressDictionary[@"SubLocality"]) {
                    [cityString appendString:placemark.addressDictionary[@"SubLocality"]];
                    [cityString appendString:@" "];
                }
                if (placemark.addressDictionary[@"City"]) {
                    [cityString appendString:placemark.addressDictionary[@"City"]];
                    [cityString appendString:@" "];
                }
                if (placemark.addressDictionary[@"State"]) {
                    [cityString appendString:placemark.addressDictionary[@"State"]];
                    [cityString appendString:@" "];
                }
                if (placemark.addressDictionary[@"Country"]) {
                    [cityString appendString:placemark.addressDictionary[@"Country"]];
                }
                cell.proximityLabel.text = cityString;
            }
        }
    }];
    // Configure the cell...
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SAVFeedDetailView *newDetailView = [[SAVFeedDetailView alloc] initWithDeal:self.dealList[indexPath.row]];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(_done)];
    self.navigationController.navigationItem.rightBarButtonItem = leftBarButtonItem;
    [self.navigationController pushViewController:newDetailView animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

-(void)_done
{
    [self.navigationController popToViewController:self animated:YES];
}

-(void)refreshTableView
{
    [[DataCenter sharedCenter] fetchDealsForUser:self radius:0.0];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
