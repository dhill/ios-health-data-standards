//
//  PatientImporter.h
//  PatientImporter
//
//  Created by Adam Goldstein on 4/29/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

#import "HDSRecord.h"
#import "HDSCodedEntry.h"

#import "CDANarrativeReferenceImporter.h"
#import "CDAConditionImporter.h"
#import "CDACondition.h"

#import "CDAAllergyImporter.h"
#import "CDAAllergy.h"

#import "CDAImmunizationImporter.h"
#import "CDAMedicationImporter.h"

#import "CDAEncounterImporter.h"
#import "CDAConditionImporter.h"
#import "CDACarePlanImporter.h"
#import "CDADischargeMedicationImporter.h"
#import "CDAReasonForReferralImporter.h"
#import "CDAProblemListImporter.h"
#import "CDAProcedureImporter.h"

#import "CDAFunctionalAndCognitiveStatusImporter.h"
#import "CDAResultsImporter.h"
#import "CDASocialHistoryImporter.h"
#import "CDAVitalSignsImporter.h"
#import "CDADischargeMedicationImporter.h"

#import "Hl7Helper.h"
#import "CDAHelper.h"

// This class is the central location for taking a CCDA XML document and converting it
// into a key-value representation of a patient. The class does this by running each measure
// independently on the XML document.
//
// This class is a Singleton. It should be accessed by calling sharedInstance.
@interface CCDAPatientImporter : NSObject

// Encounter entries
//    //cda:section[cda:templateId/@root='2.16.840.1.113883.3.88.11.83.127']/cda:entry/cda:encounter
//
// Procedure entries
//    //cda:procedure[cda:templateId/@root='2.16.840.1.113883.10.20.1.29']
//
// Result entries - There seems to be some confusion around the correct templateId, so the code checks for both
//    //cda:observation[cda:templateId/@root='2.16.840.1.113883.3.88.11.83.15.1'] | //cda:observation[cda:templateId/@root='2.16.840.1.113883.3.88.11.83.15']
//
// Vital sign entries
//    //cda:observation[cda:templateId/@root='2.16.840.1.113883.3.88.11.83.14']
//
// Medication entries
//    //cda:section[cda:templateId/@root='2.16.840.1.113883.3.88.11.83.112']/cda:entry/cda:substanceAdministration
//
// Codes for medications are found in the substanceAdministration with the following relative XPath
//    ./cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code
//
// Condition entries
//    //cda:section[cda:templateId/@root='2.16.840.1.113883.3.88.11.83.103']/cda:entry/cda:act/cda:entryRelationship/cda:observation
//
// Codes for conditions are determined by examining the value child element as opposed to the code child element
//
// Social History entries (non-C32 section, specified in the HL7 CCD)
//    //cda:observation[cda:templateId/@root='2.16.840.1.113883.3.88.11.83.19']
//
// Care Goal entries(non-C32 section, specified in the HL7 CCD)
//    //cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.25']
//
// Allergy entries
//    //cda:observation[cda:templateId/@root='2.16.840.1.113883.10.20.1.18']
//
// Immunization entries
//    //cda:substanceAdministration[cda:templateId/@root='2.16.840.1.113883.10.20.1.24']
//
// Codes for immunizations are found in the substanceAdministration with the following relative XPath
//    ./cda:consumable/cda:manufacturedProduct/cda:manufacturedMaterial/cda:code
+ (CCDAPatientImporter *)sharedInstance;

// Parses a CCDA document and returns a populated Record object.
//
// @param [GDataXMLDocument] doc The parsed CCDA document representing the patient
// @return [HDSRecord] A Record object representing the patient, or null if there was an error.
- (HDSRecord *)parseCcda:(GDataXMLDocument *)doc;

// Inspects a CCDA document and populates the recprd with first name, last name
// birth date, gender and the effectiveTime.
//
// @param [HDSRecord] patient A hash that is used to represent the patient
// @param [GDataXMLDocument] doc The CCDA document parsed by GDataXML.
- (void)parseDemographics:(HDSRecord *)patient doc:(GDataXMLDocument *)doc;

// Create a simple representation of the patient from a HITSP C32
//
// @param [HDSRecord] record Patient model to which we will append Entry objects
// @param [GDataXMLDocument] doc The parsed CCDA document representing the patient
- (void)parseSections:(HDSRecord *)patient doc:(GDataXMLDocument *)doc;

// Checks the conditions to see if any of them have a cause of death set. If they do,
// it will set the expired field on the Record. This is done here rather than replacing
// the expried method on Record because other formats may actully tell you whether
// a patient is dead or not.
//
// @param [HDSRecord] patient to check the conditions on and set the expired property if applicable
- (void)checkForCauseOfDeath:(HDSRecord *)patient;

@end
