//
//  econcountry.h
//  Kai
//
//  Created by Daniel Bell on 2/10/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

@import Foundation;
#import "econMacroModel.h"
@interface econcountry : econMacroModel

- (instancetype) initWithName: (NSString *) name;


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *moneySupply;
@property (strong, nonatomic) NSNumber *realIncome;
@property (strong, nonatomic) NSNumber *nominalIncome;
@property (strong, nonatomic) NSNumber *nominalInterestRate;
@property (strong, nonatomic) NSNumber *realInterestRate;
@property (strong, nonatomic) NSNumber *priceLevel;
@property (strong, nonatomic) NSNumber *liquidity;
@property (strong, nonatomic) NSNumber *quantityOfMoney;
@property (strong, nonatomic) NSNumber *velocity;
@property (strong, nonatomic) NSNumber *exports;
@property (strong, nonatomic) NSNumber *imports;
@property (strong, nonatomic) NSNumber *privateExpenditure;
@property (strong, nonatomic) NSNumber *governmentExpenditure;
@property (strong, nonatomic) NSNumber *capitalInflow;
@property (strong, nonatomic) NSNumber *increaseInForeignExchangeReserves;


//M = C+DD plus time deposits
//C+DD = currency in circulation plus demand deposits, seasonally adjusted, (in $billions)


@end
