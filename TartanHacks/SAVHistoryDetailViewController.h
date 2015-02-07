//
//  SAVHistoryDetailViewController.h
//  TartanHacks
//
//  Created by Ruoxi Tan on 2/7/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deal.h"
@interface SAVHistoryDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (id) initWithDeal:(Deal *)deal;
@end
