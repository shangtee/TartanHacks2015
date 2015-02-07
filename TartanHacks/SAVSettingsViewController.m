//
//  SAVSettingsViewController.m
//  TartanHacks
//
//  Created by Sophia Anopa on 07.02.15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import "SAVSettingsViewController.h"
#import "DataCenter.h"

@interface SAVSettingsViewController ()
@property (weak, nonatomic) IBOutlet UISlider *radiusSlider;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;


@end

@implementation SAVSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.radiusSlider.value = [(NSNumber *)([PFUser currentUser][@"searchRadius"]) floatValue];
    self.sliderLabel.text = [NSString stringWithFormat:@"%d",(int)self.radiusSlider.value];
    [self.radiusSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

-(void)sliderValueChanged:(UISlider *)slider
{
    self.sliderLabel.text = [NSString stringWithFormat:@"%d",(int)slider.value];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[DataCenter sharedCenter] updateRadius:(int)self.radiusSlider.value];
    
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
- (IBAction)logout:(id)sender {
}

@end
