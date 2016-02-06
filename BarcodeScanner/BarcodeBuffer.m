//
//  BarcodeBuffer.m
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 06/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import "BarcodeBuffer.h"

#import "Barcode.h"

@interface BarcodeBuffer()
@property(nonatomic, strong) NSMutableDictionary* barcodesByTypeAndValue;
@end

@implementation BarcodeBuffer

@synthesize barcodes = _barcodes;

- (void)registerOrUpdateBarcode:(Barcode *)barcode
{
    NSString* barcodeHash = [NSString stringWithFormat:@"%@.%@", [barcode type], [barcode value]];
    [self.barcodesByTypeAndValue setObject:barcode forKey:barcodeHash];
}

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

@end
