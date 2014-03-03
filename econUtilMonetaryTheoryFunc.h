//
//  econUtilMonetaryTheoryFunc.h
//  Kai
//
//  Created by Daniel Bell on 2/11/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

@import Foundation;
#import "econMacroModel.h"
@interface econUtilMonetaryTheoryFunc : econMacroModel


+ (float) inflationFromMoneySupply: (float) moneyGrowth income: (float) incomeGrowth;
+ (float) moneyDemandFromLiquidity: (float) interstRate nominalIncome: (float) nominalIncome;
//M=L(i)*PY
//L(i) is a decreasing funcion
//M=48.693+0.475GNP - 16.63R
//  lnM = 0.322+1.056lnGNP - 0.309lnR


+ (float) nominalInterestRateFromMoneyDemand: (float) moneyDemand nominalIncome: (float) nominalIncome;
//R=1.978+0.018GNP - 0.033M
//  lnR=1.320+2.092lnGNP - 1.59lnM




//R=0.723+0.0061GNP+0.0015(C+DD)
//  lnR=-0.599+1.092lnGNP - 0.810ln(C+DD)

//C+DD=90.80+0.102GNP + 0.121R
//  ln(C+DD)=1.145+0.385lnGNP - 0.048lnR


//R = Yields on AAA corporate bonds
//GNP = GNP, seasonally adjusted (in $billions)
//M = C+DD plus time deposits
//AKA M2
//C+DD = currency in circulation plus demand deposits, seasonally adjusted, (in $billions)
//AKA M1



//424-27
//438-42
//443-46
@end
