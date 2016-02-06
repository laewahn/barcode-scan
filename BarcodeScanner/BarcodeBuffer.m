//
//  BarcodeBuffer.m
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 06/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import "BarcodeBuffer.h"
#import "NSDate+Convenience.h"

#import "Barcode.h"


@interface BarcodeBuffer()

# pragma mark Private properties

@property(nonatomic, strong) NSMutableDictionary* barcodesByTypeAndValue;

@end


# pragma mark -

@implementation BarcodeBuffer

@synthesize barcodes = _barcodes;


# pragma mark Property implementation

- (NSMutableDictionary *)barcodesByTypeAndValue
{
    if (_barcodesByTypeAndValue == nil) {
        _barcodesByTypeAndValue = [[NSMutableDictionary alloc] init];
    }
    
    return _barcodesByTypeAndValue;
}

- (NSArray *)barcodes
{
    return [[self.barcodesByTypeAndValue allValues] copy];
}


# pragma mark Public interface

- (void)registerOrUpdateBarcode:(Barcode *)barcode
{
    [self.barcodesByTypeAndValue setObject:barcode forKey:[self hashForBarcode:barcode]];
}

- (void)cleanupExpiredBarcodesAt:(NSDate *)currentDate
{
    NSArray* allBarcodesCopy = [self barcodes];
    
    for (Barcode* barcode in allBarcodesCopy) {
        NSDate* expirationDate = [currentDate dateBySubtractingTimeInterval:[self barcodeExpirationTime]];
        if ([barcode isOlderThan:expirationDate]) {
            [self.barcodesByTypeAndValue removeObjectForKey:[self hashForBarcode:barcode]];
        }
    }
}

- (NSString *)hashForBarcode:(Barcode *)barcode
{
    return [NSString stringWithFormat:@"%@.%@", [barcode type], [barcode value]];
}

@end
