//
//  CDANarrativeReferenceImporter.m
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import "CDANarrativeReferenceImporter.h"

@implementation CDANarrativeReferenceImporter

NSDictionary *idMap;

- (void)buildIdMap:(GDataXMLDocument *)doc {
    NSError *error;
    NSArray *ids = [doc nodesForXPath:@"//*[@ID]" namespaces:[CDAHelper namespaces] error:&error];
    
    NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
    for (GDataXMLElement *idElement in ids) {
        NSString *tag = [[idElement attributeForName:@"ID"] stringValue];
        map[tag] = [idElement stringValue];
    }
    idMap = map;
}

- (NSString *)lookupTag:(NSString *)tag {
    NSString *value = idMap[tag];
    
    if (!value && [tag characterAtIndex:0] == '#') {
        tag = [tag substringFromIndex:1];
        value = idMap[tag];
    }
    
    return value;
}

@end
