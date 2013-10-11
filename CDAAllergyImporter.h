//
//  CDAAllergyImporter.h
//  HealthDataStandards
//
//  Created by Saltzman, Shep on 5/21/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CDASectionImporter.h"
#import "CDACondition.h"

@interface CDAAllergyImporter : CDASectionImporter

@property (nonatomic, retain) NSString *ordinalityXpath;
@property (nonatomic, retain) NSString *providerXpath;

@end
