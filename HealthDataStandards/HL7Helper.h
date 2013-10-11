//
//  HL7Helper.h
//  HealthDataStandards
//
//  Created by Adam Goldstein on 4/30/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HL7Helper : NSObject

// Converts an HL7 timestamp into an Integer
// @param [NSString *] timestamp The HL7 timestamp. Expects YYYYMMDD format
// @return [NSInteger *] Date in seconds since the epoch, or -1 if timestamp is not formatted as an HL7 timestamp
+ (NSTimeInterval)timestampToInteger:(NSString *)timestamp;

@end
