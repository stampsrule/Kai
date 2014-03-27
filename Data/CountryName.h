//
//  CountryName.h
//  Kai
//
//  Created by Daniel Bell on 2014-03-26.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class M1Data, M2Data, NominalGDPData, RealGDPData;

@interface CountryName : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * iso2code;
@property (nonatomic, retain) NSDate * lastChange;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) M1Data *countryM1;
@property (nonatomic, retain) M2Data *countryM2;
@property (nonatomic, retain) NominalGDPData *countryNominalGDP;
@property (nonatomic, retain) RealGDPData *countryRealGDP;

@end
