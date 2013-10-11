//
//  CDASectionImporter.m
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import "CDASectionImporter.h"
#import "CDADatum.h"

@implementation CDASectionImporter

- (CDASectionImporter *)init:(CDAEntryFinder *)finder; {
    CDASectionImporter *importer = [self init];
    
    if (importer) {
        self.entryFinder = finder;
        self.codeXpath = @"./cda:code";
        self.idXpath = @"./cda:id";
        self.statusXpath = NULL;
        self.priorityXpath = NULL;
        self.descriptionXpath = @"./cda:code/cda:originalText/cda:reference[@value] | ./cda:text/cda:reference[@value]";
        self.checkForUsable = TRUE;
        self.entryClass = [CDAEntry class];
    }
    
    return importer;
}

- (NSArray *)createEntries:(GDataXMLDocument *)doc nri:(CDANarrativeReferenceImporter *)nri {
    NSMutableArray *entryList = [[NSMutableArray alloc] init];
    NSArray *entryElements = [self.entryFinder entries:doc];
    //NSLog(@"initial entries: %@", entryElements);
    for (GDataXMLElement *entryElement in entryElements) {
        CDAEntry *entry = [self createEntry:entryElement nri:nri];
        if (self.checkForUsable) {
            if (entry.isUsable) [entryList addObject:entry];
        } else {
            [entryList addObject:entry];
        }
    }
    
    return entryList;
}

- (CDAEntry *)createEntry:(GDataXMLElement *)entryElement nri:(CDANarrativeReferenceImporter *)nri {
    CDAEntry *entry = [[CDAEntry alloc] init];
    
    return entry;
}

- (NSArray *)createData:(GDataXMLDocument *)doc nri:(CDANarrativeReferenceImporter *)nri {
    NSMutableArray *data = [NSMutableArray new];
    NSArray *entryElements = [self.entryFinder entries:doc];
    //NSLog(@"initial entries: %@", entryElements);
    for (GDataXMLElement *entryElement in entryElements) {
        //NSLog(@"NEW ELEMENT");
        [data addObject: [self createDatumWithNri:nri entryElement:entryElement]];
        //NSLog(@"ELEMENT ANALYSIS COMPLETE");
    }
    
    return data;
}

// @"//cda:section[cda:templateId/@root='2.16.840.1.113883.10.20.22.2.6.1']/cda:entry/cda:act/cda:entryRelationship/cda:observation"

/*
 @property (nonatomic, retain) NSString *name;
 @property (nonatomic, retain) NSString *value;
 @property (nonatomic, retain) NSMutableDictionary *attributes;
 @property (nonatomic, retain) NSMutableArray *children;
*/

/*
- (CDADatum *)createDatum:(GDataXMLDocument *)doc nri:(CDANarrativeReferenceImporter *)nri entryElement:(GDataXMLElement *)entryElement xPathString:(NSString *)entryXpath{
    //NSError *error;
    CDADatum *datum = [CDADatum new];
    NSLog(@"name: %@", entryElement.name);
    datum.name = entryElement.name;
    
    NSLog(@"attributes: %@", entryElement.attributes);
    for (GDataXMLNode *attribute in entryElement.attributes){
        [datum.attributes setValue:attribute.stringValue forKey:attribute.name];
    }
    
    NSMutableArray *datumChildren = [NSMutableArray new];
    for (GDataXMLNode *child in entryElement.children){
        NSString *nextEntry = [NSString stringWithFormat:@"%@/cda:%@", entryXpath, child.name];
        NSLog(@"------------------------");
        NSLog(@"nextName: %@", child.name);
        NSLog(@"nextEntry: %@", nextEntry);
        NSLog(@"nextElements: %@", [entryElement elementsForName:child.name]);
        
        [datumChildren addObject:[self createDatum:doc nri:nri entryElement:[[entryElement elementsForName:child.name] objectAtIndex:0]]];

        //GDataXMLElement *nextElement = [doc nodesForXPath:nextEntry namespaces:[CDAHelper namespaces] error:&error];
        //NSLog(@"thisElement = %@", [doc nodesForXPath:entryXpath namespaces:[CDAHelper namespaces] error:&error]);
        //NSLog(@"nextElement = %@", [doc nodesForXPath:nextEntry namespaces:[CDAHelper namespaces] error:&error]);
        //[self createDatum:doc nri:nri entryElement:nextElement];

    }
    NSLog(@"class: %@", [entryElement.children objectAtIndex:0]);
    NSLog(@"# of children: %u", [entryElement.children count]);
    NSLog(@"children: %@", entryElement.children);
    
    //CDAEntry *entry = [self createEntry:entryElement nri:nri];
    // if (self.checkForUsable) {
    // if (entry.isUsable) [entryList addObject:entry];
    // } else {
    // [entryList addObject:entry];
    // }
 
    return datum;
}
*/

- (CDADatum *)createDatumWithNri:(CDANarrativeReferenceImporter *)nri entryElement:(GDataXMLElement *)entryElement {
    //NSError *error;
    CDADatum *datum = [CDADatum new];
    
    //NSLog(@"name: %@", entryElement.name);
    datum.name = entryElement.name;
    datum.type = @"node";
    
    NSMutableDictionary *tempDictionary = [NSMutableDictionary new];
    for (GDataXMLNode *attribute in entryElement.attributes){
        //NSLog(@"attribute's name and stringValue: %@, %@", attribute.name, attribute.stringValue);
        [tempDictionary setValue:attribute.stringValue forKey:attribute.name];
    }
    datum.attributes = [NSDictionary dictionaryWithDictionary:tempDictionary];
    //NSLog(@"attributes: %@", datum.attributes);

    
    
    NSMutableArray *tempChildren = [NSMutableArray new];
    for (GDataXMLNode *child in entryElement.children){
        //NSLog(@"------------------------");
        //NSLog(@"nextName: %@", child.name);
        if([child.name isEqualToString:@"text"] || [child.name isEqualToString:@"comment"])
        {
            CDADatum *plainTextDatum = [CDADatum new];
            plainTextDatum.name = child.XMLString;
            plainTextDatum.type = child.name;
            plainTextDatum.attributes = [NSDictionary new];
            plainTextDatum.children = [NSArray new];
            [tempChildren addObject:plainTextDatum];
        }
        else {
            [tempChildren addObject:[self createDatumWithNri:nri entryElement:[[entryElement elementsForName:child.name] objectAtIndex:0]]];
        }
        
        //NSLog(@"nextElements: %@", [entryElement elementsForName:child.name]);
        
        //GDataXMLElement *nextElement = [doc nodesForXPath:nextEntry namespaces:[CDAHelper namespaces] error:&error];
        //NSLog(@"thisElement = %@", [doc nodesForXPath:entryXpath namespaces:[CDAHelper namespaces] error:&error]);
        //NSLog(@"nextElement = %@", [doc nodesForXPath:nextEntry namespaces:[CDAHelper namespaces] error:&error]);
        //[self createDatum:doc nri:nri entryElement:nextElement];
        
    }
    datum.children = [NSArray arrayWithArray:tempChildren];
    
        //NSLog(@"class: %@", [entryElement.children objectAtIndex:0]);
    //NSLog(@"# of children: %u", [entryElement.children count]);
    //NSLog(@"children: %@", entryElement.children);
    /*CDAEntry *entry = [self createEntry:entryElement nri:nri];
     if (self.checkForUsable) {
     if (entry.isUsable) [entryList addObject:entry];
     } else {
     [entryList addObject:entry];
     }
     */
    return datum;
}

/*
- (CDADatum *)createChildDatum:(GDataXMLDocument *)doc nri:(CDANarrativeReferenceImporter *)nri entryElement:(GDataXMLNode *)entryElement xPathString:(NSString *)entryXpath{
    CDADatum *datum = [CDADatum new];
    NSLog(@"name: %@", entryElement.name);
    datum.name = entryElement.name;
    
    NSLog(@"attributes: %@", entryElement.attributes);
    for (GDataXMLNode *attribute in entryElement.attributes){
        [datum.attributes setValue:attribute.stringValue forKey:attribute.name];
    }
    
    for (GDataXMLNode *child in entryElement.children){
        NSString *nextEntry = [NSString stringWithFormat:@"%@/cda:%@", entryXpath, child.name];
        NSLog(@"------------------------");
        NSLog(@"nextEntry: %@", nextEntry);
        NSLog(@"Starting from entryElement: %@", entryXpath);
        NSLog(@"Add to the end: /cda:%@", child.name);
        //[self createDatum:doc nri:nri entryElement:child];
        NSLog(@"------------------------");
    }
    NSLog(@"class: %@", [entryElement.children objectAtIndex:0]);
    NSLog(@"# of children: %u", [entryElement.children count]);
    NSLog(@"children: %@", entryElement.children);
    //CDAEntry *entry = [self createEntry:entryElement nri:nri];
     //if (self.checkForUsable) {
     //if (entry.isUsable) [entryList addObject:entry];
     //} else {
     //[entryList addObject:entry];
     }
     //
    return datum;
}
*/

@end
