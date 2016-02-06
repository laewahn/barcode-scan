//
//  NSDate+Convenience.m
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 06/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import "NSDate+Convenience.h"

@implementation NSDate (Convenience)

- (NSDate *)dateBySubtractingTimeInterval:(NSTimeInterval)timeinterval
{
    return [self dateByAddingTimeInterval:-timeinterval];
}

@end

