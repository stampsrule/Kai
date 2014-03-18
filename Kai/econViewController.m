//
//  econViewController.m
//  Kai
//
//  Created by Daniel Bell on 2/6/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "econViewController.h"
#import "econcountry.h"
//#import "econCountryViewController.h"
@interface econViewController ()

@property (nonatomic, strong) econcountry *homeCountry;
@property (nonatomic, strong) econcountry *foreighnCountry;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *popOverFinished;
@property (weak, nonatomic) NSString* segueName;
@property (weak, nonatomic) IBOutlet UIButton *homeCountryButton;
@property (weak, nonatomic) IBOutlet UIButton *foreignCountryButton;
@property (weak, nonatomic) IBOutlet UISlider *currentHomeMoneySupplySlider;
@property (weak, nonatomic) IBOutlet UISlider *currentHomeIncomeSlider;
@property (weak, nonatomic) IBOutlet UISlider *currentForeighnMoneySupplySlider;
@property (weak, nonatomic) IBOutlet UISlider *currentForeighnIncomeSlider;
@property (nonatomic) float tempHMS;
@property (nonatomic) float tempHRI;
@property (nonatomic) float tempFMS;
@property (nonatomic) float tempFRI;

@end


@implementation econViewController

@synthesize currentPopoverSegue;
@synthesize pvc;
@synthesize tempFMS;
@synthesize tempFRI;
@synthesize tempHMS;
@synthesize tempHRI;

- (econcountry *) homeCountry
{
    if (!_homeCountry) {
        _homeCountry = [[econcountry alloc] initWithName:@"home"];
    }
    return _homeCountry;
}

- (econcountry *) foreighnCountry
{
    if (!_foreighnCountry) {
        _foreighnCountry = [[econcountry alloc] initWithName:@"foreighn"];
    }
    return _foreighnCountry;
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    tempFMS=1;
    tempFRI=1;
    tempHMS=1;
    tempHRI=1;
    self.currentForeighnIncomeSlider.value=1;
    self.currentForeighnMoneySupplySlider.value=1;
    self.currentHomeIncomeSlider.value=1;
    self.currentHomeMoneySupplySlider.value=1;
}


- (void)dismissPopCountry: (NSString *)Country moneySupply: (NSNumber *) moneySupply income: (NSNumber *) income;
 {
     if ([self.segueName isEqualToString:@"segCountry2Pop"]) {
         self.foreighnCountry.name=Country;
         [self.foreignCountryButton setAttributedTitle:[[NSMutableAttributedString alloc] initWithString:self.foreighnCountry.name attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]}] forState:UIControlStateNormal];
         self.foreighnCountry.moneySupply=moneySupply;
         self.foreighnCountry.realIncome=income;
     }
     if ([self.segueName isEqualToString:@"segCountry1Pop"]) {
         self.homeCountry.name=Country;
         [self.homeCountryButton setAttributedTitle:[[NSMutableAttributedString alloc] initWithString:self.homeCountry.name attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]}] forState:UIControlStateNormal];
         self.homeCountry.moneySupply=moneySupply;
         self.homeCountry.realIncome=income;
     }
     [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss the popover
     self.currentForeighnIncomeSlider.value=1;
     self.currentForeighnMoneySupplySlider.value=1;
     self.currentHomeIncomeSlider.value=1;
     self.currentHomeMoneySupplySlider.value=1;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.segueName = segue.identifier;
    if ([self.segueName isEqualToString:@"segCountry1Pop"]){
        currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        pvc = segue.destinationViewController;
        pvc.delegate=self;
        pvc.strCountryName=self.homeCountry.name;
        pvc.strPassedIncomeValue=[NSString stringWithFormat:@"%f", [self.homeCountry.realIncome floatValue]/tempFRI];
        pvc.strPassedMoneySupplyValue=[NSString stringWithFormat:@"%f", [self.homeCountry.moneySupply floatValue]/tempFMS];
    }
    if ([self.segueName isEqualToString:@"segCountry2Pop"]){
        currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        pvc = segue.destinationViewController;
        pvc.delegate=self;
        pvc.strCountryName=self.foreighnCountry.name;
        pvc.strPassedIncomeValue=[NSString stringWithFormat:@"%f", [self.foreighnCountry.realIncome floatValue]/tempFRI];
        pvc.strPassedMoneySupplyValue=[NSString stringWithFormat:@"%f", [self.foreighnCountry.moneySupply floatValue]/tempFMS];
    }

}

- (IBAction)resetMoneySupply:(UIButton *)sender {
    self.homeCountry.moneySupply=[NSNumber numberWithFloat:[self.homeCountry.moneySupply floatValue]/self.currentHomeMoneySupplySlider.value];
    self.currentHomeMoneySupplySlider.value=1;
}

- (IBAction)resetRealIncome:(UIButton *)sender {
    self.homeCountry.realIncome=[NSNumber numberWithFloat:[self.homeCountry.realIncome floatValue]/self.currentHomeIncomeSlider.value];
    self.currentHomeIncomeSlider.value=1;
}

- (IBAction)resetForeighnMoneySupply:(UIButton *)sender {
    self.foreighnCountry.moneySupply=[NSNumber numberWithFloat:[self.foreighnCountry.moneySupply floatValue]/self.currentForeighnMoneySupplySlider.value];
    self.currentForeighnMoneySupplySlider.value=1;
}

- (IBAction)resetForeighnRealIncome:(UIButton *)sender {
    self.foreighnCountry.realIncome=[NSNumber numberWithFloat:[self.foreighnCountry.realIncome floatValue]/self.currentForeighnIncomeSlider.value];
    self.currentForeighnIncomeSlider.value=1;
}

- (IBAction)changeHomeMoneySupply:(UISlider *)sender {
    self.homeCountry.moneySupply=[NSNumber numberWithFloat:[self.homeCountry.moneySupply floatValue]/tempHMS];
    self.homeCountry.moneySupply=[NSNumber numberWithFloat:[self.homeCountry.moneySupply floatValue]*sender.value];
    tempHMS=sender.value;
}

- (IBAction)changeHomeRealIncome:(UISlider *)sender {
    self.homeCountry.realIncome=[NSNumber numberWithFloat:[self.homeCountry.realIncome floatValue]/tempHRI];
    self.homeCountry.realIncome=[NSNumber numberWithFloat:[self.homeCountry.moneySupply floatValue]*sender.value];
    tempHRI=sender.value;
}

- (IBAction)changeForeighnMoneySupply:(UISlider *)sender {
    self.foreighnCountry.moneySupply=[NSNumber numberWithFloat:[self.foreighnCountry.moneySupply floatValue]/tempFMS];
    self.foreighnCountry.moneySupply=[NSNumber numberWithFloat:[self.foreighnCountry.moneySupply floatValue]*sender.value];
    tempFMS=sender.value;
}

- (IBAction)changeForeighnRealIncome:(UISlider *)sender {
    self.foreighnCountry.realIncome=[NSNumber numberWithFloat:[self.foreighnCountry.realIncome floatValue]/tempFRI];
    self.foreighnCountry.realIncome=[NSNumber numberWithFloat:[self.foreighnCountry.realIncome floatValue]*sender.value];
    tempFRI=sender.value;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
