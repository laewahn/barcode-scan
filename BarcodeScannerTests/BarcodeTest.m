//
//  BarcodeTest.m
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 06/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Barcode.h"

@interface BarcodeTest : XCTestCase

@end

@implementation BarcodeTest

- (void)testBarcodesAreEqualWhenValueAndTypeAreEqual
{
    NSDate* someDate = [NSDate date];
    Barcode* someBarcode = [[Barcode alloc] initWithValue:@"123456"
                                                     type:@"de.laewahn.testBarcode"
                                                   bounds:CGRectMake(.1, .1, .1, .1)
                                                timestamp:someDate];
    
    NSDate* anotherDate = [someDate dateByAddingTimeInterval:123.4];
    Barcode* theSameBarcode = [[Barcode alloc] initWithValue:@"123456"
                                                        type:@"de.laewahn.testBarcode"
                                                      bounds:CGRectMake(.2, .2, .2, .2)
                                                   timestamp:anotherDate];
    
    XCTAssertEqualObjects(someBarcode, theSameBarcode);
}

- (void)testAgeOfBarcodesCanBeTestedAgainstOtherTimestamps
{
    NSDate* referenceDate = [NSDate date];
    Barcode* someBarcode = [[Barcode alloc] initWithValue:@"123456"
                                                          type:@"de.laewahn.testBarcode"
                                                        bounds:CGRectMake(.1, .1, .1, .1)
                                                     timestamp:referenceDate];
    
    NSDate* timestampBeforeReference = [referenceDate dateByAddingTimeInterval:-1.0];
    NSDate* timestampAfterReference = [referenceDate dateByAddingTimeInterval:1.0];
    
    XCTAssertFalse([someBarcode isOlderThan:timestampBeforeReference]);
    XCTAssertTrue([someBarcode isOlderThan:timestampAfterReference]);
    
}

@end
