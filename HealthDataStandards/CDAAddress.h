//
//  CDAAddress.h
//  HealthDataStandards
//
//  Created by Adam on 5/2/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface CDAAddress : NSObject

@property (nonatomic, retain) NSString *use;
@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSArray *street;

@end
