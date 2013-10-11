//
//  HDSCodedEntry.h
//  HealthDataStandards
//
//  Created by Adam on 5/2/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDSCodedEntry : NSObject

@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSString *codeSet;

- (HDSCodedEntry *)init:(NSString *)c codeSet:(NSString *)cs;

@end
