//
//  SAVHistoryViewController.m
//  TartanHacks
//
//  Created by Ruoxi Tan on 2/6/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "SAVHistoryViewController.h"
#import "SAVHistoryTableViewCell.h"
#import "DataCenter.h"
#import "Deal.h"
#import "SAVHistoryDetailViewController.h"

@interface SAVHistoryViewController ()<SAVHistoryDelegate>

@property NSMutableArray *dealList;

@end

@implementation SAVHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dealList = [NSMutableArray array];
    UINib *nib = [UINib nibWithNibName:@"SAVHistoryTableViewCell" bundle:nil];
    // Register this NIB, which contains the cell
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"SAVHistoryTableViewCell"];
    [[DataCenter sharedCenter] fetchDealsOfUser:self];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)dealDataFetched:(NSMutableArray *)data{
    self.dealList = data;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dealList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    SAVHistoryTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SAVHistoryTableViewCell" forIndexPath:indexPath];
    Deal *curDeal = self.dealList[indexPath.row];
    cell.storeLabel.text = curDeal.storeName;
    cell.itemLabel.text = curDeal.itemName;
    cell.descriptionLabel.text = curDeal.descript;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    NSString *dateString = [dateFormatter stringFromDate:curDeal.dealExpirationTime];
    cell.dateLabel.text = dateString;

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SAVHistoryDetailViewController *newDetailView = [[SAVHistoryDetailViewController alloc] initWithDeal:self.dealList[indexPath.row]];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(_done)];
    self.navigationController.navigationItem.rightBarButtonItem = leftBarButtonItem;
    [self.navigationController pushViewController:newDetailView animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)_done{
    [self.navigationController popToViewController:self animated:YES];
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
