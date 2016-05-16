//
//  CDSCoreDataStackContextTests.m
//  CDSCoreDataSolutions
//
//  Created by Eyeye on 07/05/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//

@import XCTest;
#import <CDSCoreDataSolutions/CDSCoreDataStack.h>
#import <CDSCoreDataSolutions/CDSManagedObjectModelDescriptor.h>
#import <CDSCoreDataSolutions/CDSPersistentStoreDescriptor.h>
#import "CDSManagedObjectBuilder.h"


@interface CDSCoreDataStackContextTests : XCTestCase

@end

@implementation CDSCoreDataStackContextTests

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
#pragma mark - ** Test Insert objects **
//======================================================
-(void)testInsertBusinessObjectsAndSaveContext_WithBusinessModel_ShouldInsertAndSaveThenGet{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with success."];
    
    // GIVEN
    CDSCoreDataStack *stack = [[CDSCoreDataStack alloc]init];
    CDSManagedObjectModelDescriptor *modelDescriptor = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    modelDescriptor.name = @"BusinessModel";
    
    [stack configureStackWithModelDescriptors:@[modelDescriptor]
                             storeDescriptors:nil
                                   completion:^(BOOL success, NSError *error)
     {

         // WHEN - build & insert
         [CDSManagedObjectBuilder buildAndInsertBusinesses:10
                                               intoContext:stack.managedObjectContext];
         
         
         // WHEN - save
         [stack saveWithCompletion:^(BOOL success, NSError *error) {
             
             // THEN
             XCTAssertTrue(success);
             XCTAssertNil(error);
             
             // THEN - should be able to clear context and fetch
             [stack clearContextWithCompletion:nil];
             
             NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Business"];
             
             NSArray *matching = [stack.managedObjectContext executeFetchRequest:request
                                                                           error:nil];
             XCTAssertTrue(matching.count >= 10);
             [expectation fulfill];

         }];
     }];
    
    // Wait
    [self waitForExpectationsWithTimeout:15.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}

-(void)testInsertAnimalObjectsAndSaveContext_WithAnimalModel_ShouldInsertAndSaveThenGet{
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with success."];
    
    // GIVEN
    CDSCoreDataStack *stack = [[CDSCoreDataStack alloc]init];
    CDSManagedObjectModelDescriptor *modelDescriptor = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    modelDescriptor.name = @"AnimalModel";
    
    [stack configureStackWithModelDescriptors:@[modelDescriptor]
                             storeDescriptors:nil
                                   completion:^(BOOL success, NSError *error)
     {
         
         // WHEN - build & insert
         [CDSManagedObjectBuilder buildAndInsertPrimates:10
                                               intoContext:stack.managedObjectContext];
         
         
         // WHEN - save
         [stack saveWithCompletion:^(BOOL success, NSError *error) {
             
             // THEN
             XCTAssertTrue(success);
             XCTAssertNil(error);
             
             // THEN - should be able to clear context and fetch
             [stack clearContextWithCompletion:nil];
             
             NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Primate"];
             
             NSArray *matching = [stack.managedObjectContext executeFetchRequest:request
                                                                           error:nil];
             XCTAssertTrue(matching.count >= 10);
             [expectation fulfill];
             
         }];
     }];
    
    // Wait
    [self waitForExpectationsWithTimeout:15.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}


-(void)testInsertAnimalAndBusinessObjectsAndSaveContext_WithTwoModels_ShouldInsertAndSaveThemToTheSameStoreBecauseConfiguationIsNotSet{
    
    /*
     The primary purpose of this test is to test that the data is saved to two different stores. To check requires navigating in the finder and viewing the sqlite files. 
     The thing I had missed was setting the configuation in the model and in the store descriptor. Before doing this the data was not being split correctly between the two stores (all data would go in one store).
     
     Here I don't set the configuaration property whereas in the test below I do.
     */
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with success."];
    
    // GIVEN
    CDSCoreDataStack *stack = [[CDSCoreDataStack alloc]init];
    CDSManagedObjectModelDescriptor *modelDescriptorBiz = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    modelDescriptorBiz.name = @"BusinessModel";
    CDSPersistentStoreDescriptor *storeDescriptorBiz = [CDSPersistentStoreDescriptor persistentStoreDescriptor];
    storeDescriptorBiz.name = @"BusinessStore5-noConfiguration";
    CDSManagedObjectModelDescriptor *modelDescriptorAnimal = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    modelDescriptorAnimal.name = @"AnimalModel";
    CDSPersistentStoreDescriptor *storeDescriptorAnimal = [CDSPersistentStoreDescriptor persistentStoreDescriptor];
    storeDescriptorAnimal.name = @"AnimalStore5-noConfiguration";
    
    [stack configureStackWithModelDescriptors:@[modelDescriptorBiz,modelDescriptorAnimal]
                             storeDescriptors:@[storeDescriptorBiz,storeDescriptorAnimal]
                                   completion:^(BOOL success, NSError *error)
     {
         
         // WHEN - build & insert
         [CDSManagedObjectBuilder buildAndInsertPrimates:10
                                             intoContext:stack.managedObjectContext];
         [CDSManagedObjectBuilder buildAndInsertBusinesses:10
                                               intoContext:stack.managedObjectContext];
         
         // WHEN - save
         [stack saveWithCompletion:^(BOOL success, NSError *error) {
             
             // THEN
             XCTAssertTrue(success);
             XCTAssertNil(error);
             
             // THEN - should be able to clear context and fetch
             [stack clearContextWithCompletion:nil];
             
             NSFetchRequest *request1 = [NSFetchRequest fetchRequestWithEntityName:@"Primate"];
             NSArray *matching1 = [stack.managedObjectContext executeFetchRequest:request1
                                                                           error:nil];
             XCTAssertTrue(matching1.count >= 10);
             NSFetchRequest *request2 = [NSFetchRequest fetchRequestWithEntityName:@"Business"];
             NSArray *matching2 = [stack.managedObjectContext executeFetchRequest:request2
                                                                            error:nil];
             XCTAssertTrue(matching2.count >= 10);

             [expectation fulfill];
             
         }];
     }];
    
    // Wait
    [self waitForExpectationsWithTimeout:15.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}


-(void)testInsertAnimalAndBusinessObjectsAndSaveContext_WithTwoModels_ShouldInsertAndSaveThemToTwoDifferentStores{
    
    /*
     The primary purpose of this test is to test that the data is saved to two different stores. To check requires navigating in the finder and viewing the sqlite files.
     Before doing this the data was not being split correctly between the two stores (all data would go in one store). The thing I had missed was setting the configuation in the model and in the store descriptor.
     
     Here I set the configuration property but in the test above I do not.
     */
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with success."];
    
    // GIVEN
    CDSCoreDataStack *stack = [[CDSCoreDataStack alloc]init];
    CDSManagedObjectModelDescriptor *modelDescriptorBiz = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    modelDescriptorBiz.name = @"BusinessModel";
    CDSPersistentStoreDescriptor *storeDescriptorBiz = [CDSPersistentStoreDescriptor persistentStoreDescriptor];
    storeDescriptorBiz.name = @"BusinessStore6-ConfigurationSet";
    storeDescriptorBiz.configuration = @"MainBusinessConfig";
    CDSManagedObjectModelDescriptor *modelDescriptorAnimal = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    modelDescriptorAnimal.name = @"AnimalModel";
    CDSPersistentStoreDescriptor *storeDescriptorAnimal = [CDSPersistentStoreDescriptor persistentStoreDescriptor];
    storeDescriptorAnimal.name = @"AnimalStore6-ConfigurationSet";
    storeDescriptorAnimal.configuration = @"MainAnimalConfig";
    
    [stack configureStackWithModelDescriptors:@[modelDescriptorBiz,modelDescriptorAnimal]
                             storeDescriptors:@[storeDescriptorBiz,storeDescriptorAnimal]
                                   completion:^(BOOL success, NSError *error)
     {
         
         // WHEN - build & insert
         [CDSManagedObjectBuilder buildAndInsertPrimates:10
                                             intoContext:stack.managedObjectContext];
         [CDSManagedObjectBuilder buildAndInsertBusinesses:10
                                               intoContext:stack.managedObjectContext];
         
         // WHEN - save
         [stack saveWithCompletion:^(BOOL success, NSError *error) {
             
             // THEN
             XCTAssertTrue(success);
             XCTAssertNil(error);
             
             // THEN - should be able to clear context and fetch
             [stack clearContextWithCompletion:nil];
             
             NSFetchRequest *request1 = [NSFetchRequest fetchRequestWithEntityName:@"Primate"];
             NSArray *matching1 = [stack.managedObjectContext executeFetchRequest:request1
                                                                            error:nil];
             XCTAssertTrue(matching1.count >= 10);
             NSFetchRequest *request2 = [NSFetchRequest fetchRequestWithEntityName:@"Business"];
             NSArray *matching2 = [stack.managedObjectContext executeFetchRequest:request2
                                                                            error:nil];
             XCTAssertTrue(matching2.count >= 10);
             
             [expectation fulfill];
             
         }];
     }];
    
    // Wait
    [self waitForExpectationsWithTimeout:15.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}



@end
