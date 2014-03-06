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

@end


@implementation econViewController

@synthesize currentPopoverSegue;
@synthesize pvc;


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



- (void)dismissPopCountry: (NSString *)Country moneySupply: (NSNumber *) moneySupply income: (NSNumber *) income;
 {
     if ([self.segueName isEqualToString:@"segCountry2Pop"]) {
         self.foreighnCountry.name=Country;
         [self.foreignCountryButton setTitle:self.foreighnCountry.name forState:UIControlStateNormal];
         self.foreighnCountry.moneySupply=moneySupply;
         self.foreighnCountry.realIncome=income;
     }
     if ([self.segueName isEqualToString:@"segCountry1Pop"]) {
         self.homeCountry.name=Country;
         [self.homeCountryButton setTitle:self.homeCountry.name forState:UIControlStateNormal];
         self.homeCountry.moneySupply=moneySupply;
         self.homeCountry.realIncome=income;
     }
     [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss the popover
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.segueName = segue.identifier;
    if ([self.segueName isEqualToString:@"segCountry1Pop"]){
        currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        pvc = [segue destinationViewController];
        [pvc setDelegate:self];
        [pvc setStrCountryName:self.homeCountry.name];
        [pvc setStrPassedIncomeValue:self.homeCountry.realIncome];
        [pvc setStrPassedMoneySupplyValue:self.homeCountry.moneySupply];
    }
    if ([self.segueName isEqualToString:@"segCountry2Pop"]){
        currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        pvc = [segue destinationViewController];
        [pvc setDelegate:self];
        [pvc setStrCountryName:self.foreighnCountry.name];
        [pvc setStrPassedIncomeValue:self.foreighnCountry.realIncome];
        [pvc setStrPassedMoneySupplyValue:self.foreighnCountry.moneySupply];
    }


}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
