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
@property (nonatomic, strong) UITextField *itemName;
@property (nonatomic, strong) PFGeoPoint *location;
@property (nonatomic, strong) UITextField *numberOfItems;
@property (nonatomic, strong) UITextField *totalPrice;
//@dynamic initiator;
//@dynamic storeName;
//@dynamic itemName;
//@dynamic description;
@end

@implementation SAVAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.itemName = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, 100, 25)];
    
    
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
