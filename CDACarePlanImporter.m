//
//  CDACarePlanImporter.m
//  HealthDataStandards
//
//  Created by Saltzman, Shep on 8/29/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import "CDACarePlanImporter.h"

@implementation CDACarePlanImporter

- (CDACarePlanImporter *)init:(CDAEntryFinder *)finder {
     
    if (finder) {
        finder = [[CDAEntryFinder alloc] init:@"//cda:section[cda:templateId/@root='2.16.840.1.113883.10.20.22.2.6.1']/cda:entry/cda:act/cda:entryRelationship/cda:observation"];
    }
    CDACarePlanImporter *importer = [super init:finder];
    
    if (importer) {
        self.codeXpath = @"./cda:value";
        self.idXpath = @"./cda:id";
        
    }
    return importer;
    
}

@end
