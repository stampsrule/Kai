//
//  M1Data.h
//  Kai
//
//  Created by Daniel Bell on 2014-03-26.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CountryName;

@interface M1Data : NSManagedObject

@property (nonatomic, retain) NSNumber * current;
@property (nonatomic, retain) NSDate * currentYear;
@property (nonatomic, retain) NSNumber * previous;
@property (nonatomic, retain) NSDate * previousYear;
@property (nonatomic, retain) CountryName *countryForM1;

@end
