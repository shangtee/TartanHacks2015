//
//  SAVTabBarController.m
//  TartanHacks
//
//  Created by Sophia Anopa on 06.02.15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "SAVTabBarController.h"
#import "SAVLoginViewController.h"
#import "SAVFeedViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface SAVTabBarController ()

@end

@implementation SAVTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SAVFeedViewController *feedViewController = [[SAVFeedViewController alloc] init];
    
    self.viewControllers = [NSMutableArray arrayWithObjects:feedViewController, nil];
    
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
