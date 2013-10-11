//
//  CDADatum.h
//  HealthDataStandards
//
//  Created by Saltzman, Shep on 6/20/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDADatum : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSDictionary *attributes;
@property (nonatomic, retain) NSArray *children;

-(void)printAll;
//-(void)printSelfWithDepth:(int)depth;

-(void)printAllXML;
//-(void)printXMLWithDepth:(int)depth;

@end
