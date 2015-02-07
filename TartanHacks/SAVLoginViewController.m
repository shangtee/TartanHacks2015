//
//  SAVLoginViewController.m
//  TartanHacks
//
//  Created by Sophia Anopa on 06.02.15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "SAVLoginViewController.h"

#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>

@interface SAVLoginViewController () <FBLoginViewDelegate>

@end

@implementation SAVLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.delegate = self;
    loginView.center = self.view.center;
    [self.view addSubview:loginView];

}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    NSString *username = user.username;
    NSError *error;
    [PFUser logInWithUsername:username password:username error:&error];
    if (error) {
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = username;
        NSError *signUpError;
        [newUser signUp:&signUpError];
        if (error) {
            NSLog(@"Error while signing up for Parse");
        }
    }
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
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
