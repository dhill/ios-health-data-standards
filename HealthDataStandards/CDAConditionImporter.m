//
//  CDAConditionImporter.m
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 abgoldstein industries. All rights reserved.
//

#import "CDAConditionImporter.h"

@implementation CDAConditionImporter

@synthesize ordinalityXpath;

- (CDAConditionImporter *)init:(CDAEntryFinder *)finder {
    if (finder) {
        finder = [[CDAEntryFinder alloc] init:@"//cda:section[cda:templateId/@root='2.16.840.1.113883.3.88.11.83.103']/cda:entry/cda:act/cda:entryRelationship/cda:observation"];
    }
    CDAConditionImporter *importer = [super init:finder];
    
    if (importer) {
        self.codeXpath = @"./cda:value";
        self.idXpath = @"./cda:id";
        self.statusXpath = @"./cda:entryRelationship/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.50']/cda:value";
        self.ordinalityXpath = @"./cda:priorityCode";
        self.descriptionXpath = @"./cda:text/cda:reference[@value]";
        self.providerXpath = @"./cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']/cda:performer";
        self.entryClass = [CDACondition class];
        
        /*
        @entry_finder = entry_finder
        @code_xpath = "./cda:value"
        @id_xpath = "./cda:id"
        @status_xpath = "./cda:entryRelationship/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.50']/cda:value"
        @ordinality_xpath = "./cda:priorityCode"
        @description_xpath = "./cda:text/cda:reference[@value]"
        @provider_xpath = "./cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']/cda:performer"
        @priority_xpath = "../cda:sequenceNumber"
        @entry_class = Condition
        */
    }
    
    return importer;
}

@end
