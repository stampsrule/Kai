//
//  econUtilMonetaryTheoryFunc.m
//  Kai
//
//  Created by Daniel Bell on 2/11/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "econUtilMonetaryTheoryFunc.h"
@interface econUtilMonetaryTheoryFunc()
@end

@implementation econUtilMonetaryTheoryFunc

+ (float) inflationFromMoneySupply: (float) moneyGrowth income: (float) incomeGrowth
{
    return moneyGrowth-incomeGrowth;

}

+ (float) moneyDemandFromLiquidity: (float) interstRate nominalIncome: (float) nominalIncome
{
    float moneyDemand=0;
    float liquidity=0;
    float GNP=0;
    //M=L(i)*PY
    //L(i) is a decreasing funcion
    
    //
    //M=48.693+0.475GNP - 16.63R
    //a log version, larger r^2 value, smaller standard deviation
    //  lnM = 0.322+1.056lnGNP - 0.309lnR
    liquidity=0.309*log(interstRate);
    GNP=1.056*log(nominalIncome);
    moneyDemand=0.322+liquidity+GNP;
    moneyDemand=exp(moneyDemand);
    
    return moneyDemand;
    
}

+ (float) nominalInterestRateFromMoneyDemand: (float) moneyDemand nominalIncome: (float) nominalIncome
{
    float nominalInterestRate=0;
    float GNP=0;

    //R=1.978+0.018GNP - 0.033M
    //  lnR=1.320+2.092lnGNP - 1.59lnM
    
    moneyDemand=1.59*log(moneyDemand);
    GNP=2.092*log(nominalIncome);
    nominalInterestRate=1.320+GNP-moneyDemand;
    nominalInterestRate=exp(nominalInterestRate);

    return nominalInterestRate;
}

@end















