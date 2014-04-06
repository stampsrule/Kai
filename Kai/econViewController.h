//
//  econViewController.h
//  Kai
//
//  Created by Daniel Bell on 2/6/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

@import UIKit;
#import "econCountryViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"


@interface econViewController : UIViewController <econCountryViewControllerDelegate, UIPopoverControllerDelegate>
@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) econCountryViewController *pvc;
@property (strong, nonatomic) UIButton *menuBtn;

@property (weak, nonatomic) IBOutlet UIButton *homeCountryButton;
@property (weak, nonatomic) IBOutlet UIButton *foreignCountryButton;
@property (weak, nonatomic) IBOutlet UISlider *currentHomeMoneySupplySlider;
@property (weak, nonatomic) IBOutlet UISlider *currentHomeIncomeSlider;
@property (weak, nonatomic) IBOutlet UISlider *currentForeighnMoneySupplySlider;
@property (weak, nonatomic) IBOutlet UISlider *currentForeighnIncomeSlider;
@property (weak, nonatomic) IBOutlet UISlider *FutureHomeMoneySupplySlider;
@property (weak, nonatomic) IBOutlet UISlider *FutureHomeIncomeSlider;
@property (weak, nonatomic) IBOutlet UISlider *FutureForeighnMoneySupplySlider;
@property (weak, nonatomic) IBOutlet UISlider *FutureForeighnIncomeSlider;
@property (weak, nonatomic) IBOutlet UILabel *homeCurrnetMoneySupplyLabel;
@property (weak, nonatomic) IBOutlet UILabel *foreignCurrentMoneySupplyLabel;
@property (weak, nonatomic) IBOutlet UILabel *HomeFutureMoneySupplyLabel;
@property (weak, nonatomic) IBOutlet UILabel *foreignFutureMoneySupplyLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeCurrentRealIncomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *foreignCurrentRealIncomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeFutureRealIncomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *foreignFutureRealIncomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeNominalInterestRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *foreignNominalInterestRate;
@property (weak, nonatomic) IBOutlet UILabel *homePriceLevel;
@property (weak, nonatomic) IBOutlet UILabel *foreignPriceLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *exchangeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *expectedFutureExchangeRateLabel;
@property (weak, nonatomic) IBOutlet UIButton *nominalInterestRateButton;
@property (weak, nonatomic) IBOutlet UIButton *ForeignNominalInterestRateButton;
@property (weak, nonatomic) IBOutlet UIButton *ExchangeRateButton;
@property (weak, nonatomic) IBOutlet UIButton *HomePriceLevelButton;
@property (weak, nonatomic) IBOutlet UIButton *foreignPriceLevelButton;
@property (weak, nonatomic) IBOutlet UIButton *ExpectedFutureExchangeRateButton;



@end








