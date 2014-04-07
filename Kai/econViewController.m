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
#import "econUtilExchangeRateFunc.h"


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

- (econcountry *) homeCountry {
    if (!_homeCountry) {
        _homeCountry = [[econcountry alloc] initWithName:@"home"];
    }
    return _homeCountry;
}

- (econcountry *) foreighnCountry {
    if (!_foreighnCountry) {
        _foreighnCountry = [[econcountry alloc] initWithName:@"foreign"];
    }
    return _foreighnCountry;
}

- (econcountry *) homeCountryFuture {
    if (!_homeCountryFuture) {
        _homeCountryFuture = [[econcountry alloc] initWithName:@"home"];
    }
    return _homeCountryFuture;
}

- (econcountry *) foreighnCountryFuture {
    if (!_foreighnCountryFuture) {
        _foreighnCountryFuture = [[econcountry alloc] initWithName:@"foreign"];
    }
    return _foreighnCountryFuture;
}

- (void) viewWillAppear:(BOOL)animated {
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

- (void)viewDidLoad {
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
    menuBtn.frame = CGRectMake(8, 30, 34, 24);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    self.expectedFutureExchangeRate=0;
    self.currentExchangeRate=0;
    [self.view addSubview:self.menuBtn];
}

- (IBAction)revealMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void)dismissPopCountry: (NSString *)Country moneySupply: (NSNumber *) moneySupply realincome: (NSNumber *) realIncome
            nominalIncome: (NSNumber *) nominalIncome nominalInterest: (NSNumber *) nominalInterest {
     if ([self.segueName isEqualToString:@"segCountry2Pop"]) {
         self.foreighnCountry.name=Country;
         self.foreighnCountryFuture.name=Country;
         [self.foreignCountryButton setAttributedTitle:[[NSMutableAttributedString alloc] initWithString:self.foreighnCountry.name attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]}] forState:UIControlStateNormal];
         self.foreighnCountry.moneySupply=moneySupply;
         self.foreighnCountry.realIncome=realIncome;
         self.foreighnCountry.nominalIncome=nominalIncome;
         self.foreighnCountry.nominalInterestRate=nominalInterest;
         self.foreighnCountry.priceLevel=[NSNumber numberWithDouble:([nominalIncome doubleValue]/[realIncome doubleValue])];
         self.foreighnCountry.liquidity=[NSNumber numberWithDouble:(([moneySupply doubleValue])/([nominalIncome doubleValue]))];
         self.foreighnCountryFuture.moneySupply=moneySupply;
         self.foreighnCountryFuture.realIncome=realIncome;
         self.foreighnCountryFuture.nominalIncome=nominalIncome;
         self.foreighnCountryFuture.nominalInterestRate=nominalInterest;
         self.foreighnCountryFuture.priceLevel=[NSNumber numberWithDouble:([nominalIncome doubleValue]/[realIncome doubleValue])];
         self.foreighnCountryFuture.liquidity=[NSNumber numberWithDouble:(([moneySupply doubleValue])/([nominalIncome doubleValue]))];
     }
     if ([self.segueName isEqualToString:@"segCountry1Pop"]) {
         self.homeCountry.name=Country;
         self.homeCountryFuture.name=Country;
         [self.homeCountryButton setAttributedTitle:[[NSMutableAttributedString alloc] initWithString:self.homeCountry.name attributes:@{NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]}] forState:UIControlStateNormal];
         self.homeCountry.moneySupply=moneySupply;
         self.homeCountry.realIncome=realIncome;
         self.homeCountry.nominalIncome=nominalIncome;
         self.homeCountry.nominalInterestRate=nominalInterest;
         self.homeCountry.priceLevel=[NSNumber numberWithDouble:([nominalIncome doubleValue]/[realIncome doubleValue])];
         self.homeCountry.liquidity=[NSNumber numberWithDouble:(([moneySupply doubleValue])/([nominalIncome doubleValue]))];
         self.homeCountryFuture.moneySupply=moneySupply;
         self.homeCountryFuture.realIncome=realIncome;
         self.homeCountryFuture.nominalIncome=nominalIncome;
         self.homeCountryFuture.nominalInterestRate=nominalInterest;
         self.homeCountryFuture.priceLevel=[NSNumber numberWithDouble:([nominalIncome doubleValue]/[realIncome doubleValue])];
         self.homeCountryFuture.liquidity=[NSNumber numberWithDouble:(([moneySupply doubleValue])/([nominalIncome doubleValue]))];
     }
     [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss the popover
     
     [self setExpectedFutureExchangeRate];
     [self setCurrentExchangeRate];
     
     self.currentForeighnIncomeSlider.value=1;
     self.currentForeighnMoneySupplySlider.value=1;
     self.currentHomeIncomeSlider.value=1;
     self.currentHomeMoneySupplySlider.value=1;
     
     self.FutureForeighnIncomeSlider.value=1;
     self.FutureForeighnMoneySupplySlider.value=1;
     self.FutureHomeIncomeSlider.value=1;
     self.FutureHomeMoneySupplySlider.value=1;
     
     self.ForeignNominalInterestRateButton.backgroundColor=[UIColor clearColor];
     self.nominalInterestRateButton.backgroundColor=[UIColor clearColor];
     self.HomePriceLevelButton.backgroundColor=[UIColor clearColor];
     self.foreignPriceLevelButton.backgroundColor=[UIColor clearColor];
     self.ExpectedFutureExchangeRateButton.backgroundColor=[UIColor clearColor];
     self.ExchangeRateButton.backgroundColor=[UIColor clearColor];
    
     [self updateCountryLabels];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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
    //old data
    double tempValFromOldData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.homeCountry.moneySupply floatValue] nominalIncome:[self.homeCountry.nominalIncome floatValue]];
    
    //calculations
    self.homeCountry.moneySupply=[NSNumber numberWithDouble:[self.homeCountry.moneySupply doubleValue]/self.currentHomeMoneySupplySlider.value];
    [self setCurrentExchangeRate];
    
    //new data
    double tempValFromNewData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.homeCountry.moneySupply floatValue] nominalIncome:[self.homeCountry.nominalIncome floatValue]];
    double valChange=((tempValFromNewData/tempValFromOldData)-1)*[self.homeCountry.nominalInterestRate doubleValue];
    self.homeCountry.nominalInterestRate=[NSNumber numberWithDouble:([self.homeCountry.nominalInterestRate doubleValue]+valChange)];
    
    //update UI
    self.currentHomeMoneySupplySlider.value=1;
    self.nominalInterestRateButton.backgroundColor=[UIColor clearColor];
    self.ExchangeRateButton.backgroundColor=[UIColor clearColor];
    [self updateCountryLabels];
}

- (IBAction)resetRealIncome:(UIButton *)sender {
    // old data
    double tempValFromOldData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.homeCountry.moneySupply floatValue] nominalIncome:[self.homeCountry.realIncome floatValue]];
    
    //calculations
    self.homeCountry.realIncome=[NSNumber numberWithDouble:[self.homeCountry.realIncome doubleValue]/self.currentHomeIncomeSlider.value];
    [self setCurrentExchangeRate];
    
    // new data
    double tempValFromNewData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.homeCountry.moneySupply floatValue] nominalIncome:[self.homeCountry.realIncome floatValue]];
    double percentChange=(tempValFromNewData/tempValFromOldData)-1;
    double valChange=percentChange*[self.homeCountry.nominalInterestRate doubleValue];
    self.homeCountry.nominalInterestRate=[NSNumber numberWithDouble:([self.homeCountry.nominalInterestRate doubleValue]+valChange)];

    
    //update UI
    self.currentHomeIncomeSlider.value=1;
    self.ExchangeRateButton.backgroundColor=[UIColor clearColor];
    self.nominalInterestRateButton.backgroundColor=[UIColor clearColor];
    [self updateCountryLabels];
}

- (IBAction)resetForeighnMoneySupply:(UIButton *)sender {
    //old data
    double tempValFromOldData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.foreighnCountry.moneySupply floatValue] nominalIncome:[self.foreighnCountry.nominalIncome floatValue]];
    
    //calculations
    self.foreighnCountry.moneySupply=[NSNumber numberWithDouble:[self.foreighnCountry.moneySupply doubleValue]/self.currentForeighnMoneySupplySlider.value];
    [self setCurrentExchangeRate];
    
    //new data
    double tempValFromNewData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.foreighnCountry.moneySupply floatValue] nominalIncome:[self.foreighnCountry.nominalIncome floatValue]];
    double valChange=((tempValFromNewData/tempValFromOldData)-1)*[self.foreighnCountry.nominalInterestRate doubleValue];
    self.foreighnCountry.nominalInterestRate=[NSNumber numberWithDouble:([self.foreighnCountry.nominalInterestRate doubleValue]+valChange)];
    
    //update UI
    self.currentForeighnMoneySupplySlider.value=1;
    self.ForeignNominalInterestRateButton.backgroundColor=[UIColor clearColor];
    self.ExchangeRateButton.backgroundColor=[UIColor clearColor];
    [self updateCountryLabels];
}

- (IBAction)resetForeighnRealIncome:(UIButton *)sender {
    double tempValFromOldData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.foreighnCountry.moneySupply floatValue] nominalIncome:[self.foreighnCountry.realIncome floatValue]];
    self.foreighnCountry.realIncome=[NSNumber numberWithDouble:[self.foreighnCountry.realIncome doubleValue]/self.currentForeighnIncomeSlider.value];
    double tempValFromNewData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.foreighnCountry.moneySupply floatValue] nominalIncome:[self.foreighnCountry.realIncome floatValue]];
    double percentChange=(tempValFromNewData/tempValFromOldData)-1;
    double valChange=percentChange*[self.foreighnCountry.nominalInterestRate doubleValue];
    self.foreighnCountry.nominalInterestRate=[NSNumber numberWithDouble:([self.foreighnCountry.nominalInterestRate doubleValue]+valChange)];
    [self setCurrentExchangeRate];
    
    
    //update UI
    self.currentForeighnIncomeSlider.value=1;
    self.ForeignNominalInterestRateButton.backgroundColor=[UIColor clearColor];
    self.ExchangeRateButton.backgroundColor=[UIColor clearColor];
    [self updateCountryLabels];
}

- (IBAction)changeHomeMoneySupply:(UISlider *)sender {
    if (sender.value<0.1) {
        [sender setValue:0.1 animated:YES];
    }
    if (sender.value>1.9) {
        [sender setValue:1.9 animated:YES];
    }
    
    //old data
    double tempValFromOldData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.homeCountry.moneySupply floatValue] nominalIncome:[self.homeCountry.nominalIncome floatValue]];
    double oldexchange = self.currentExchangeRate;
    
    //calculations
    self.homeCountry.moneySupply=[NSNumber numberWithDouble:[self.homeCountry.moneySupply doubleValue]/tempHMS];
    self.homeCountry.moneySupply=[NSNumber numberWithDouble:[self.homeCountry.moneySupply doubleValue]*sender.value];
    [self setCurrentExchangeRate];
    
    //new data
    tempHMS=sender.value;
    double tempValFromNewData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.homeCountry.moneySupply floatValue] nominalIncome:[self.homeCountry.nominalIncome floatValue]];
    double valChange=((tempValFromNewData/tempValFromOldData)-1)*[self.homeCountry.nominalInterestRate doubleValue];
    self.homeCountry.nominalInterestRate=[NSNumber numberWithDouble:([self.homeCountry.nominalInterestRate doubleValue]+valChange)];
    double newexchange=self.currentExchangeRate;
    
    //update UI
    [self setColorOfbuttonWithOld:oldexchange new:newexchange button:self.ExchangeRateButton];
    
    if (valChange>0) {
        self.nominalInterestRateButton.backgroundColor=[UIColor greenColor];
    } else if (valChange<0){
        self.nominalInterestRateButton.backgroundColor=[UIColor redColor];
    }
    
    [self updateCountryLabels];
}

- (IBAction)changeHomeRealIncome:(UISlider *)sender {
    if (sender.value<0.1) {
        [sender setValue:0.1 animated:YES];
    }
    if (sender.value>1.9) {
        [sender setValue:1.9 animated:YES];
    }
    
    // old data
    double tempValFromOldData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.homeCountry.moneySupply floatValue] nominalIncome:[self.homeCountry.realIncome floatValue]];
    double oldexchange = self.currentExchangeRate;
    
    //calculations
    self.homeCountry.realIncome=[NSNumber numberWithDouble:[self.homeCountry.realIncome doubleValue]/tempHRI];
    self.homeCountry.realIncome=[NSNumber numberWithDouble:[self.homeCountry.realIncome doubleValue]*sender.value];
    [self setCurrentExchangeRate];

    //new data
    tempHRI=sender.value;
    double tempValFromNewData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.homeCountry.moneySupply floatValue] nominalIncome:[self.homeCountry.realIncome floatValue]];
    double valChange=((tempValFromNewData/tempValFromOldData)-1)*[self.homeCountry.nominalInterestRate doubleValue];
    self.homeCountry.nominalInterestRate=[NSNumber numberWithDouble:([self.homeCountry.nominalInterestRate doubleValue]+valChange)];
    double newexchange=self.currentExchangeRate;
    
    //update UI
    [self setColorOfbuttonWithOld:oldexchange new:newexchange button:self.ExchangeRateButton];
    
    if (valChange>0) {
        self.nominalInterestRateButton.backgroundColor=[UIColor greenColor];
    } else if (valChange<0){
        self.nominalInterestRateButton.backgroundColor=[UIColor redColor];
    }
    
    [self updateCountryLabels];
}

- (IBAction)changeForeighnMoneySupply:(UISlider *)sender {
    if (sender.value<0.1) {
        [sender setValue:0.1 animated:YES];
    }
    if (sender.value>1.9) {
        [sender setValue:1.9 animated:YES];
    }
    
    // old data
    double tempValFromOldData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.foreighnCountry.moneySupply floatValue] nominalIncome:[self.foreighnCountry.nominalIncome floatValue]];
    double oldexchange=self.currentExchangeRate;
    
    // calculations
    self.foreighnCountry.moneySupply=[NSNumber numberWithDouble:[self.foreighnCountry.moneySupply doubleValue]/tempFMS];
    self.foreighnCountry.moneySupply=[NSNumber numberWithDouble:[self.foreighnCountry.moneySupply doubleValue]*sender.value];
    [self setCurrentExchangeRate];
    
    
    //new data
    tempFMS=sender.value;
    double tempValFromNewData = [econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.foreighnCountry.moneySupply floatValue] nominalIncome:[self.foreighnCountry.nominalIncome floatValue]];
    double valChange=((tempValFromNewData/tempValFromOldData)-1)*[self.foreighnCountry.nominalInterestRate doubleValue];
    self.foreighnCountry.nominalInterestRate=[NSNumber numberWithDouble:([self.foreighnCountry.nominalInterestRate doubleValue]+valChange)];
    double newexchange = self.currentExchangeRate;
    
    //update UI
    [self setColorOfbuttonWithOld:oldexchange new:newexchange button:self.ExchangeRateButton];
    
    if (valChange>0) {
        self.ForeignNominalInterestRateButton.backgroundColor=[UIColor greenColor];
    } else if (valChange<0){
        self.ForeignNominalInterestRateButton.backgroundColor=[UIColor redColor];
    }
    
    [self updateCountryLabels];
}

- (IBAction)changeForeighnRealIncome:(UISlider *)sender {
    if (sender.value<0.1) {
        [sender setValue:0.1 animated:YES];
    }
    if (sender.value>1.9) {
        [sender setValue:1.9 animated:YES];
    }
    
    //old data
    double tempValFromOldData=[econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.foreighnCountry.moneySupply floatValue] nominalIncome:[self.foreighnCountry.realIncome floatValue]];
    double oldexchange = self.currentExchangeRate;
    
    //calculations
    self.foreighnCountry.realIncome=[NSNumber numberWithDouble:[self.foreighnCountry.realIncome doubleValue]/tempFRI];
    self.foreighnCountry.realIncome=[NSNumber numberWithDouble:[self.foreighnCountry.realIncome doubleValue]*sender.value];
    [self setCurrentExchangeRate];
    
    //new data
    double tempValFromNewData=[econUtilMonetaryTheoryFunc nominalInterestRateFromMoneyDemand:[self.foreighnCountry.moneySupply floatValue] nominalIncome:[self.foreighnCountry.realIncome floatValue]];
    tempFRI=sender.value;
    double valChange=((tempValFromNewData/tempValFromOldData)-1)*[self.foreighnCountry.nominalInterestRate doubleValue];
    self.foreighnCountry.nominalInterestRate=[NSNumber numberWithDouble:([self.foreighnCountry.nominalInterestRate doubleValue]+valChange)];
    double newexchange=self.currentExchangeRate;
    
    //update UI
    [self setColorOfbuttonWithOld:oldexchange new:newexchange button:self.ExchangeRateButton];
    
    if (valChange>0) {
        self.ForeignNominalInterestRateButton.backgroundColor=[UIColor greenColor];
    } else if (valChange<0){
        self.ForeignNominalInterestRateButton.backgroundColor=[UIColor redColor];
    }
    
    [self updateCountryLabels];
}

- (IBAction)resetFutureMoneySupply:(UIButton *)sender {
    self.homeCountryFuture.moneySupply=[NSNumber numberWithDouble:[self.homeCountryFuture.moneySupply doubleValue]/self.FutureHomeMoneySupplySlider.value];
    self.homeCountryFuture.priceLevel =[NSNumber numberWithDouble:(([self.homeCountryFuture.moneySupply doubleValue])/(([self.homeCountryFuture.liquidity doubleValue])*([self.homeCountryFuture.realIncome doubleValue])))];
    [self setExpectedFutureExchangeRate];
    [self setCurrentExchangeRate];
    
    //update UI
    self.FutureHomeMoneySupplySlider.value=1;
    self.HomePriceLevelButton.backgroundColor=[UIColor clearColor];
    self.ExpectedFutureExchangeRateButton.backgroundColor=[UIColor clearColor];
    self.ExchangeRateButton.backgroundColor=[UIColor clearColor];
    [self updateCountryLabels];
}

- (IBAction)resetFutureRealIncome:(UIButton *)sender {
    self.homeCountryFuture.realIncome=[NSNumber numberWithDouble:[self.homeCountryFuture.realIncome doubleValue]/self.FutureHomeIncomeSlider.value];
    self.homeCountryFuture.priceLevel =[NSNumber numberWithDouble:(([self.homeCountryFuture.moneySupply doubleValue])/(([self.homeCountryFuture.liquidity doubleValue])*([self.homeCountryFuture.realIncome doubleValue])))];
    [self setExpectedFutureExchangeRate];
    [self setCurrentExchangeRate];
    
    //update UI
    self.FutureHomeIncomeSlider.value=1;
    self.HomePriceLevelButton.backgroundColor=[UIColor clearColor];
    self.ExchangeRateButton.backgroundColor=[UIColor clearColor];
    self.ExpectedFutureExchangeRateButton.backgroundColor=[UIColor clearColor];
    [self updateCountryLabels];
}

- (IBAction)resetFutureForeighnMoneySupply:(UIButton *)sender {
    self.foreighnCountryFuture.moneySupply=[NSNumber numberWithDouble:[self.foreighnCountryFuture.moneySupply doubleValue]/self.FutureForeighnMoneySupplySlider.value];
    self.foreighnCountryFuture.priceLevel =[NSNumber numberWithDouble:(([self.foreighnCountryFuture.moneySupply doubleValue])/(([self.foreighnCountryFuture.liquidity doubleValue])*([self.foreighnCountryFuture.realIncome doubleValue])))];
    [self setExpectedFutureExchangeRate];
    [self setCurrentExchangeRate];
    
    //update UI
    self.FutureForeighnMoneySupplySlider.value=1;
    self.foreignPriceLevelButton.backgroundColor=[UIColor clearColor];
    self.ExpectedFutureExchangeRateButton.backgroundColor=[UIColor clearColor];
    self.ExchangeRateButton.backgroundColor=[UIColor clearColor];
    [self updateCountryLabels];
}

- (IBAction)resetFutureForeighnRealIncome:(UIButton *)sender {
    self.foreighnCountryFuture.realIncome=[NSNumber numberWithDouble:[self.foreighnCountryFuture.realIncome doubleValue]/self.FutureForeighnIncomeSlider.value];
    self.foreighnCountryFuture.priceLevel =[NSNumber numberWithDouble:(([self.foreighnCountryFuture.moneySupply doubleValue])/(([self.foreighnCountryFuture.liquidity doubleValue])*([self.foreighnCountryFuture.realIncome doubleValue])))];
    [self setExpectedFutureExchangeRate];
    [self setCurrentExchangeRate];
    
    //update UI
    self.FutureForeighnIncomeSlider.value=1;
    self.ExpectedFutureExchangeRateButton.backgroundColor=[UIColor clearColor];
    self.foreignPriceLevelButton.backgroundColor=[UIColor clearColor];
    self.ExchangeRateButton.backgroundColor=[UIColor clearColor];
    [self updateCountryLabels];
}

- (IBAction)changeFutureHomeMoneySupply:(UISlider *)sender {
    if (sender.value<0.1) {
        [sender setValue:0.1 animated:YES];
    }
    if (sender.value>1.9) {
        [sender setValue:1.9 animated:YES];
    }
    //old data
    double oldVal=[self.homeCountryFuture.priceLevel doubleValue];
    double oldexcpected=self.expectedFutureExchangeRate;
    double oldexchange=self.currentExchangeRate;
    
    //calculations
    self.homeCountryFuture.moneySupply=[NSNumber numberWithDouble:[self.homeCountryFuture.moneySupply doubleValue]/tempFHMS];
    self.homeCountryFuture.moneySupply=[NSNumber numberWithDouble:[self.homeCountryFuture.moneySupply doubleValue]*sender.value];
    tempFHMS=sender.value;
    
    self.homeCountryFuture.priceLevel =[NSNumber numberWithDouble:(([self.homeCountryFuture.moneySupply doubleValue])/(([self.homeCountryFuture.liquidity doubleValue])*([self.homeCountryFuture.realIncome doubleValue])))];
    [self setExpectedFutureExchangeRate];
    [self setCurrentExchangeRate];
    
    // new data
    double newVal = [self.homeCountryFuture.priceLevel doubleValue];
    double newexpected=self.expectedFutureExchangeRate;
    double newexchange=self.currentExchangeRate;
    
    //update UI
    [self setColorOfbuttonWithOld:oldVal new:newVal button:self.HomePriceLevelButton];
    [self setColorOfbuttonWithOld:oldexcpected new:newexpected button:self.ExpectedFutureExchangeRateButton];
    [self setColorOfbuttonWithOld:oldexchange new:newexchange button:self.ExchangeRateButton];
    [self updateCountryLabels];
}

- (IBAction)changeFutureHomeRealIncome:(UISlider *)sender {
    if (sender.value<0.1) {
        [sender setValue:0.1 animated:YES];
    }
    if (sender.value>1.9) {
        [sender setValue:1.9 animated:YES];
    }
    //old data
    double oldVal=[self.homeCountryFuture.priceLevel doubleValue];
    double oldexcpected=self.expectedFutureExchangeRate;
    double oldexchange=self.currentExchangeRate;
    
    //calculations
    self.homeCountryFuture.realIncome=[NSNumber numberWithDouble:[self.homeCountryFuture.realIncome doubleValue]/tempFHRI];
    self.homeCountryFuture.realIncome=[NSNumber numberWithDouble:[self.homeCountryFuture.moneySupply doubleValue]*sender.value];
    tempFHRI=sender.value;
    self.homeCountryFuture.priceLevel =[NSNumber numberWithDouble:(([self.homeCountryFuture.moneySupply doubleValue])/(([self.homeCountryFuture.liquidity doubleValue])*([self.homeCountryFuture.realIncome doubleValue])))];
    [self setExpectedFutureExchangeRate];
    [self setCurrentExchangeRate];
    
    //new data
    double newVal = [self.homeCountryFuture.priceLevel doubleValue];
    double newexpected=self.expectedFutureExchangeRate;
    double newexchange=self.currentExchangeRate;
    
    //update UI
    [self setColorOfbuttonWithOld:oldVal new:newVal button:self.HomePriceLevelButton];
    [self setColorOfbuttonWithOld:oldexcpected new:newexpected button:self.ExpectedFutureExchangeRateButton];
    [self setColorOfbuttonWithOld:oldexchange new:newexchange button:self.ExchangeRateButton];
    [self updateCountryLabels];
}

- (IBAction)changeFutureForeighnMoneySupply:(UISlider *)sender {
    if (sender.value<0.1) {
        [sender setValue:0.1 animated:YES];
    }
    if (sender.value>1.9) {
        [sender setValue:1.9 animated:YES];
    }
    //old data
    double oldVal=[self.foreighnCountryFuture.priceLevel doubleValue];
    double oldexcpected=self.expectedFutureExchangeRate;
    double oldexchange=self.currentExchangeRate;
    
    //calculations
    self.foreighnCountryFuture.moneySupply=[NSNumber numberWithDouble:[self.foreighnCountryFuture.moneySupply doubleValue]/tempFFMS];
    self.foreighnCountryFuture.moneySupply=[NSNumber numberWithDouble:[self.foreighnCountryFuture.moneySupply doubleValue]*sender.value];
    tempFFMS=sender.value;
    
    self.foreighnCountryFuture.priceLevel =[NSNumber numberWithDouble:(([self.foreighnCountryFuture.moneySupply doubleValue])/(([self.foreighnCountryFuture.liquidity doubleValue])*([self.foreighnCountryFuture.realIncome doubleValue])))];
    [self setExpectedFutureExchangeRate];
    [self setCurrentExchangeRate];
    
    //new data
    double newVal=[self.foreighnCountryFuture.priceLevel doubleValue];
    double newexpected=self.expectedFutureExchangeRate;
    double newexchange=self.currentExchangeRate;
    
    //update UI
    [self setColorOfbuttonWithOld:oldVal new:newVal button:self.foreignPriceLevelButton];
    [self setColorOfbuttonWithOld:oldexcpected new:newexpected button:self.ExpectedFutureExchangeRateButton];
    [self setColorOfbuttonWithOld:oldexchange new:newexchange button:self.ExchangeRateButton];
    [self updateCountryLabels];
}

- (IBAction)changeFutureForeighnRealIncome:(UISlider *)sender {
    if (sender.value<0.1) {
        [sender setValue:0.1 animated:YES];
    }
    if (sender.value>1.9) {
        [sender setValue:1.9 animated:YES];
    }
    //old values
    double oldVal=[self.foreighnCountryFuture.priceLevel doubleValue];
    double oldexcpected=self.expectedFutureExchangeRate;
    double oldexchange=self.currentExchangeRate;

    //calculations
    self.foreighnCountryFuture.realIncome=[NSNumber numberWithDouble:[self.foreighnCountryFuture.realIncome doubleValue]/tempFFRI];
    self.foreighnCountryFuture.realIncome=[NSNumber numberWithDouble:[self.foreighnCountryFuture.realIncome doubleValue]*sender.value];
    tempFFRI=sender.value;
    self.foreighnCountryFuture.priceLevel =[NSNumber numberWithDouble:(([self.foreighnCountryFuture.moneySupply doubleValue])/(([self.foreighnCountryFuture.liquidity doubleValue])*([self.foreighnCountryFuture.realIncome doubleValue])))];
    [self setExpectedFutureExchangeRate];
    [self setCurrentExchangeRate];
    
    //new values
    double newexpected=self.expectedFutureExchangeRate;
    double newVal=[self.foreighnCountryFuture.priceLevel doubleValue];
    double newExchange=self.currentExchangeRate;
    

    // update UI
    [self setColorOfbuttonWithOld:oldVal new:newVal button:self.foreignPriceLevelButton];
    [self setColorOfbuttonWithOld:oldexcpected new:newexpected button:self.ExpectedFutureExchangeRateButton];
    [self setColorOfbuttonWithOld:oldexchange new:newExchange button:self.ExchangeRateButton];
    [self updateCountryLabels];
}

- (void)setColorOfbuttonWithOld: (double) old new: (double) new button: (UIButton *) button {
    if (old<new) {
        button.backgroundColor=[UIColor greenColor];
    } else if(old>new){
        button.backgroundColor=[UIColor redColor];
    }
}

- (void)setExpectedFutureExchangeRate {
    self.expectedFutureExchangeRate=[self.homeCountryFuture.priceLevel doubleValue]/[self.foreighnCountryFuture.priceLevel doubleValue];
}

- (void)setCurrentExchangeRate {
    if (
        self.expectedFutureExchangeRate!=0 &&
        [self.homeCountry.nominalInterestRate doubleValue]!=0 &&
        [self.foreighnCountry.nominalInterestRate doubleValue]!=0
        ) {
        self.currentExchangeRate=[econUtilExchangeRateFunc spotExchangeRate:self.expectedFutureExchangeRate
                                                               homeInterest:[self.homeCountry.nominalInterestRate doubleValue]
                                                            foreignInterest:[self.foreighnCountry.nominalInterestRate doubleValue]];
    }
    
}

- (void)updateCountryLabels {
    
    homeCurrnetMoneySupplyLabel.text=[NSString stringWithFormat:@"%.02f",[self.homeCountry.moneySupply floatValue]];
    foreignCurrentMoneySupplyLabel.text=[NSString stringWithFormat:@"%.02f",[self.foreighnCountry.moneySupply floatValue]];
    HomeFutureMoneySupplyLabel.text=[NSString stringWithFormat:@"%.02f",[self.homeCountryFuture.moneySupply floatValue]];
    foreignFutureMoneySupplyLabel.text=[NSString stringWithFormat:@"%.02f", [self.foreighnCountryFuture.moneySupply floatValue]];
    homeCurrentRealIncomeLabel.text=[NSString stringWithFormat:@"%.02f", [self.homeCountry.realIncome floatValue]];
    foreignCurrentRealIncomeLabel.text=[NSString stringWithFormat:@"%.02f",[self.foreighnCountry.realIncome floatValue]];
    
    
    homeFutureRealIncomeLabel.text=[NSString stringWithFormat:@"%.02f", [self.homeCountryFuture.realIncome floatValue]];
    foreignFutureRealIncomeLabel.text=[NSString stringWithFormat:@"%.02f", [self.foreighnCountryFuture.realIncome floatValue]];
    homeNominalInterestRateLabel.text=[NSString stringWithFormat:@"%.02f", [self.homeCountry.nominalInterestRate floatValue]];
    foreignNominalInterestRate.text=[NSString stringWithFormat:@"%.02f", [self.foreighnCountry.nominalInterestRate floatValue]];
    homePriceLevel.text=[NSString stringWithFormat:@"%.02f", [self.homeCountryFuture.priceLevel floatValue]];
    foreignPriceLevelLabel.text=[NSString stringWithFormat:@"%.02f", [self.foreighnCountryFuture.priceLevel floatValue]];
    exchangeRateLabel.text=[NSString stringWithFormat:@"%.02f", self.currentExchangeRate];
    expectedFutureExchangeRateLabel.text=[NSString stringWithFormat:@"%.02f", self.expectedFutureExchangeRate];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return NO;
}

@end
