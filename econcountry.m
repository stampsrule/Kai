//
//  econcountry.m
//  Kai
//
//  Created by Daniel Bell on 2/10/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "econcountry.h"
#import "econUtilMonetaryTheoryFunc.h"

@interface econcountry()

@end
@implementation econcountry

@synthesize moneySupply;
@synthesize realIncome;
@synthesize nominalIncome;
@synthesize nominalInterestRate;
@synthesize realInterestRate;
@synthesize priceLevel;
@synthesize liquidity;
@synthesize quantityOfMoney;
@synthesize velocity;
@synthesize exports;
@synthesize imports;
@synthesize privateExpenditure;
@synthesize governmentExpenditure;
@synthesize capitalInflow;
@synthesize increaseInForeignExchangeReserves;

- (instancetype) initWithName: (NSString *) name
{
    self=[super init];
    
    self.name=name;
    return self;
    
}


- (void) setName:(NSString *)name
{
    if ([_name length]==0 || [_name isEqualToString:@"foreighn"] || [_name isEqualToString:@"home"]){
        _name=name;
    } else {
        _name=name;
        moneySupply=NULL;
        realIncome=NULL;
        nominalIncome=NULL;
        nominalInterestRate=NULL;
        realInterestRate=NULL;
        priceLevel=NULL;
        liquidity=NULL;
        quantityOfMoney=NULL;
        velocity=NULL;
        exports=NULL;
        imports=NULL;
        privateExpenditure=NULL;
        governmentExpenditure=NULL;
        capitalInflow=NULL;
        increaseInForeignExchangeReserves=NULL;
    }
}



@end