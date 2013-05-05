//
//  CDAHelper.h
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 abgoldstein industries. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "CDAAddress.h"
#import "CDATelecom.h"

@interface CDAHelper : NSObject

+ (NSDictionary *)namespaces;

+ (CDAAddress *)parseAddress:(GDataXMLNode *)addressNode;

+ (CDATelecom *)parseTelecom:(GDataXMLNode *)telecomNode;

@end
