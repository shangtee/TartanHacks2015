//
//  SAVFeedDetailView.h
//  TartanHacks
//
//  Created by Zhichun Li on 2/7/15.
//  Copyright (c) 2015 SLZA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deal.h"
@interface SAVFeedDetailView : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UITextView *descript;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *toClaimNumItems;
@property (weak, nonatomic) IBOutlet UIStepper *toClaimStepper;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
-(id) initWithDeal: (Deal *) curDeal;
@end
