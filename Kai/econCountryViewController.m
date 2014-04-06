//
//  econCountryViewController.m
//  Kai
//
//  Created by Daniel Bell on 2014-03-03.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "econCountryViewController.h"
#import "econAppDelegate.h"
#import "CountryName.h"
#import "NominalGDPData.h"
#import "M1Data.h"
#import "RealGDPData.h"
#import "M2Data.h"

@interface econCountryViewController ()
@property (weak, nonatomic) NSString* segueName;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end

@implementation econCountryViewController

@synthesize countryName;
@synthesize moneySupply;
@synthesize Income;
@synthesize strCountryName;
@synthesize strPassedRealIncomeValue;
@synthesize strPassedNominalIncomeValue;
@synthesize strPassedMoneySupplyValue;

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
                        moneySupply:[NSNumber numberWithDouble:[strPassedMoneySupplyValue doubleValue]] realincome:[NSNumber numberWithDouble:[strPassedRealIncomeValue doubleValue]] nominalIncome:[NSNumber numberWithDouble:[strPassedNominalIncomeValue doubleValue]]];
        
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"Show list of countries"]) {
        if ([segue.destinationViewController isKindOfClass:[econCountryTableViewController class]]) {
            econCountryTableViewController *ecvc = (econCountryTableViewController *)segue.destinationViewController;
            ecvc.delegate= [NSArray arrayWithObjects:delegate, nil];
        }
    }

}


- (void)viewWillAppear: (BOOL)animated {
    [countryName setText:strCountryName];
    [moneySupply setText:strPassedMoneySupplyValue];
    [Income setText:strPassedRealIncomeValue];
}


    
- (void)viewDidLoad
{
    [super viewDidLoad];
    //1
    econAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    //2
    self.managedObjectContext = appDelegate.managedObjectContext;
}

- (void)viewDidUnload
{
    [self setCountryName:nil];
    [self setMoneySupply:nil];
    [self setIncome:nil];
    [super viewDidUnload];
}

@end
