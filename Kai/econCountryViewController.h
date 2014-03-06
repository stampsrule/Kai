//
//  econCountryViewController.h
//  Kai
//
//  Created by Daniel Bell on 2014-03-03.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol econCountryViewControllerDelegate;

@interface econCountryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *countryName;
@property (weak, nonatomic) IBOutlet UITextField *moneySupply;
@property (weak, nonatomic) IBOutlet UITextField *Income;
@property (weak) id <econCountryViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *strCountryName;
@property (strong, nonatomic) NSNumber *strPassedMoneySupplyValue;
@property (strong, nonatomic) NSNumber *strPassedIncomeValue;

- (IBAction)SaveCountryData:(UIButton *)sender;

@end


@protocol econCountryViewControllerDelegate <NSObject>

@required

- (void)dismissPopCountry: (NSString *)Country
              moneySupply: (NSNumber *) moneySupply
                   income: (NSNumber *) income;

@end