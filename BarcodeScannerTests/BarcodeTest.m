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
    Barcode* someBarcode = [[Barcode alloc] initWithValue:@"123456" type:@"de.laewahn.testBarcode" bounds:CGRectMake(.1, .1, .1, .1)];
    Barcode* theSameBarcode = [[Barcode alloc] initWithValue:@"123456" type:@"de.laewahn.testBarcode" bounds:CGRectMake(.2, .2, .2, .2)];
    
    XCTAssertEqualObjects(someBarcode, theSameBarcode);
}

@end
