//
//  SAVHistoryDetailViewController.m
//  TartanHacks
//
//  Created by Ruoxi Tan on 2/7/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "SAVHistoryDetailViewController.h"

@interface SAVHistoryDetailViewController ()
@property (strong, nonatomic) Deal *curDeal;
@end

@implementation SAVHistoryDetailViewController
- (id) initWithDeal:(Deal *)deal {
    if (self) {
        self.curDeal = deal;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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