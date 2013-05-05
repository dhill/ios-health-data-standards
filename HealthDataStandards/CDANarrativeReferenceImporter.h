//
//  CDANarrativeReferenceImporter.h
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 abgoldstein industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "CDAHelper.h"

@interface CDANarrativeReferenceImporter : NSObject

// Build ID Map
//
// @param [GDataXMLDocument] doc CCDA document for which we're building an ID map
- (void)buildIdMap:(GDataXMLDocument *)doc;

// Lookup Tag
//
// @param [NSString] tag
- (NSString *)lookupTag:(NSString *)tag;

@end
