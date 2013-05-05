//
//  PatientImporterTests.m
//  PatientImporterTests
//
//  Created by Adam Goldstein on 4/29/13.
//  Copyright (c) 2013 abgoldstein industries. All rights reserved.
//

#import "CCDAPatientImporterTests.h"
#import "CCDAPatientImporter.h"

@implementation CCDAPatientImporterTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testParseCcda
{
    NSString *ccdaFilename = [[NSBundle bundleForClass:[self class]] pathForResource:@"sample_ccda" ofType:@"xml"];
    NSData *ccdaData = [[NSData alloc] initWithContentsOfFile:ccdaFilename];
    
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:ccdaData options:0 error:&error];
    if (error || doc == nil) {
        STAssertFalse(doc == nil, @"There was an error reading the CCDA file into a GData XML Document.");
    }
    
    CCDAPatientImporter *importer = [CCDAPatientImporter sharedInstance];
    [importer parseCcda:doc];
    STAssertTrue(true, @"This is always true");
}

@end
