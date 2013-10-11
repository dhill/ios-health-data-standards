//
//  HDSRecord.h
//  HealthDataStandards
//
//  Created by Adam Goldstein on 4/30/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDSCodedEntry.h"
#import "CDADatum.h"

@interface HDSRecord : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *first;
@property (nonatomic, retain) NSString *last;
@property (nonatomic, retain) NSString *gender;
@property (nonatomic, assign) NSTimeInterval birthdate;
@property (nonatomic, assign) NSTimeInterval deathdate;
@property (nonatomic, assign) NSTimeInterval effectiveTime;
@property (nonatomic, retain) HDSCodedEntry *religiousAffiliation;
@property (nonatomic, retain) HDSCodedEntry *martialStatus;
@property (nonatomic, retain) HDSCodedEntry *race;
@property (nonatomic, retain) HDSCodedEntry *ethnicity;
@property (nonatomic, retain) NSArray *languages;
@property (nonatomic, retain) NSArray *addresses;
@property (nonatomic, retain) NSArray *telecoms;
@property (nonatomic, retain) NSString *medicalRecordNumber;
@property (nonatomic, assign) BOOL expired;
@property (nonatomic, assign) BOOL clinicalTrialParticipant;

@property (nonatomic, retain) NSArray *conditions;
@property (nonatomic, retain) NSArray *allergies;
@property (nonatomic, retain) NSArray *immunizations;
@property (nonatomic, retain) NSArray *medications;
@property (nonatomic, retain) NSArray *problemlist;
@property (nonatomic, retain) NSArray *procedures;
@property (nonatomic, retain) NSArray *reasonforreferral;
@property (nonatomic, retain) NSArray *encounters;
@property (nonatomic, retain) NSArray *careplan;
@property (nonatomic, retain) NSArray *dischargemedications;
@property (nonatomic, retain) NSArray *functionalandcognitivestatus;
@property (nonatomic, retain) NSArray *results;
@property (nonatomic, retain) NSArray *socialhistory;
@property (nonatomic, retain) NSArray *vitalsigns;

@property (nonatomic, retain) CDADatum *CDAroot;

+(HDSRecord *)generateHDSRecordFromCCDA:(NSString *)fileName;

@end
