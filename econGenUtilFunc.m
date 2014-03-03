//
//  econGenUtilFunc.m
//  Kai
//
//  Created by Daniel Bell on 2/17/2014.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "econGenUtilFunc.h"

@implementation econGenUtilFunc

+ (float)   rateOfGrowthCurrent: (float) current futureRate: (float) future
{
    float growth = 0.0;
    growth=(future-current)/current;
    return growth;
}
@end
