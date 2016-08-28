//
//  CDSCoreDataStackTests.m
//  CDSCoreDataSolutions
//
//  Created by Eyeye on 07/05/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//

@import XCTest;
#import <CDSCoreDataSolutions/CDSCoreDataStack.h>
#import <CDSCoreDataSolutions/CDSManagedObjectModelDescriptor.h>
#import <CDSCoreDataSolutions/CDSPersistentStoreDescriptor.h>

@interface CDSCoreDataStackCreationTests : XCTestCase


@end



@implementation CDSCoreDataStackCreationTests

//======================================================
#pragma mark - ** Setup, Tear down **
//======================================================
- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}


//======================================================
#pragma mark - ** Test Initilisation **
//======================================================
-(void)testCanInitiliseSUT{
    
    XCTAssertNotNil([[CDSCoreDataStack alloc]init]);
}

-(void)testCanInitiliseSharedStack{
    
    XCTAssertNotNil([CDSCoreDataStack sharedStack]);
}


-(void)testStackPropertiesAreNilWhenConfigureStackHasNotBeenCalled{
    
    CDSCoreDataStack *stack = [[CDSCoreDataStack alloc]init];

    XCTAssertNil(stack.managedObjectModel);
    XCTAssertNil(stack.mainQueueContext);
    XCTAssertNil(stack.persistentStoreCoordinator);
}



//======================================================
#pragma mark - ** Test Stack Configuration **
//======================================================
-(void)testStackCanBeConfigured_WithNilDescriptors_ShouldCompleteWithSuccessAndCreateStack{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with success."];
    
    // GIVEN
    CDSCoreDataStack *stack = [[CDSCoreDataStack alloc]init];
    
    
    // WHEN
    [stack configureStackWithModelDescriptors:nil
                             storeDescriptors:nil
                                   completion:^(BOOL success, NSError *error)
    {
        // THEN
        XCTAssertNil(error);
        XCTAssertTrue(success);
        XCTAssertNotNil(stack.mainQueueContext);
        XCTAssertNotNil(stack.managedObjectModel);
        XCTAssertNotNil(stack.persistentStoreCoordinator);
        [expectation fulfill];
    }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}


-(void)testStackCanBeConfigured_WithModelDescriptor_ShouldCompleteWithSuccessAndCreateStack{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with success."];
    
    // GIVEN
    CDSCoreDataStack *stack = [[CDSCoreDataStack alloc]init];
    CDSManagedObjectModelDescriptor *modelDescriptor = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    modelDescriptor.name = @"BusinessModel";

    // WHEN
    [stack configureStackWithModelDescriptors:@[modelDescriptor]
                             storeDescriptors:nil
                                   completion:^(BOOL success, NSError *error)
     {
         // THEN
         XCTAssertNil(error);
         XCTAssertTrue(success);
         XCTAssertNotNil(stack.mainQueueContext);
         XCTAssertNotNil(stack.managedObjectModel);
         XCTAssertNotNil(stack.persistentStoreCoordinator);
         [expectation fulfill];
     }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}

-(void)testStackCanBeConfigured_WithSingleModelAndStoreDescriptors_ShouldCompleteWithSuccessAndCreateStack{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with success."];
    
    // GIVEN
    CDSCoreDataStack *stack = [[CDSCoreDataStack alloc]init];
    CDSManagedObjectModelDescriptor *modelDescriptor = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    modelDescriptor.name = @"BusinessModel";
    CDSPersistentStoreDescriptor *storeDescriptor = [CDSPersistentStoreDescriptor persistentStoreDescriptor];
    storeDescriptor.name = @"BusinessStore1";

    
    // WHEN
    [stack configureStackWithModelDescriptors:@[modelDescriptor]
                             storeDescriptors:@[storeDescriptor]
                                   completion:^(BOOL success, NSError *error)
     {
         // THEN
         XCTAssertNil(error);
         XCTAssertTrue(success);
         XCTAssertNotNil(stack.mainQueueContext);
         XCTAssertNotNil(stack.managedObjectModel);
         XCTAssertNotNil(stack.persistentStoreCoordinator);
         [expectation fulfill];
     }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}


-(void)testStackCanBeConfigured_WithMultipleModelAndStoreDescriptors_ShouldCompleteWithSuccessAndCreateStack{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with success."];
    
    // GIVEN
    CDSCoreDataStack *stack = [[CDSCoreDataStack alloc]init];
    CDSManagedObjectModelDescriptor *modelDescriptorBiz = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    modelDescriptorBiz.name = @"BusinessModel";
    CDSPersistentStoreDescriptor *storeDescriptorBiz = [CDSPersistentStoreDescriptor persistentStoreDescriptor];
    storeDescriptorBiz.name = @"BusinessStore2";
    CDSManagedObjectModelDescriptor *modelDescriptorAnimal = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    modelDescriptorAnimal.name = @"AnimalModel";
    CDSPersistentStoreDescriptor *storeDescriptorAnimal = [CDSPersistentStoreDescriptor persistentStoreDescriptor];
    storeDescriptorAnimal.name = @"AnimalStore1";

    
    // WHEN
    [stack configureStackWithModelDescriptors:@[modelDescriptorBiz,modelDescriptorAnimal]
                             storeDescriptors:@[storeDescriptorBiz,storeDescriptorAnimal]
                                   completion:^(BOOL success, NSError *error)
     {
         // THEN
         XCTAssertNil(error);
         XCTAssertTrue(success);
         XCTAssertNotNil(stack.mainQueueContext);
         XCTAssertNotNil(stack.managedObjectModel);
         XCTAssertNotNil(stack.persistentStoreCoordinator);
         [expectation fulfill];
     }];
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}















@end
