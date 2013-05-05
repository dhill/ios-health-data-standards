//
//  HL7Helper.m
//  HealthDataStandards
//
//  Created by Adam Goldstein on 4/30/13.
//  Copyright (c) 2013 abgoldstein industries. All rights reserved.
//

#import "HL7Helper.h"

@implementation HL7Helper

+ (NSTimeInterval)timestampToInteger:(NSString *)timestamp {
    if (timestamp && [timestamp length] >= 4) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        NSString *dateString;
        NSDate *date;
        
        NSString *year = [timestamp substringWithRange:NSMakeRange(0, 4)];
        NSString *month = ([timestamp length] >= 6) ? [timestamp substringWithRange:NSMakeRange(4, 2)] : @"01";
        NSString *day = ([timestamp length] >= 8) ? [timestamp substringWithRange:NSMakeRange(6, 2)] : @"01";
        NSString *hour = ([timestamp length] >= 10) ? [timestamp substringWithRange:NSMakeRange(8, 2)] : @"00";
        NSString *minute = ([timestamp length] >= 12) ? [timestamp substringWithRange:NSMakeRange(10, 2)] : @"00";
        NSString *second = ([timestamp length] >= 14) ? [timestamp substringWithRange:NSMakeRange(12, 2)] : @"00";
        
        dateString = [NSString stringWithFormat:@"%@%@%@%@%@%@", year, month, day, hour, minute, second];
        [dateFormat setDateFormat:@"yyyyMMddHHmmss"];
        date = [dateFormat dateFromString:dateString];
        return [date timeIntervalSince1970];
    } else {
        return -1.0;
    }
}

@end
