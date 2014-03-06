//
//  econcountry.m
//  Kai
//
//  Created by Daniel Bell on 2/10/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "econcountry.h"

@interface econcountry()

@end
@implementation econcountry

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
    }
    //if country has no name, or default unassigned name allows for a name to be assigned
    //if country has a name it's name cannot change
}



@end