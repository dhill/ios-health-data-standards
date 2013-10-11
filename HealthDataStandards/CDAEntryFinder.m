//
//  CDAEntryFinder.m
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
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
    
    entries = [doc nodesForXPath:entryXpath namespaces:[CDAHelper namespaces] error:&error];
    if(error){
        NSLog(@"ERROR: %@", error);
    }
    // TODO if block is given
    
    return entries;
}

@end
