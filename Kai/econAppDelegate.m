//
//  econAppDelegate.m
//  Kai
//
//  Created by Daniel Bell on 2/6/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "econAppDelegate.h"
#import "CountryName.h"
#import "NominalGDPData.h"
#import "RealGDPData.h"
#import "M1Data.h"
#import "M2Data.h"
#import "nominalInterestRate.h"

@interface econAppDelegate()
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end


@implementation econAppDelegate

@synthesize managedObjectContext;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
        
    NSData* countryData = [NSData dataWithContentsOfURL:
                           [NSURL URLWithString:@"http://api.worldbank.org/country?per_page=256&format=json"]];
    NSData* nominalGDPData = [NSData dataWithContentsOfURL:
                              [NSURL URLWithString:@"http://api.worldbank.org/countries/ALL/indicators/NY.GDP.MKTP.CN?format=json&date=2012&per_page=252"]];
    NSData* realGDPData = [NSData dataWithContentsOfURL:
                           [NSURL URLWithString:@"http://api.worldbank.org/countries/ALL/indicators/NY.GDP.MKTP.KN?format=json&date=2012&per_page=252"]];
    NSData* m1Data = [NSData dataWithContentsOfURL:
                      [NSURL URLWithString:@"http://api.worldbank.org/countries/ALL/indicators/FM.LBL.MONY.CN?format=json&date=2012&per_page=252"]];
    NSData* m2Data = [NSData dataWithContentsOfURL:
                      [NSURL URLWithString:@"http://api.worldbank.org/countries/ALL/indicators/FM.LBL.MQMY.CN?format=json&date=2012&per_page=252"]];
    NSData* nominalInterestRateData = [NSData dataWithContentsOfURL:
                                       [NSURL URLWithString:@"http://api.worldbank.org/countries/ALL/indicators/FR.INR.LEND?format=json&date=2012&per_page=252"]];
    
    NSMutableArray* countryJson = nil;
    if (countryData) {
        countryJson = [NSJSONSerialization
                       JSONObjectWithData:countryData
                       options:NSJSONReadingMutableContainers
                       error:nil];
    }
    
    NSArray* nominalGDPJson = nil;
    if (nominalGDPData) {
        nominalGDPJson = [NSJSONSerialization
                          JSONObjectWithData:nominalGDPData
                          options:kNilOptions
                          error:nil];
    }
    
    NSArray* realGDPJson = nil;
    if (realGDPData) {
        realGDPJson = [NSJSONSerialization
                       JSONObjectWithData:realGDPData
                       options:kNilOptions
                       error:nil];
    }
    
    NSArray* m1Json = nil;
    if (m1Data) {
        m1Json = [NSJSONSerialization
                  JSONObjectWithData:m1Data
                  options:kNilOptions
                  error:nil];
    }
    
    NSArray* m2Json = nil;
    if (m2Data) {
        m2Json = [NSJSONSerialization
                  JSONObjectWithData:m2Data
                  options:kNilOptions
                  error:nil];
    }

    
    NSArray* nominalInterestRateJson = nil;
    if (nominalInterestRateData) {
        nominalInterestRateJson = [NSJSONSerialization
                  JSONObjectWithData:nominalInterestRateData
                  options:kNilOptions
                  error:nil];
    }

    for (NSDictionary* country in countryJson[1]) {
        NSString* nominalGDPValue;
        NSString* nominalInterestRateValue;
        NSString* realGDPValue;
        NSString* m1Value;
        NSString* m2Value;
        NSString* nominalGDPYear;
        NSString* realGDPYear;
        NSString* m1Year;
        NSString* m2Year;
        NSString* nominalInterestRateYear;
        
        NSString *countryKey = [country objectForKey:@"iso2Code"];
        NSString *countryName = [country objectForKey:@"name"];
        
        
        //nominal GDP
        for (NSDictionary* nomGDPDataCapsul in ((NSArray *)nominalGDPJson[1])) {
            NSDictionary* countryIdentificationDictionary=[[NSDictionary alloc] initWithDictionary:[nomGDPDataCapsul objectForKey:@"country"]];
            if ([[countryIdentificationDictionary objectForKey:@"id"] isEqualToString:countryKey]) {
                nominalGDPValue=[nomGDPDataCapsul objectForKey:@"value"];
                nominalGDPYear=[nomGDPDataCapsul objectForKey:@"date"];
            }
        }
        
        if (nominalGDPValue==nil || [nominalGDPValue isEqual:[NSNull null]] || [nominalGDPValue isKindOfClass:[NSNull class]]) {
            nominalGDPValue=@"delete";
        }
        
        //real GDP
        for (NSDictionary* realGDPDataCapsul in ((NSArray *)realGDPJson[1])) {
            NSDictionary* countryIdentificationDictionary=[[NSDictionary alloc] initWithDictionary:[realGDPDataCapsul objectForKey:@"country"]];
            if ([[countryIdentificationDictionary objectForKey:@"id"] isEqualToString:countryKey]) {
                realGDPValue=[realGDPDataCapsul objectForKey:@"value"];
                realGDPYear=[realGDPDataCapsul objectForKey:@"date"];
            }
        }
        
        if (realGDPValue==nil || [realGDPValue isEqual:[NSNull null]] || [realGDPValue isKindOfClass:[NSNull class]]) {
            realGDPValue=@"delete";
        }
        
        //m1
        for (NSDictionary* m1DataCapsul in ((NSArray *)m1Json[1])) {
            NSDictionary* countryIdentificationDictionary=[[NSDictionary alloc] initWithDictionary:[m1DataCapsul objectForKey:@"country"]];
            if ([[countryIdentificationDictionary objectForKey:@"id"] isEqualToString:countryKey]) {
                m1Value=[m1DataCapsul objectForKey:@"value"];
                m2Year=[m1DataCapsul objectForKey:@"date"];
            }
        }
        
        if (m1Value==nil || [m1Value isEqual:[NSNull null]] || [m1Value isKindOfClass:[NSNull class]]) {
            m1Value=@"delete";
        }
        
        //m2
        for (NSDictionary* m2DataCapsul in ((NSArray *)m2Json[1])) {
            NSDictionary* countryIdentificationDictionary=[[NSDictionary alloc] initWithDictionary:[m2DataCapsul objectForKey:@"country"]];
            if ([[countryIdentificationDictionary objectForKey:@"id"] isEqualToString:countryKey]) {
                m2Value=[m2DataCapsul objectForKey:@"value"];
                m2Year=[m2DataCapsul objectForKey:@"date"];
            }
        }
        
        if (m2Value==nil || [m2Value isEqual:[NSNull null]] || [m2Value isKindOfClass:[NSNull class]]) {
            m2Value=@"delete";
        }
        
        //nominal interest rate
        for (NSDictionary* nominterrateCapsul in ((NSArray *)nominalInterestRateJson[1])) {
            NSDictionary* countryIdentificationDictionary=[[NSDictionary alloc] initWithDictionary:[nominterrateCapsul objectForKey:@"country"]];
            if ([[countryIdentificationDictionary objectForKey:@"id"] isEqualToString:countryKey]) {
                nominalInterestRateValue=[nominterrateCapsul objectForKey:@"value"];
                nominalInterestRateYear=[nominterrateCapsul objectForKey:@"date"];
            }
        }
        
        if (nominalInterestRateValue==nil || [nominalInterestRateValue isEqual:[NSNull null]] || [nominalInterestRateValue isKindOfClass:[NSNull class]]) {
            m2Value=@"delete";
        }
        
        
        
        if (
            ![realGDPValue isEqualToString:@"delete"] &&
            ![nominalGDPValue isEqualToString:@"delete"] &&
            ![m1Value isEqualToString:@"delete"] &&
            ![m2Value isEqualToString:@"delete"] &&
            ![nominalInterestRateValue isEqualToString:@"delete"]
            )
        {
            econAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
            self.managedObjectContext = appDelegate.managedObjectContext;
            
            CountryName *countryNameInfo = [NSEntityDescription insertNewObjectForEntityForName:@"CountryName" inManagedObjectContext:managedObjectContext];
            countryNameInfo.name = countryName;
            countryNameInfo.iso2code=countryKey;
            countryNameInfo.lastChange=[NSDate date];
            
            NSString *dateStr = @"01-01-";
            NSNumber *yearValue;
            NSDateFormatter *editDate =   [[NSDateFormatter alloc] init];
            [editDate setDateFormat:@"MM-dd-yyy"];
            
            
            NominalGDPData *NominalGDPInfo = [NSEntityDescription insertNewObjectForEntityForName:@"NominalGDPData" inManagedObjectContext:managedObjectContext];
            NominalGDPInfo.current = [NSNumber numberWithLongLong:[nominalGDPValue longLongValue]];
            yearValue = [NSNumber numberWithInt:[nominalGDPYear intValue]];
            dateStr=[dateStr stringByAppendingString:[yearValue stringValue]];
            NominalGDPInfo.currentYear=[editDate dateFromString:dateStr];
            
            
            RealGDPData *realGDPInfo = [NSEntityDescription insertNewObjectForEntityForName:@"RealGDPData" inManagedObjectContext:managedObjectContext];
            realGDPInfo.current = [NSNumber numberWithLongLong:[realGDPValue longLongValue]];
            yearValue = [NSNumber numberWithInt:[realGDPYear intValue]];
            dateStr=[dateStr stringByAppendingString:[yearValue stringValue]];
            realGDPInfo.currentYear=[editDate dateFromString:dateStr];

            
            M1Data *m1Info = [NSEntityDescription insertNewObjectForEntityForName:@"M1Data" inManagedObjectContext:managedObjectContext];
            m1Info.current = [NSNumber numberWithLongLong:[m1Value longLongValue]];
            yearValue = [NSNumber numberWithInt:[m1Year intValue]];
            dateStr=[dateStr stringByAppendingString:[yearValue stringValue]];
            m1Info.currentYear=[editDate dateFromString:dateStr];
            
            
            M2Data *m2Info = [NSEntityDescription insertNewObjectForEntityForName:@"M2Data" inManagedObjectContext:managedObjectContext];
            m2Info.current = [NSNumber numberWithLongLong:[m2Value longLongValue]];
            yearValue = [NSNumber numberWithInt:[m2Year intValue]];
            dateStr=[dateStr stringByAppendingString:[yearValue stringValue]];
            m2Info.currentYear=[editDate dateFromString:dateStr];

            NominalInterestRate *nominalInterestInfo = [NSEntityDescription insertNewObjectForEntityForName:@"NominalInterestRate" inManagedObjectContext:managedObjectContext];
            nominalInterestInfo.current = [NSNumber numberWithLongLong:[nominalInterestRateValue longLongValue]];
            yearValue = [NSNumber numberWithInt:[nominalInterestRateYear intValue]];
            dateStr=[dateStr stringByAppendingString:[yearValue stringValue]];
            nominalInterestInfo.currentYear=[editDate dateFromString:dateStr];

            
            
            
            
            m2Info.countryForM2=countryNameInfo;
            m1Info.countryForM1=countryNameInfo;
            realGDPInfo.countryForRealGDP=countryNameInfo;
            NominalGDPInfo.countryForNominalGDP=countryNameInfo;
            nominalInterestInfo.countryForNominalInterest=countryNameInfo;
            countryNameInfo.countryM1=m1Info;
            countryNameInfo.countryM2=m2Info;
            countryNameInfo.countryNominalGDP=NominalGDPInfo;
            countryNameInfo.countryRealGDP=realGDPInfo;
            countryNameInfo.countryNominalInterest=nominalInterestInfo;
        }
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(NSArray*)getAllCountryData
{
    // initializing NSFetchRequest
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CountryName"];
    
    NSError* error;
    
    // Set example predicate and sort orderings...
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Query on managedObjectContext With Generated fetchRequest
    NSArray *fetchedCountries = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Returning Fetched Records
    return fetchedCountries;
}


// 1
- (NSManagedObjectContext *) managedObjectContext {
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return managedObjectContext;
}

//2
- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return managedObjectModel;
}

//3
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"CountryData.sqlite"]];
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
        /*Error for store creation should be handled in here*/
    }
    
    return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


@end
