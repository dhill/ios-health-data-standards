//
//  HDSCodedEntry.m
//  HealthDataStandards
//
//  Created by Adam on 5/2/13.
//  Copyright (c) 2013 abgoldstein industries. All rights reserved.
//

#import "HDSCodedEntry.h"

@implementation HDSCodedEntry

- (HDSCodedEntry *)init:(NSString *)c codeSet:(NSString *)cs {
    self = [super init];
    
    if (self) {
        self.code = c;
        self.codeSet = cs;
    }
    
    return self;
}

@synthesize code;
@synthesize codeSet;

@end
