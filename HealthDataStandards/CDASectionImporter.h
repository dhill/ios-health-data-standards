//
//  CDASectionImporter.h
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 abgoldstein industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "CDANarrativeReferenceImporter.h"
#import "CDAEntryFinder.h"
#import "CDAEntry.h"

@interface CDASectionImporter : NSObject

@property (nonatomic, retain) CDAEntryFinder *entryFinder;
@property (nonatomic, retain) NSString *codeXpath;
@property (nonatomic, retain) NSString *idXpath;
@property (nonatomic, retain) NSString *statusXpath;
@property (nonatomic, retain) NSString *priorityXpath;
@property (nonatomic, retain) NSString *descriptionXpath;
@property (nonatomic, assign) Class entryClass;
@property (nonatomic, assign) BOOL checkForUsable;

- (CDASectionImporter *)init:(CDAEntryFinder *)finder;

// Traverses an HL7 CDA document passed in and creates an Array of Entry
// objects based on what it finds
// @param [GDataXMLDocument] doc The CCDA document parsed by GDataXML.
//
// @return [NSArray] will be a list of CDAEntry objects
- (NSArray *)createEntries:(GDataXMLDocument *)doc nri:(CDANarrativeReferenceImporter *)nri;

- (CDAEntry *)createEntry:(GDataXMLElement *)entryElement nri:(CDANarrativeReferenceImporter *)nri;

@end
