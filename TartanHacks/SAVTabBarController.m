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
#import "SAVSettingsViewController.h"

#import <FacebookSDK/FacebookSDK.h>

@interface SAVTabBarController ()

@property (nonatomic, strong) SAVFeedViewController *feedvc;
@property (nonatomic, strong) SAVHistoryViewController *historyvc;

@end

@implementation SAVTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIColor *offWhite = [UIColor colorWithRed:255.0f/255.0f
                                       green:251.0f/255.0f
                                        blue:246.0f/255.0f
                                       alpha:1.0f];
    UIColor *seafoam = [UIColor colorWithRed:149.0f/255.0f
                                       green:214.0f/255.0f
                                        blue:193.0f/255.0f
                                       alpha:1.0f];
    
    SAVFeedViewController *feedViewController = [[SAVFeedViewController alloc] init];
    feedViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"house.gif"] selectedImage:[UIImage imageNamed:@"house.gif"]];
    feedViewController.tabBarItem.title = @"Feed";
    feedViewController.title = @"around you";
    UINavigationController *feedNav = [[UINavigationController alloc] initWithRootViewController:feedViewController];
    feedNav.navigationBar.barTintColor = seafoam;
    feedNav.navigationBar.tintColor = [UIColor whiteColor];
    [feedNav.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    feedNav.navigationBar.translucent = NO;
    [feedNav.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      offWhite,NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Futura" size:18],
      NSFontAttributeName, nil]];
    
    SAVAddViewController *addViewController = [[SAVAddViewController alloc] init];
    addViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@"plus.gif"] selectedImage:[UIImage imageNamed:@"plus.gif"]];
    addViewController.tabBarItem.title = @"Add Deal";
    addViewController.title = @"new";
    UINavigationController *addNav = [[UINavigationController alloc] initWithRootViewController:addViewController];
    addNav.navigationBar.barTintColor = seafoam;
    addNav.navigationBar.tintColor = [UIColor whiteColor];
    [addNav.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    addNav.navigationBar.translucent = NO;
    [addNav.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      offWhite,NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Futura" size:18],
      NSFontAttributeName, nil]];

    
    SAVHistoryViewController *historyViewController = [[SAVHistoryViewController alloc] init];
    historyViewController.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2];
    historyViewController.tabBarItem.title = @"Your Deals";
    historyViewController.title = @"Your Deals";
    UINavigationController *historyNav = [[UINavigationController alloc] initWithRootViewController:historyViewController];
    historyNav.navigationBar.barTintColor = seafoam;
    historyNav.navigationBar.tintColor = [UIColor whiteColor];
    [historyNav.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    historyNav.navigationBar.translucent = NO;
    [historyNav.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      offWhite,NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Futura" size:18],
      NSFontAttributeName, nil]];
    
    [self.tabBar setBarTintColor:seafoam];
    [self.tabBar setTintColor: offWhite];
    self.viewControllers = [NSMutableArray arrayWithObjects:feedNav, addNav, historyNav, nil];
    self.historyvc = historyViewController;
    self.feedvc = feedViewController;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh {
    [self.feedvc refreshTableView];
    [self.historyvc refreshTableView];
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
