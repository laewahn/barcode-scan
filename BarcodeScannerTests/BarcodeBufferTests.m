//
//  BarcodeBufferTests.m
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 06/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BarcodeBuffer.h"
#import "Barcode.h"

@interface BarcodeBufferTests : XCTestCase

@end

@implementation BarcodeBufferTests

- (void)testOneBarcodeCanBeAdded
{
    BarcodeBuffer* testBuffer = [[BarcodeBuffer alloc] init];
    Barcode* someBarcode = [[Barcode alloc] initWithValue:@"123456" type:@"de.laewahn.testBarcode" bounds:CGRectMake(0, 0, .5, .5)];
    
    [testBuffer registerOrUpdateBarcode:someBarcode];
    
    XCTAssertEqual([testBuffer.barcodes count], 1);
    XCTAssertTrue([testBuffer.barcodes containsObject:someBarcode]);
}

- (void)testAnotherBarcodeCanBeAdded
{
    BarcodeBuffer* testBuffer = [[BarcodeBuffer alloc] init];
    
    Barcode* someBarcode = [[Barcode alloc] initWithValue:@"123456" type:@"de.laewahn.testBarcode" bounds:CGRectMake(0, 0, .5, .5)];
    Barcode* anotherBarcode = [[Barcode alloc] initWithValue:@"98765" type:@"de.laewahn.testBarcode" bounds:CGRectMake(.5, .5, .5, .5)];
    
    [testBuffer registerOrUpdateBarcode:someBarcode];
    [testBuffer registerOrUpdateBarcode:anotherBarcode];
    
    XCTAssertEqual([testBuffer.barcodes count], 2);
    XCTAssertTrue([testBuffer.barcodes containsObject:someBarcode]);
    XCTAssertTrue([testBuffer.barcodes containsObject:anotherBarcode]);
}

- (void)testBarcodesWithEqualValueAndTypeReplaceEachOther
{
    BarcodeBuffer* testBuffer = [[BarcodeBuffer alloc] init];
    
    Barcode* someBarcode = [[Barcode alloc] initWithValue:@"123456" type:@"de.laewahn.testBarcode" bounds:CGRectMake(0, 0, .5, .5)];
    Barcode* anotherBarcode = [[Barcode alloc] initWithValue:@"123456" type:@"de.laewahn.testBarcode" bounds:CGRectMake(.5, .5, .5, .5)];
    
    [testBuffer registerOrUpdateBarcode:someBarcode];
    [testBuffer registerOrUpdateBarcode:anotherBarcode];
    
    XCTAssertEqual([testBuffer.barcodes count], 1);
    XCTAssertTrue([testBuffer.barcodes containsObject:anotherBarcode]);
}

@end
