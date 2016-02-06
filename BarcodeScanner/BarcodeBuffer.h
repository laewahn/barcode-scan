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

@property(nonatomic, readonly, copy) NSMutableArray* barcodes;

@end
