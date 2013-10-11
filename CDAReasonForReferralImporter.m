//
//  ReasonForReferralImporter.m
//  HealthDataStandards
//
//  Created by Saltzman, Shep on 8/29/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import "CDAReasonForReferralImporter.h"

@implementation CDAReasonForReferralImporter

- (CDAReasonForReferralImporter *)init:(CDAEntryFinder *)finder {
     
    if (finder) {
        finder = [[CDAEntryFinder alloc] init:@"//cda:section[cda:templateId/@root='1.3.6.1.4.1.19376.1.5.3.1.3.1']"];
    }
    CDAReasonForReferralImporter *importer = [super init:finder];
    
    if (importer) {
        self.codeXpath = @"./cda:value";
        self.idXpath = @"./cda:id";
        
        self.statusXpath = @"./cda:entryRelationship/cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.50']/cda:value";
        self.ordinalityXpath = @"./cda:priorityCode";
        self.descriptionXpath = @"./cda:participant/cda:participantRole/cda:playingEntity/cda:code[@displayName]";
        self.providerXpath = @"./cda:act[cda:templateId/@root='2.16.840.1.113883.10.20.1.27']/cda:performer";
        self.entryClass = [CDACondition class];
        
    }
    return importer;
}

@end
