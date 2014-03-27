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
@synthesize strPassedIncomeValue;
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
                        moneySupply: [NSNumber numberWithFloat:[moneySupply.text floatValue]]
                             income: [NSNumber numberWithFloat: [Income.text floatValue]]];
        
    }
    
}

- (IBAction)addCountryEntity:(id)sender
{
    // Add Entry to PhoneBook Data base and reset all fields
    
    //  1
    CountryName * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"CountryName"
                                                      inManagedObjectContext:self.managedObjectContext];
    //  2
    newEntry.name=@"USA";
    newEntry.lastChange=[NSDate date];
    
    
    
    //  6
    NSString *dateStr = @"01-01-";
    NSNumber *yearValue = [NSNumber numberWithInt:2012];
    NSDateFormatter *editDate =   [[NSDateFormatter alloc] init];
    [editDate setDateFormat:@"MM-dd-yyy"];
    dateStr=[dateStr stringByAppendingString:[yearValue stringValue]];

    M2Data * m2Object= [NSEntityDescription insertNewObjectForEntityForName:@"M2Data"
                                                     inManagedObjectContext:self.managedObjectContext];
    
    RealGDPData * realGDPObject = [NSEntityDescription insertNewObjectForEntityForName:@"RealGDPData"
                                                                inManagedObjectContext:self.managedObjectContext];
    
    m2Object.current=[NSNumber numberWithLong:14103420441094];
    realGDPObject.current=[NSNumber numberWithLong:13595644353592];
    m2Object.currentYear=[editDate dateFromString:dateStr];
    realGDPObject.currentYear=[editDate dateFromString:dateStr];
    
    newEntry.countryM2 = m2Object;
    newEntry.countryRealGDP = realGDPObject;
    
    //  3
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    [self.view endEditing:YES];
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
    [Income setText:strPassedIncomeValue];
}


    
- (void)viewDidLoad
{
    [super viewDidLoad];
    //1
    econAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    //2
    self.managedObjectContext = appDelegate.managedObjectContext;
    [self addCountryEntity:self];
}

- (void)viewDidUnload
{
    [self setCountryName:nil];
    [self setMoneySupply:nil];
    [self setIncome:nil];
    [super viewDidUnload];
}

@end
