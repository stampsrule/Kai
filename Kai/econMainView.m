//
//  econMainView.m
//  Kai
//
//  Created by Daniel Bell on 2014-04-06.
//  Copyright (c) 2014 Daniel Bell. All rights reserved.
//

#import "econMainView.h"
#import "econViewController.h"
@implementation econMainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    econViewController *mycontroller;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextMoveToPoint(context, 30, 30);
    CGContextAddLineToPoint(context, 300, 400);
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
}


@end
