//
//  MFAlertViewTests.m
//  MFAlertViewTests
//
//  Created by moflo on 7/18/14.
//  Copyright (c) 2014 Mobile Flow LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MF_UIAlertView.h"

@interface MFAlertViewTests : XCTestCase

@end

@implementation MFAlertViewTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreation
{
    MF_UIAlertView *alert = [[MF_UIAlertView alloc] initWithTitle:@"test" message:@"test" delegate:nil cancelButtonTitle:@"test" otherButtonTitles:nil];
    
    XCTAssertNil(alert, @"MF_UIAlertView is nil");
}

@end
