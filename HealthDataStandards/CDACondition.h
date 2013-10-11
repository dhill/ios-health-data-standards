//
//  CDACondition.h
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import "CDASectionImporter.h"
#import "CDAEntry.h"

@interface CDACondition : CDAEntry

@property (nonatomic, assign) BOOL causeOfDeath;
@property (nonatomic, assign) NSTimeInterval timeOfDeath;

@end
