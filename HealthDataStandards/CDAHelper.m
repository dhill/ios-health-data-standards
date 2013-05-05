//
//  CDAHelper.m
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 abgoldstein industries. All rights reserved.
//

#import "CDAHelper.h"

@implementation CDAHelper

static NSDictionary *cdaNamespaces;

+ (void)initialize {
    if (!cdaNamespaces) { cdaNamespaces = @{@"cda": @"urn:hl7-org:v3"}; }
}

+ (NSDictionary *)namespaces {
    return cdaNamespaces;
}

+ (CDAAddress *)parseAddress:(GDataXMLElement *)addressElement {
    NSError *error;
    CDAAddress *address = [[CDAAddress alloc] init];
    
    // Use
    address.use = [[addressElement attributeForName:@"use"] stringValue];
    
    // Country
    NSArray *countryNodes = [addressElement nodesForXPath:@"./cda:country" namespaces:cdaNamespaces error:&error];
    if ([countryNodes count] > 0) address.country = [countryNodes[0] stringValue];
    
    // Postal Code
    NSArray *postalNodes = [addressElement nodesForXPath:@"./cda:postalCode" namespaces:cdaNamespaces error:&error];
    if ([postalNodes count] > 0) address.zip = [postalNodes[0] stringValue];
    
    // State
    NSArray *stateNodes = [addressElement nodesForXPath:@"./cda:state" namespaces:cdaNamespaces error:&error];
    if ([stateNodes count] > 0) address.state = [stateNodes[0] stringValue];
    
    // City
    NSArray *cityNodes = [addressElement nodesForXPath:@"./cda:city" namespaces:cdaNamespaces error:&error];
    if ([cityNodes count] > 0) address.city = [cityNodes[0] stringValue];
    
    // Street
    NSArray *streetNodes = [addressElement nodesForXPath:@"./cda:streetAddressLine" namespaces:cdaNamespaces error:&error];
    NSMutableArray *streetParts = [[NSMutableArray alloc] init];
    for (GDataXMLNode *streetNode in streetNodes) {
        [streetParts addObject:[streetNode stringValue]];
    }
    address.street = streetParts;
    
    
    return address;
}

+ (CDATelecom *)parseTelecom:(GDataXMLElement *)telecomElement {
    CDATelecom *telecom = [[CDATelecom alloc] init];
    
    telecom.value = [[telecomElement attributeForName:@"value"] stringValue];
    telecom.use = [[telecomElement attributeForName:@"use"] stringValue];
    
    return telecom;
}

@end
