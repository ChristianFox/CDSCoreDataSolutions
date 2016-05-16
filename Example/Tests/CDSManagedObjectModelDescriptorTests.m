//
//  CDSManagedObjectModelDescriptorTests.m
//  CDSCoreDataSolutions
//
//  Created by Eyeye on 07/05/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//

@import XCTest;
#import "CDSManagedObjectModelDescriptor.h"


@interface CDSManagedObjectModelDescriptorTests : XCTestCase
@property (strong, nonatomic) CDSManagedObjectModelDescriptor *sut;

@end

@implementation CDSManagedObjectModelDescriptorTests


//======================================================
#pragma mark - ** Setup, Tear down **
//======================================================
- (void)setUp {
    [super setUp];
    self.sut = [[CDSManagedObjectModelDescriptor alloc]init];
    
}

- (void)tearDown {
    self.sut = nil;
    
    [super tearDown];
}


//======================================================
#pragma mark - ** Test Initilisation **
//======================================================
-(void)testCanInitiliseSUT{
    
    XCTAssertNotNil(self.sut);
}


//======================================================
#pragma mark - ** Test Default Properties **
//======================================================
-(void)testGetModelURL_WhenNoModelName_ShouldReturnNil{
    
    XCTAssertNil(self.sut.URL);
    
}



@end
