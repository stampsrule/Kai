//
//  econUtilFunc.m
//  Kai
//
//  Created by Daniel Bell on 2/11/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "econUtilExchangeRateFunc.h"

@interface econUtilExchangeRateFunc()
@end

@implementation econUtilExchangeRateFunc

+ (float) inverseExchange: (float) exchange
{
    int inverse = 0;
    if (exchange==0) {
        [NSException raise:@"invalid exchange rate" format:@"exchange rate of 0 is invalid"];
    } else{
        inverse=1/exchange;
    }
    return inverse;
}

+ (float) directFromCrossExchange: (float) country1Country2 exchange2:(float) country3Country2
{
    int crossExchange = 0;
    if (country3Country2==0 || country1Country2==0) {
        [NSException raise:@"invalid exchange rate" format:@"exchange rate of 0 is invalid"];
    } else {
        crossExchange=country1Country2/country3Country2;
    }
    return crossExchange;
}

+ (float) coveredInterestParityFromInterest:(float) foreignInterest forward:(float) forward currentExchange:(float)exchange
{
    float CIP = 0;
    if (exchange==0) {
        [NSException raise:@"invalid exchange rate" format:@"exchange rate of 0 is invalid"];
    }else{
        CIP=(foreignInterest+1)*(forward/exchange);
    }
    
    return CIP;
}
+(float) forwardRateFromExchange: (float) exchange homeInterest: (float) homeInterest foreignInterest:(float) foreignInterest
{
    float forward = 0;
    if (exchange==0) {
        [NSException raise:@"invalid exchange rate" format:@"exchange rate of 0 is invalid"];
    }else{
        forward=exchange*((1+homeInterest)/(1+foreignInterest));
    }
    
    return forward;
}

+ (float) uncoveredInterestParityFromInterest:(float) foreignInterest expectedExchange:(float) expected currentExchange:(float)exchange
{
    float UIP = 0;
    if (exchange==0) {
        [NSException raise:@"invalid exchange rate" format:@"exchange rate of 0 is invalid"];
    }else{
        UIP=(foreignInterest+1)*(expected/exchange);
    }
    
    return UIP;
}

+ (float) spotExchangeRate: (float) expectedExchange homeInterest: (float) homeInterest foreignInterest:(float) foreignInterest
{
    float spotRate = 0;
    if (expectedExchange==0) {
        [NSException raise:@"invalid exchange rate" format:@"exchange rate of 0 is invalid"];
    }else{
        spotRate=expectedExchange*((1+foreignInterest)/(1+homeInterest));
    }
    
    return spotRate;
}

+ (float) ExchangeByPricesHome: (float) homePrice foreignPrice: (float) foreignPrice
{
    
    if (homePrice==0 || foreignPrice==0) {
        [NSException raise:@"invalid prices" format:@"price of 0 is invalid"];
    }else{
        return homePrice/foreignPrice;
    }
    
    return 0;
    
}


@end