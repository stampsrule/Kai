//
//  econCountryTableViewController.h
//  Kai
//
//  Created by Daniel Bell on 2014-03-10.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "econCountryViewController.h"

@interface econCountryTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *countryRealIncome;
@property (nonatomic, strong) NSArray *countryNominalIncome;
@property (nonatomic, strong) NSArray *countryNominalInterest;
@property (nonatomic, strong) NSArray *countryMoneySupply;
@property (nonatomic, strong) NSArray *countryName;
@property (nonatomic, strong) NSArray *delegate;
@end