//
//  NSDate+Convenience.h
//  BarcodeScanner
//
//  Created by Dennis Lewandowski on 06/02/16.
//  Copyright © 2016 laewahn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Convenience)

- (NSDate *)dateBySubtractingTimeInterval:(NSTimeInterval)timeinterval;

@end

