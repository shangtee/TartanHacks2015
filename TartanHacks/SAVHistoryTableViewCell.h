//
//  SAVHistoryTableViewCell.h
//  TartanHacks
//
//  Created by Ruoxi Tan on 2/7/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAVHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
