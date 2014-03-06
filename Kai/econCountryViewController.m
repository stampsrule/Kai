//
//  econCountryViewController.m
//  Kai
//
//  Created by Daniel Bell on 2014-03-03.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "econCountryViewController.h"

@interface econCountryViewController ()

@end

@implementation econCountryViewController

@synthesize countryName;
@synthesize moneySupply;
@synthesize Income;
@synthesize strCountryName;
@synthesize strPassedMoneySupplyValue;
@synthesize strPassedIncomeValue;

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)SaveCountryData:(UIButton *)sender
{
    NSCharacterSet *withFloats = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    NSString *moneySupplyString = [[moneySupply.text componentsSeparatedByCharactersInSet:withFloats] componentsJoinedByString:@""];
    NSString *incomeString = [[Income.text componentsSeparatedByCharactersInSet:withFloats] componentsJoinedByString:@""];
    
    if (![moneySupplyString isEqualToString:@""]){
        moneySupply.text=@"";
    }
    if (![incomeString isEqualToString:@""]){
        Income.text=@"";
    }

    if ([moneySupply.text isEqualToString: @""] || [Income.text isEqualToString: @""]) {
        NSString *alertMessage =[NSString stringWithFormat: @"%@%@%@ is invalid",
                                 [moneySupply.text isEqualToString:@""] ? @"money supply":@"",
                                 ([moneySupply.text isEqualToString:@""] && [Income.text isEqualToString:@""]) ? @" and ":@"",
                                 [Income.text isEqualToString:@""] ? @"income":@""];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"invalid value!" message:alertMessage  delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert addButtonWithTitle:@"reattempt"];
        [alert show];
    }
    if (![moneySupply.text isEqualToString: @""] && ![Income.text isEqualToString: @""]) {
        [delegate dismissPopCountry: countryName.text
                        moneySupply: [NSNumber numberWithFloat:[moneySupply.text floatValue]]
                             income: [NSNumber numberWithFloat: [Income.text floatValue]]];
    }
    
}


- (void)viewWillAppear: (BOOL)animated {
    [countryName setText:strCountryName];
    [moneySupply setText:[strPassedMoneySupplyValue stringValue]];
    [Income setText:[strPassedIncomeValue stringValue]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setCountryName:nil];
    [self setMoneySupply:nil];
    [self setIncome:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
