//
//  NominalInterestRate.h
//  Kai
//
//  Created by Daniel Bell on 2014-04-06.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CountryName;

@interface NominalInterestRate : NSManagedObject

@property (nonatomic, retain) NSNumber * current;
@property (nonatomic, retain) NSDate * currentYear;
@property (nonatomic, retain) CountryName *countryForNominalInterest;

@end
