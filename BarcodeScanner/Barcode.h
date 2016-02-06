//
//  Barcode.h
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 06/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Barcode : NSObject

- (instancetype)initWithValue:(NSString *)value type:(NSString *)type bounds:(CGRect) bounds timestamp:(NSDate *)timestamp;

- (BOOL)isOlderThan:(NSDate *)referenceDate;

@property(nonatomic, strong) NSString* value;
@property(nonatomic, strong) NSString* type;
@property(nonatomic, assign) CGRect bounds;
@property(nonatomic, strong) NSDate* timestamp;

@end
