//
//  CDASectionImporter.m
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 abgoldstein industries. All rights reserved.
//

#import "CDASectionImporter.h"

@implementation CDASectionImporter

- (CDASectionImporter *)init:(CDAEntryFinder *)finder; {
    CDASectionImporter *importer = [self init];
    
    if (importer) {
        self.entryFinder = finder;
        self.codeXpath = @"./cda:code";
        self.idXpath = @"./cda:id";
        self.statusXpath = NULL;
        self.priorityXpath = NULL;
        self.descriptionXpath = @"./cda:code/cda:originalText/cda:reference[@value] | ./cda:text/cda:reference[@value]";
        self.checkForUsable = TRUE;
        self.entryClass = [CDAEntry class];
    }
    
    return importer;
}

- (NSArray *)createEntries:(GDataXMLDocument *)doc nri:(CDANarrativeReferenceImporter *)nri {
    NSMutableArray *entryList = [[NSMutableArray alloc] init];
    NSArray *entryElements = [self.entryFinder entries:doc];
    for (GDataXMLElement *entryElement in entryElements) {
        CDAEntry *entry = [self createEntry:entryElement nri:nri];
        if (self.checkForUsable) {
            if (entry.isUsable) [entryList addObject:entry];
        } else {
            [entryList addObject:entry];
        }
    }
    
    return entryList;
}

- (CDAEntry *)createEntry:(GDataXMLElement *)entryElement nri:(CDANarrativeReferenceImporter *)nri {
    CDAEntry *entry = [[CDAEntry alloc] init];
    
    return entry;
}

@end
