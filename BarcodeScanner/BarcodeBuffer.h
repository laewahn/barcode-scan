//
//  BarcodeBuffer.h
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 06/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Barcode;

@interface BarcodeBuffer : NSObject

- (void)registerOrUpdateBarcode:(Barcode *)barcode;
- (void)cleanupExpiredBarcodesAt:(NSDate *)currentDate;

@property(nonatomic, readonly, copy) NSArray* barcodes;
@property(nonatomic, assign) NSTimeInterval barcodeExpirationTime;

@end
