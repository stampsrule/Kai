//
//  econCountryViewController.h
//  Kai
//
//  Created by Daniel Bell on 2014-03-03.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "econCountryTableViewController.h"

@protocol econCountryViewControllerDelegate;

@interface econCountryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *countryName;
@property (weak, nonatomic) IBOutlet UITextField *moneySupply;
@property (weak, nonatomic) IBOutlet UITextField *Income;
@property (weak) id <econCountryViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *strCountryName;
@property (strong, nonatomic) NSString *strPassedMoneySupplyValue;
@property (strong, nonatomic) NSString *strPassedRealIncomeValue;
@property (strong, nonatomic) NSString *strPassedNominalIncomeValue;
@property (strong, nonatomic) NSString *strPassedNominalInterestValue;


- (IBAction)SaveCountryData:(UIButton *)sender;
@end


@protocol econCountryViewControllerDelegate <NSObject>

@required

- (void)dismissPopCountry: (NSString *)Country
              moneySupply: (NSNumber *) moneySupply
               realincome: (NSNumber *) realIncome
            nominalIncome: (NSNumber *) nominalIncome
          nominalInterest: (NSNumber *) nominalInterest;
@end