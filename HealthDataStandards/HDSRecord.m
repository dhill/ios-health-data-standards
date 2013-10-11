//
//  HDSRecord.m
//  HealthDataStandards
//
//  Created by Adam Goldstein on 4/30/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import "HDSRecord.h"
#import "CCDAPatientImporter.h"

@implementation HDSRecord

@synthesize title;
@synthesize first;
@synthesize last;
@synthesize gender;
@synthesize birthdate;
@synthesize deathdate;
@synthesize religiousAffiliation;
@synthesize effectiveTime;
@synthesize race;
@synthesize ethnicity;
@synthesize languages;
@synthesize martialStatus;
@synthesize medicalRecordNumber;
@synthesize expired;
@synthesize clinicalTrialParticipant;

@synthesize conditions;
@synthesize allergies;
@synthesize immunizations;
@synthesize medications;
@synthesize problemlist;
@synthesize procedures;

+(HDSRecord *)generateHDSRecordFromCCDA:(NSString *)fileName{
    NSString *ccdaFilename = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:@"xml"];
    NSData *ccdaData = [[NSData alloc] initWithContentsOfFile:ccdaFilename];
    
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:ccdaData options:0 error:&error];
    if (error || doc == nil) {
        NSLog(@"Error with importing document.");
        return nil;
    }
    
    CCDAPatientImporter *importer = [CCDAPatientImporter sharedInstance];
    HDSRecord *patient = [importer parseCcda:doc];
    
    return patient;
}

@end
