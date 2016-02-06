//
//  Barcode.m
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 06/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import "Barcode.h"

@implementation Barcode

- (instancetype)initWithValue:(NSString *)value type:(NSString *)type bounds:(CGRect) bounds timestamp:(NSDate *)timestamp
{
    self = [super init];
    if (self) {
        _value = value;
        _type = type;
        _bounds = bounds;
        _timestamp = timestamp;
    }
    
    return self;
}

- (BOOL)isOlderThan:(NSDate *)referenceDate
{
    return [self.timestamp compare:referenceDate] == NSOrderedAscending;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    Barcode* otherBarcode = (Barcode *)object;
    
    return [self.value isEqualToString:[otherBarcode value]]
        && [self.type isEqualToString:[otherBarcode type]];
}

@end
