//
//  CDAConditionImporter.h
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import "CDASectionImporter.h"
#import "CDACondition.h"

@interface CDAConditionImporter : CDASectionImporter

@property (nonatomic, retain) NSString *ordinalityXpath;
@property (nonatomic, retain) NSString *providerXpath;

@end
