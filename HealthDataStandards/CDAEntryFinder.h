//
//  CDAEntryFinder.h
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "CDAHelper.h"

@interface CDAEntryFinder : NSObject

@property (nonatomic, retain) NSString *entryXpath;

- (CDAEntryFinder *)init:(NSString *)xpath;
- (NSArray *)entries:(GDataXMLDocument *)doc;


@end
