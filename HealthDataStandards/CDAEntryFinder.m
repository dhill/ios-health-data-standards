//
//  CDAEntryFinder.m
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 abgoldstein industries. All rights reserved.
//

#import "CDAEntryFinder.h"

@implementation CDAEntryFinder

@synthesize entryXpath;

- (CDAEntryFinder *)init:(NSString *)xpath {
    CDAEntryFinder *finder = [super init];
    
    if (finder) {
        entryXpath = xpath;
    }
    
    return finder;
}

- (NSArray *)entries:(GDataXMLDocument *)doc {
    NSError *error;
    NSArray *entries = [[NSArray alloc] init];
    
    [doc nodesForXPath:entryXpath namespaces:[CDAHelper namespaces] error:&error];
    // TODO if block is given
    
    return entries;
}

@end
