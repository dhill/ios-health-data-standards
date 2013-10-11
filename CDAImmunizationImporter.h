//
//  CDAImmunizationImporter.h
//  HealthDataStandards
//
//  Created by Saltzman, Shep on 5/22/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import "CDASectionImporter.h"

#import "CDASectionImporter.h"
#import "CDACondition.h"

@interface CDAImmunizationImporter : CDASectionImporter

@property (nonatomic, retain) NSString *ordinalityXpath;
@property (nonatomic, retain) NSString *providerXpath;


@end
