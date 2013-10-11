//
//  CDAAllergyImporter.m
//  HealthDataStandards
//
//  Created by Saltzman, Shep on 5/21/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import "CDAAllergyImporter.h"

@implementation CDAAllergyImporter

- (CDAAllergyImporter *)init:(CDAEntryFinder *)finder {
    
    if (finder) {
        finder = [[CDAEntryFinder alloc] init:@"//cda:section[cda:templateId/@root='2.16.840.1.113883.10.20.22.2.6.1']/cda:entry/cda:act/cda:entryRelationship/cda:observation"];
    }
    CDAAllergyImporter *importer = [super init:finder];
    
    if (importer) {
        self.codeXpath = @"./cda:value";
        self.idXpath = @"./cda:id";
        
        self.statusXpath = @"./cda:entryRelationship/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.50']/cda:value";
        self.ordinalityXpath = @"./cda:priorityCode";
        self.descriptionXpath = @"./cda:participant/cda:participantRole/cda:playingEntity/cda:code[@displayName]";
        self.providerXpath = @"./cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']/cda:performer";
        self.entryClass = [CDACondition class];
        
        self.checkForUsable = NO;
        
    }
    
    return importer;
}

@end
