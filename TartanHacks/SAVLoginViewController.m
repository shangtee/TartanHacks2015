//
//  SAVLoginViewController.m
//  TartanHacks
//
//  Created by Sophia Anopa on 06.02.15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "SAVLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface SAVLoginViewController ()

@end

@implementation SAVLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.center = self.view.center;
    [self.view addSubview:loginView];

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
