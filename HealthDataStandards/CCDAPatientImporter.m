//
//  PatientImporter.m
//  PatientImporter
//
//  Created by Adam Goldstein on 4/29/13.
//  Copyright (c) 2013 abgoldstein industries. All rights reserved.
//

#import "CCDAPatientImporter.h"

@implementation CCDAPatientImporter

static NSDictionary *sectionImporters;

+ (CCDAPatientImporter *)sharedInstance
{
    static CCDAPatientImporter *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CCDAPatientImporter alloc] init];
        sectionImporters = @{
                             @"conditions": [[CDAConditionImporter alloc] init]
                             };
    });
    
    return sharedInstance;
}

- (HDSRecord *)parseCcda:(GDataXMLDocument *)doc {
    HDSRecord *patient = [[HDSRecord alloc] init];
    
    [self parseDemographics:patient doc:doc];
    [self parseSections:patient doc:doc];
    [self checkForCauseOfDeath:patient];
    
    return patient;
}

- (void)parseDemographics:(HDSRecord *)patient doc:(GDataXMLDocument *)doc {
    NSError *error;
    
    // Effective time
    NSArray *effectiveTimeNodes = [doc nodesForXPath:@"/cda:ClinicalDocument/cda:effectiveTime" namespaces:[CDAHelper namespaces] error:&error];
    GDataXMLElement *effectiveTimeElement = effectiveTimeNodes[0];
    GDataXMLNode *effectiveTimeNode = [effectiveTimeElement attributeForName:@"value"];
    NSString *effectiveTime = [effectiveTimeNode stringValue];
    patient.effectiveTime = [HL7Helper timestampToInteger:effectiveTime];
    
    // Patient Node
    NSArray *patientRoleNodes = [doc nodesForXPath:@"/cda:ClinicalDocument/cda:recordTarget/cda:patientRole" namespaces:[CDAHelper namespaces] error:&error];
    GDataXMLNode *patientRoleNode = patientRoleNodes[0];
    NSArray *patientNodes = [patientRoleNode nodesForXPath:@"./cda:patient" namespaces:[CDAHelper namespaces] error:&error];
    GDataXMLNode *patientNode = patientNodes[0];
    
    // Title
    NSArray *titleNodes = [patientNode nodesForXPath:@"cda:name/cda:title" namespaces:[CDAHelper namespaces] error:&error];
    if ([titleNodes count] > 0) {
        GDataXMLElement *titleElement = titleNodes[0];
        patient.title = [titleElement stringValue];
    }
    
    // First
    NSArray *firstNodes = [patientNode nodesForXPath:@"cda:name/cda:given" namespaces:[CDAHelper namespaces] error:&error];
    NSString *firstName = [firstNodes[0] stringValue];
    patient.first = firstName;
    
    // Last
    NSArray *lastNodes = [patientNode nodesForXPath:@"cda:name/cda:family" namespaces:[CDAHelper namespaces] error:&error];
    patient.last = [lastNodes[0] stringValue];
    
    // Birthtime
    NSArray *birthtimeNodes = [patientNode nodesForXPath:@"cda:birthTime" namespaces:[CDAHelper namespaces] error:&error];
    NSString *birthTime = [birthtimeNodes[0] stringValue];
    patient.birthdate = [HL7Helper timestampToInteger:birthTime];
    
    // Gender
    NSArray *genderNodes = [patientNode nodesForXPath:@"cda:administrativeGenderCode" namespaces:[CDAHelper namespaces] error:&error];
    GDataXMLNode *genderCode = [genderNodes[0] attributeForName:@"code"];
    patient.gender = [genderCode stringValue];
    
    // Medical Record Number
    NSArray *idNodes = [patientRoleNode nodesForXPath:@"./cda:id" namespaces:[CDAHelper namespaces] error:&error];
    GDataXMLNode *idExtension = [idNodes[0] attributeForName:@"extension"];
    patient.medicalRecordNumber = [idExtension stringValue];

    // Race
    NSArray *raceNodes = [patientNode nodesForXPath:@"cda:raceCode" namespaces:[CDAHelper namespaces] error:&error];
    if ([raceNodes count] > 0) {
        GDataXMLNode *raceCode = [raceNodes[0] attributeForName:@"code"];
        patient.race = [[HDSCodedEntry alloc] init:[raceCode stringValue] codeSet:@"CDC-RE"];
    }
    
    // Ethnicity
    NSArray *ethnicityNodes = [patientNode nodesForXPath:@"cda:ethnicGroupCode" namespaces:[CDAHelper namespaces] error:&error];
    if ([ethnicityNodes count] > 0) {
        GDataXMLNode *ethnicityCode = [ethnicityNodes[0] attributeForName:@"code"];
        patient.ethnicity = [[HDSCodedEntry alloc] init:[ethnicityCode stringValue] codeSet:@"CDC-RE"];
    }
    
    // Marital Status
    NSArray *maritalNodes = [patientNode nodesForXPath:@"./cda:maritalStatusCode" namespaces:[CDAHelper namespaces] error:&error];
    if ([maritalNodes count] > 0) {
        GDataXMLNode *maritalCode = [maritalNodes[0] attributeForName:@"code"];
        patient.martialStatus = [[HDSCodedEntry alloc] init:[maritalCode stringValue] codeSet:@"HL7 Marital Status"];
    }
    
    // Religious Affiliation
    NSArray *religionNodes = [patientNode nodesForXPath:@"./cda:religiousAffiliationCode" namespaces:[CDAHelper namespaces] error:&error];
    if ([religionNodes count] > 0) {
        GDataXMLNode *religionCode = [religionNodes[0] attributeForName:@"code"];
        patient.religiousAffiliation = [[HDSCodedEntry alloc] init:[religionCode stringValue] codeSet:@"Religious Affiliation"];
    }
    
    // Spoken language - TODO: Need to test a CCDA with languages
    NSArray *languageNodes = [patientRoleNode nodesForXPath:@"./cda:languageCommunication" namespaces:[CDAHelper namespaces] error:&error];
    NSMutableArray *languages = [[NSMutableArray alloc] init];
    for (GDataXMLElement *languageNode in languageNodes) {
        NSArray *languageElements = [languageNode nodesForXPath:@"cda:languageCode" namespaces:[CDAHelper namespaces] error:&error];
        [languages addObject:[languageElements[0] attributeForName:@"code"]];
    }
    patient.languages = languages;
    
    // Addresses
    NSArray *addressElements = [patientRoleNode nodesForXPath:@"./cda:addr" namespaces:[CDAHelper namespaces] error:&error];
    NSMutableArray *addresses = [[NSMutableArray alloc] init];
    for (GDataXMLElement *addressElement in addressElements) {
        [addresses addObject:[CDAHelper parseAddress:addressElement]];
    }
    patient.addresses = addresses;
    
    // Telecoms
    NSArray *telecomElements = [patientRoleNode nodesForXPath:@"./cda:telecom" namespaces:[CDAHelper namespaces] error:&error];
    NSMutableArray *telecoms = [[NSMutableArray alloc] init];
    for (GDataXMLElement *telecomElement in telecomElements) {
        [telecoms addObject:[CDAHelper parseTelecom:telecomElement]];
    }
    patient.telecoms = telecoms;
}

- (void)parseSections:(HDSRecord *)patient doc:(GDataXMLDocument *)doc {
    CDANarrativeReferenceImporter *nri = [[CDANarrativeReferenceImporter alloc] init];
    [nri buildIdMap:doc];
    for (NSString *sectionName in sectionImporters) {
        NSArray *section = [[sectionImporters valueForKey:sectionName] createEntries:doc nri:nri];
        [patient setValue:section forKeyPath:sectionName];
    }
}

- (void)checkForCauseOfDeath:(HDSRecord *)patient {
    CDACondition *causeOfDeath;
    for (CDACondition *condition in patient.conditions) {
        if (condition.causeOfDeath) {
            causeOfDeath = condition;
            break;
        }
    }
    
    if (causeOfDeath) {
        patient.expired = TRUE;
        patient.deathdate = causeOfDeath.timeOfDeath;
    }
}

@end
