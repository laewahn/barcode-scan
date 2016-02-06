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

@interface BarcodeBufferTests : XCTestCase {
    BarcodeBuffer* testBuffer;
    NSDate* someDate;
}

@end

@implementation BarcodeBufferTests

- (void)setUp
{
    testBuffer = [[BarcodeBuffer alloc] init];
    someDate = [NSDate date];
}

- (void)testOneBarcodeCanBeAdded
{
    Barcode* someBarcode = [[Barcode alloc] initWithValue:@"123456"
                                                     type:@"de.laewahn.testBarcode"
                                                   bounds:CGRectMake(0, 0, .5, .5)
                                                timestamp:someDate];
    
    [testBuffer registerOrUpdateBarcode:someBarcode];
    
    XCTAssertEqual([testBuffer.barcodes count], 1);
    XCTAssertTrue([testBuffer.barcodes containsObject:someBarcode]);
}

- (void)testAnotherBarcodeCanBeAdded
{
    Barcode* someBarcode = [[Barcode alloc] initWithValue:@"123456"
                                                     type:@"de.laewahn.testBarcode"
                                                   bounds:CGRectMake(0, 0, .5, .5)
                                                timestamp:someDate];
    Barcode* anotherBarcode = [[Barcode alloc] initWithValue:@"98765"
                                                        type:@"de.laewahn.testBarcode"
                                                      bounds:CGRectMake(.5, .5, .5, .5)
                                                   timestamp:someDate];
    
    [testBuffer registerOrUpdateBarcode:someBarcode];
    [testBuffer registerOrUpdateBarcode:anotherBarcode];
    
    XCTAssertEqual([testBuffer.barcodes count], 2);
    XCTAssertTrue([testBuffer.barcodes containsObject:someBarcode]);
    XCTAssertTrue([testBuffer.barcodes containsObject:anotherBarcode]);
}

- (void)testBarcodesWithEqualValueAndTypeReplaceEachOther
{
    Barcode* someBarcode = [[Barcode alloc] initWithValue:@"123456"
                                                     type:@"de.laewahn.testBarcode"
                                                   bounds:CGRectMake(0, 0, .5, .5)
                                                timestamp:someDate];
    Barcode* anotherBarcode = [[Barcode alloc] initWithValue:@"123456"
                                                        type:@"de.laewahn.testBarcode"
                                                      bounds:CGRectMake(.5, .5, .5, .5)
                                                   timestamp:someDate];
    
    [testBuffer registerOrUpdateBarcode:someBarcode];
    [testBuffer registerOrUpdateBarcode:anotherBarcode];
    
    XCTAssertEqual([testBuffer.barcodes count], 1);
    XCTAssertTrue([testBuffer.barcodes containsObject:anotherBarcode]);
}

- (void)testBarcodesThatAreTooOldAreDiscarded
{
    [testBuffer setBarcodeExpirationTime:2.0];
    
    Barcode* someBarcode = [[Barcode alloc] initWithValue:@"123456"
                                                     type:@"de.laewahn.testBarcode"
                                                   bounds:CGRectMake(0, 0, .5, .5)
                                                timestamp:someDate];
    [testBuffer registerOrUpdateBarcode:someBarcode];
    
    NSDate* moreThanTwoSecondsLater = [someDate dateByAddingTimeInterval:2.1];
    [testBuffer cleanupExpiredBarcodesAt:moreThanTwoSecondsLater];
    
    XCTAssertEqual([testBuffer.barcodes count], 0);
    XCTAssertFalse([testBuffer.barcodes containsObject:someBarcode]);
}

- (void)testBarcodesThatAreNotTooOldAreKept
{
    [testBuffer setBarcodeExpirationTime:2.0];
    
    Barcode* someBarcode = [[Barcode alloc] initWithValue:@"123456"
                                                     type:@"de.laewahn.testBarcode"
                                                   bounds:CGRectMake(0, 0, .5, .5)
                                                timestamp:someDate];
    [testBuffer registerOrUpdateBarcode:someBarcode];
    
    NSDate* lessThanTwoSecondsLater = [someDate dateByAddingTimeInterval:1.9];
    [testBuffer cleanupExpiredBarcodesAt:lessThanTwoSecondsLater];
    
    XCTAssertEqual([testBuffer.barcodes count], 1);
    XCTAssertTrue([testBuffer.barcodes containsObject:someBarcode]);
}

@end
