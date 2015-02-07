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
#import "SAVAddViewController.h"
#import "SAVHistoryViewController.h"

#import <FacebookSDK/FacebookSDK.h>

@interface SAVTabBarController ()

@end

@implementation SAVTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    SAVFeedViewController *feedViewController = [[SAVFeedViewController alloc] init];
    feedViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    feedViewController.tabBarItem.title = @"Feed";
    feedViewController.title = @"Around You";
    UINavigationController *feedNav = [[UINavigationController alloc] initWithRootViewController:feedViewController];
    
    SAVAddViewController *addViewController = [[SAVAddViewController alloc] init];
    addViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:1];
    addViewController.tabBarItem.title = @"Add Deal";
    addViewController.title = @"Add Deal";
    UINavigationController *addNav = [[UINavigationController alloc] initWithRootViewController:addViewController];
    
    SAVHistoryViewController *historyViewController = [[SAVHistoryViewController alloc] init];
    historyViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
    historyViewController.tabBarItem.title = @"Your Deals";
    historyViewController.title = @"Your Deals";
    UINavigationController *historyNav = [[UINavigationController alloc] initWithRootViewController:historyViewController];
    
    self.viewControllers = [NSMutableArray arrayWithObjects:feedNav, addNav, historyNav, nil];
    
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
