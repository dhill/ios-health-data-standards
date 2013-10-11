//
//  CDAVitalSignsImporter.h
//  HealthDataStandards
//
//  Created by Saltzman, Shep on 8/29/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import "CDASectionImporter.h"

#import "CDASectionImporter.h"
#import "CDACondition.h"

@interface CDAVitalSignsImporter : CDASectionImporter

@property (nonatomic, retain) NSString *ordinalityXpath;
@property (nonatomic, retain) NSString *providerXpath;

@end
