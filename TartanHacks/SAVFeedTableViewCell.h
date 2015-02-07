//
//  SAVFeedTableViewCell.h
//  TartanHacks
//
//  Created by Ruoxi Tan on 2/6/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAVFeedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dealLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *proximityLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeRemainingLabel;

@end
