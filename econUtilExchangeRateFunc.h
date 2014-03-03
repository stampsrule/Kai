//
//  econUtilFunc.h
//  Kai
//
//  Created by Daniel Bell on 2/11/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

@import Foundation;

@interface econUtilExchangeRateFunc : NSObject

+ (float) inverseExchange: (float) exchange;
+ (float) directFromCrossExchange: (float) country1Country2 exchange2:(float) country3Country2;
+ (float) coveredInterestParityFromInterest:(float) foreignInterest forward:(float) forward currentExchange:(float)exchange;
+(float) forwardRateFromExchange: (float) exchange homeInterest: (float) homeInterest foreignInterest:(float) foreignInterest;
+ (float) uncoveredInterestParityFromInterest:(float) foreignInterest expectedExchange:(float) expected currentExchange:(float)exchange;
+ (float) spotExchangeRate: (float) expectedExchange homeInterest: (float) homeInterest foreignInterest:(float) foreignInterest;
+ (float) ExchangeByPricesHome: (float) homePrice foreignPrice: (float) foreignPrice;


//page 69 has relative PPP (rate of depreciation of the nominal exchange rate)

@end
