//
//  CDADatum.m
//  HealthDataStandards
//
//  Created by Saltzman, Shep on 6/20/13.
//  Copyright (c) 2013 The MITRE Corporation. All rights reserved.
//

#import "CDADatum.h"

@implementation CDADatum

-(void)printAll {
    [self printSelfWithDepth:0];
}

-(void)printSelfWithDepth:(int)depth {
    NSString *padding = [@"" stringByPaddingToLength:depth*3 withString: @" " startingAtIndex:0];
    NSString *displayString;
    if ([self.type isEqualToString:@"node"]) {
        NSMutableString *attributes = [NSMutableString new];
        for (id key in self.attributes){
            [attributes appendFormat:@"%@=\"%@\" ", key, [self.attributes objectForKey:key]];
        }
        if ([self.children count] == 0){
            displayString = [NSString stringWithFormat:@"%@%@ %@", padding, self.name, attributes];
        }
        else {
            displayString = [NSString stringWithFormat:@"%@%@ %@", padding, self.name, attributes];
        }
    }
    else {
        displayString = [NSString stringWithFormat:@"%@%@", padding, self.name];
    }
    NSLog(@"%@", displayString);
    for (CDADatum *child in self.children){
        [child printSelfWithDepth:(depth+1)];
    }
}

-(void)printAllXML {
    [self printXMLWithDepth:0];
}

-(void)printXMLWithDepth:(int)depth {
    NSString *padding = [@"" stringByPaddingToLength:depth*3 withString: @" " startingAtIndex:0];
    NSString *displayString;
    if ([self.type isEqualToString:@"node"]) {
        NSMutableString *attributes = [NSMutableString new];
        for (id key in self.attributes){
            [attributes appendFormat:@"%@=\"%@\" ", key, [self.attributes objectForKey:key]];
        }
        if ([self.children count] == 0){
            displayString = [NSString stringWithFormat:@"%@<%@ %@/>", padding, self.name, attributes];
        }
        else {
            displayString = [NSString stringWithFormat:@"%@<%@ %@>", padding, self.name, attributes];
        }
    }
    else {
        displayString = [NSString stringWithFormat:@"%@%@", padding, self.name];
    }
    NSLog(@"%@", displayString);
    for (CDADatum *child in self.children){
        [child printXMLWithDepth:(depth+1)];
    }
    if ([self.children count] != 0){
        NSLog(@"%@</%@>", padding, self.name);
    }
}

@end
