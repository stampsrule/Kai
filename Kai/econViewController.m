//
//  econViewController.m
//  Kai
//
//  Created by Daniel Bell on 2/6/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "econViewController.h"
#import "econcountry.h"
#import "econUtilMonetaryTheoryFunc.h"


//#import "econCountryViewController.h"
@interface econViewController ()

@property (nonatomic, strong) econcountry *homeCountry;
@property (nonatomic, strong) econcountry *foreighnCountry;
@property (nonatomic, strong) econcountry *homeCountryFuture;
@property (nonatomic, strong) econcountry *foreighnCountryFuture;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *popOverFinished;
@property (weak, nonatomic) NSString* segueName;
@property (nonatomic) double tempHMS;
@property (nonatomic) double tempHRI;
@property (nonatomic) double tempFMS;
@property (nonatomic) double tempFRI;
@property (nonatomic) double tempFHMS;
@property (nonatomic) double tempFHRI;
@property (nonatomic) double tempFFMS;
@property (nonatomic) double tempFFRI;
@property (nonatomic) double currentExchangeRate;
@property (nonatomic) double expectedFutureExchangeRate;

@end


@implementation econViewController

@synthesize currentPopoverSegue;
@synthesize pvc;
@synthesize menuBtn;
@synthesize tempFMS;
@synthesize tempFRI;
@synthesize tempHMS;
@synthesize tempHRI;
@synthesize tempFFMS;
@synthesize tempFFRI;
@synthesize tempFHMS;
@synthesize tempFHRI;
@synthesize homeCurrnetMoneySupplyLabel;
@synthesize foreignCurrentMoneySupplyLabel;
@synthesize HomeFutureMoneySupplyLabel;
@synthesize foreignFutureMoneySupplyLabel;
@synthesize homeCurrentRealIncomeLabel;
@synthesize foreignCurrentRealIncomeLabel;
@synthesize homeFutureRealIncomeLabel;
@synthesize foreignFutureRealIncomeLabel;
@synthesize homeNominalInterestRateLabel;
@synthesize foreignNominalInterestRate;
@synthesize homePriceLevel;
@synthesize foreignPriceLevelLabel;
@synthesize exchangeRateLabel;
@synthesize expectedFutureExchangeRateLabel;
@synthesize currentExchangeRate;
@synthesize expectedFutureExchangeRate;

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

- (econcountry *) homeCountryFuture
{
    if (!_homeCountryFuture) {
        _homeCountryFuture = [[econcountry alloc] initWithName:@"home"];
    }
    return _homeCountryFuture;
}

- (econcountry *) foreighnCountryFuture
{
    if (!_foreighnCountryFuture) {
        _foreighnCountryFuture = [[econcountry alloc] initWithName:@"foreighn"];
    }
    return _foreighnCountryFuture;
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    //reset current
    tempFMS=1;
    tempFRI=1;
    tempHMS=1;
    tempHRI=1;
    self.currentForeighnIncomeSlider.value=1;
    self.currentForeighnMoneySupplySlider.value=1;
    self.currentHomeIncomeSlider.value=1;
    self.currentHomeMoneySupplySlider.value=1;
    
    //reset future
    tempFFMS=1;
    tempFFRI=1;
    tempFHMS=1;
    tempFHRI=1;
    self.FutureForeighnIncomeSlider.value=1;
    self.FutureForeighnMoneySupplySlider.value=1;
    self.FutureHomeIncomeSlider.value=1;
    self.FutureHomeMoneySupplySlider.value=1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    
    //[self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(8, 20, 34, 24);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.menuBtn];
}


- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}


- (void)dismissPopCountry: (NSString *)Country moneySupply: (NSNumber *) moneySupply realincome: (NSNumber *) realIncome
            nominalIncome: (NSNumber *) nominalIncome
 {
     if ([self.segueName isEqualToString:@"segCountry2Pop"]) {
         self.foreighnCountry.name=Country;
         self.foreighnCountryFuture.name=Country;
         [self.foreignCountryButton setAttributedTitle:[[NSMutableAttributedString alloc] initWithString:self.foreighnCountry.name attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]}] forState:UIControlStateNormal];
         self.foreighnCountry.moneySupply=moneySupply;
         self.foreighnCountry.realIncome=realIncome;
         self.foreighnCountry.nominalIncome=nominalIncome;
         self.foreighnCountryFuture.moneySupply=moneySupply;
         self.foreighnCountryFuture.realIncome=realIncome;
         self.foreighnCountryFuture.nominalIncome=nominalIncome;
         [self setNominalInterestRate:self.foreighnCountryFuture];
         [self setNominalInterestRate:self.foreighnCountry];
     }
     if ([self.segueName isEqualToString:@"segCountry1Pop"]) {
         self.homeCountry.name=Country;
         self.homeCountryFuture.name=Country;
         [self.homeCountryButton setAttributedTitle:[[NSMutableAttributedString alloc] initWithString:self.homeCountry.name attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]}] forState:UIControlStateNormal];
         self.homeCountry.moneySupply=moneySupply;
         self.homeCountry.realIncome=realIncome;
         self.homeCountry.nominalIncome=nominalIncome;
         self.homeCountryFuture.moneySupply=moneySupply;
         self.homeCountryFuture.realIncome=realIncome;
         self.homeCountryFuture.nominalIncome=nominalIncome;
         [self setNominalInterestRate:self.homeCountryFuture];
         [self setNominalInterestRate:self.homeCountry];
     }
     [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss the popover
     self.currentForeighnIncomeSlider.value=1;
     self.currentForeighnMoneySupplySlider.value=1;
     self.currentHomeIncomeSlider.value=1;
     self.currentHomeMoneySupplySlider.value=1;
     
     self.FutureForeighnIncomeSlider.value=1;
     self.FutureForeighnMoneySupplySlider.value=1;
     self.FutureHomeIncomeSlider.value=1;
     self.FutureHomeMoneySupplySlider.value=1;
    
     [self updateCountryLabels];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.segueName = segue.identifier;
    if ([self.segueName isEqualToString:@"segCountry1Pop"]){
        currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        pvc = segue.destinationViewController;
        pvc.delegate=self;
        pvc.strCountryName=self.homeCountry.name;
        pvc.strPassedRealIncomeValue=[NSString stringWithFormat:@"%f", [self.homeCountry.realIncome doubleValue]/tempHRI];
        pvc.strPassedMoneySupplyValue=[NSString stringWithFormat:@"%f", [self.homeCountry.moneySupply doubleValue]/tempHMS];
    }
    if ([self.segueName isEqualToString:@"segCountry2Pop"]){
        currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        pvc = segue.destinationViewController;
        pvc.delegate=self;
        pvc.strCountryName=self.foreighnCountry.name;
        pvc.strPassedRealIncomeValue=[NSString stringWithFormat:@"%f", [self.foreighnCountry.realIncome doubleValue]/tempFRI];
        pvc.strPassedMoneySupplyValue=[NSString stringWithFormat:@"%f", [self.foreighnCountry.moneySupply doubleValue]/tempFMS];
    }

}

- (IBAction)resetMoneySupply:(UIButton *)sender {
    self.homeCountry.moneySupply=[NSNumber numberWithDouble:[self.homeCountry.moneySupply doubleValue]/self.currentHomeMoneySupplySlider.value];
    self.currentHomeMoneySupplySlider.value=1;
    self.nominalInterestRateButton.backgroundColor=[UIColor clearColor];
    [self updateCountryLabels];
}

- (IBAction)resetRealIncome:(UIButton *)sender {
    self.homeCountry.realIncome=[NSNumber numberWithDouble:[self.homeCountry.realIncome doubleValue]/self.currentHomeIncomeSlider.value];
    self.currentHomeIncomeSlider.value=1;
    self.nominalInterestRateButton.backgroundColor=[UIColor clearColor];
    [self updateCountryLabels];
}

- (IBAction)resetForeighnMoneySupply:(UIButton *)sender {
    self.foreighnCountry.moneySupply=[NSNumber numberWithDouble:[self.foreighnCountry.moneySupply doubleValue]/self.currentForeighnMoneySupplySlider.value];
    self.currentForeighnMoneySupplySlider.value=1;
    [self updateCountryLabels];
}

- (IBAction)resetForeighnRealIncome:(UIButton *)sender {
    self.foreighnCountry.realIncome=[NSNumber numberWithDouble:[self.foreighnCountry.realIncome doubleValue]/self.currentForeighnIncomeSlider.value];
    self.currentForeighnIncomeSlider.value=1;
    [self updateCountryLabels];
}

- (IBAction)changeHomeMoneySupply:(UISlider *)sender {
    if (sender.value<0.1) {
        sender.value=0.1;
    }
    if (sender.value>1.9) {
        sender.value=1.9;
    }
    self.homeCountry.moneySupply=[NSNumber numberWithDouble:[self.homeCountry.moneySupply doubleValue]/tempHMS];
    self.homeCountry.moneySupply=[NSNumber numberWithDouble:[self.homeCountry.moneySupply doubleValue]*sender.value];
    tempHMS=sender.value;
    [self updateCountryLabels];
}

- (IBAction)changeHomeRealIncome:(UISlider *)sender {
    if (sender.value<0.1) {
        sender.value=0.1;
    }
    if (sender.value>1.9) {
        sender.value=1.9;
    }
    self.homeCountry.realIncome=[NSNumber numberWithDouble:[self.homeCountry.realIncome doubleValue]/tempHRI];
    self.homeCountry.realIncome=[NSNumber numberWithDouble:[self.homeCountry.moneySupply doubleValue]*sender.value];
    tempHRI=sender.value;
    [self updateCountryLabels];
}

- (IBAction)changeForeighnMoneySupply:(UISlider *)sender {
    if (sender.value<0.1) {
        sender.value=0.1;
    }
    if (sender.value>1.9) {
        sender.value=1.9;
    }
    self.foreighnCountry.moneySupply=[NSNumber numberWithDouble:[self.foreighnCountry.moneySupply doubleValue]/tempFMS];
    self.foreighnCountry.moneySupply=[NSNumber numberWithDouble:[self.foreighnCountry.moneySupply doubleValue]*sender.value];
    tempFMS=sender.value;
    [self updateCountryLabels];
}

- (IBAction)changeForeighnRealIncome:(UISlider *)sender {
    if (sender.value<0.1) {
        sender.value=0.1;
    }
    if (sender.value>1.9) {
        sender.value=1.9;
    }
    self.foreighnCountry.realIncome=[NSNumber numberWithDouble:[self.foreighnCountry.realIncome doubleValue]/tempFRI];
    self.foreighnCountry.realIncome=[NSNumber numberWithDouble:[self.foreighnCountry.realIncome doubleValue]*sender.value];
    tempFRI=sender.value;
    [self updateCountryLabels];
}

- (IBAction)resetFutureMoneySupply:(UIButton *)sender {
    self.homeCountryFuture.moneySupply=[NSNumber numberWithDouble:[self.homeCountryFuture.moneySupply doubleValue]/self.FutureHomeMoneySupplySlider.value];
    self.FutureHomeMoneySupplySlider.value=1;
    [self updateCountryLabels];
}

- (IBAction)resetFutureRealIncome:(UIButton *)sender {
    self.homeCountryFuture.realIncome=[NSNumber numberWithDouble:[self.homeCountryFuture.realIncome doubleValue]/self.FutureHomeIncomeSlider.value];
    self.FutureHomeIncomeSlider.value=1;
    [self updateCountryLabels];
}

- (IBAction)resetFutureForeighnMoneySupply:(UIButton *)sender {
    self.foreighnCountryFuture.moneySupply=[NSNumber numberWithDouble:[self.foreighnCountryFuture.moneySupply doubleValue]/self.FutureForeighnMoneySupplySlider.value];
    self.FutureForeighnMoneySupplySlider.value=1;
    [self updateCountryLabels];
}

- (IBAction)resetFutureForeighnRealIncome:(UIButton *)sender {
    self.foreighnCountryFuture.realIncome=[NSNumber numberWithDouble:[self.foreighnCountryFuture.realIncome doubleValue]/self.FutureForeighnIncomeSlider.value];
    self.FutureForeighnIncomeSlider.value=1;
    [self updateCountryLabels];
}

- (IBAction)changeFutureHomeMoneySupply:(UISlider *)sender {
    if (sender.value<0.1) {
        sender.value=0.1;
    }
    if (sender.value>1.9) {
        sender.value=1.9;
    }
    self.homeCountryFuture.moneySupply=[NSNumber numberWithDouble:[self.homeCountryFuture.moneySupply doubleValue]/tempFHMS];
    self.homeCountryFuture.moneySupply=[NSNumber numberWithDouble:[self.homeCountryFuture.moneySupply doubleValue]*sender.value];
    tempFHMS=sender.value;
    [self updateCountryLabels];
}

- (IBAction)changeFutureHomeRealIncome:(UISlider *)sender {
    if (sender.value<0.1) {
        sender.value=0.1;
    }
    if (sender.value>1.9) {
        sender.value=1.9;
    }
    self.homeCountryFuture.realIncome=[NSNumber numberWithDouble:[self.homeCountryFuture.realIncome doubleValue]/tempFHRI];
    self.homeCountryFuture.realIncome=[NSNumber numberWithDouble:[self.homeCountryFuture.moneySupply doubleValue]*sender.value];
    tempFHRI=sender.value;
    [self updateCountryLabels];
}

- (IBAction)changeFutureForeighnMoneySupply:(UISlider *)sender {
    if (sender.value<0.1) {
        sender.value=0.1;
    }
    if (sender.value>1.9) {
        sender.value=1.9;
    }
    self.foreighnCountryFuture.moneySupply=[NSNumber numberWithDouble:[self.foreighnCountryFuture.moneySupply doubleValue]/tempFFMS];
    self.foreighnCountryFuture.moneySupply=[NSNumber numberWithDouble:[self.foreighnCountryFuture.moneySupply doubleValue]*sender.value];
    tempFFMS=sender.value;
    [self updateCountryLabels];
}

- (IBAction)changeFutureForeighnRealIncome:(UISlider *)sender {
    if (sender.value<0.1) {
        sender.value=0.1;
    }
    if (sender.value>1.9) {
        sender.value=1.9;
    }
    self.foreighnCountryFuture.realIncome=[NSNumber numberWithDouble:[self.foreighnCountryFuture.realIncome doubleValue]/tempFFRI];
    self.foreighnCountryFuture.realIncome=[NSNumber numberWithDouble:[self.foreighnCountryFuture.realIncome doubleValue]*sender.value];
    tempFFRI=sender.value;
    [self updateCountryLabels];
}

-(void)setNominalInterestRate:(econcountry *) aCountry
{
    NSLog(@"sending: %@", aCountry.nominalIncome);
    aCountry.nominalInterestRate=[NSNumber numberWithFloat:[econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[aCountry.moneySupply floatValue] nominalIncome:[aCountry.nominalIncome floatValue]]];
}



-(void)updateCountryLabels
{
    
    homeCurrnetMoneySupplyLabel.text=[NSString stringWithFormat:@"%.02f",[self.homeCountry.moneySupply floatValue]];
    foreignCurrentMoneySupplyLabel.text=[NSString stringWithFormat:@"%.02f",[self.foreighnCountry.moneySupply floatValue]];
    HomeFutureMoneySupplyLabel.text=[NSString stringWithFormat:@"%.02f",[self.homeCountryFuture.moneySupply floatValue]];
    foreignFutureMoneySupplyLabel.text=[NSString stringWithFormat:@"%.02f", [self.foreighnCountryFuture.moneySupply floatValue]];
    homeCurrentRealIncomeLabel.text=[NSString stringWithFormat:@"%.02f", [self.homeCountry.realIncome floatValue]];
    foreignCurrentRealIncomeLabel.text=[NSString stringWithFormat:@"%.02f",[self.foreighnCountry.realIncome floatValue]];
    homeFutureRealIncomeLabel.text=[NSString stringWithFormat:@"%.02f", [self.homeCountryFuture.realIncome floatValue]];
    foreignFutureRealIncomeLabel.text=[NSString stringWithFormat:@"%.02f", [self.foreighnCountryFuture.realIncome floatValue]];
    
    
    
    homeNominalInterestRateLabel.text=[self.homeCountry.nominalInterestRate stringValue];
    
    foreignNominalInterestRate.text=[self.foreighnCountry.nominalInterestRate stringValue];
    
    homePriceLevel.text=[self.homeCountryFuture.priceLevel stringValue];
    
    foreignPriceLevelLabel.text=[self.foreighnCountryFuture.priceLevel stringValue];
    
    exchangeRateLabel.text=[NSString stringWithFormat:@"%f", self.currentExchangeRate];
    
    expectedFutureExchangeRateLabel.text=[NSString stringWithFormat:@"%f", self.expectedFutureExchangeRate];
    
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}

@end
