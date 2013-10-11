//
//  CDATelecom.h
//  HealthDataStandards
//
//  Created by Adam on 5/3/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDATelecom : NSObject

@property (nonatomic, retain) NSString *use;
@property (nonatomic, retain) NSString *value;
@property (nonatomic, assign) BOOL *preferred;

@end
