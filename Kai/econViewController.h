//
//  econViewController.h
//  Kai
//
//  Created by Daniel Bell on 2/6/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

@import UIKit;
#import "econCountryViewController.h"

@interface econViewController : UIViewController <econCountryViewControllerDelegate, UIPopoverControllerDelegate>
@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) econCountryViewController *pvc;


@end








