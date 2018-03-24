
@import XCTest;
#import <CDSCoreDataSolutions/CDSCoreDataStack.h>
#import <CDSCoreDataSolutions/CDSPersistentStoreDescriptor.h>


@interface CDSCoreDataStackCoordinatorTests : XCTestCase

@end

@implementation CDSCoreDataStackCoordinatorTests


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
#pragma mark - ** Test Delete Stores **
//======================================================
-(void)testDeletePersistentStore_WithMatchingDescriptor_ShouldDeleteStore{

    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with success and file should have been deleted"];
    
    // GIVEN
    CDSCoreDataStack *stack = [[CDSCoreDataStack alloc]init];
    CDSPersistentStoreDescriptor *storeDescriptor = [CDSPersistentStoreDescriptor persistentStoreDescriptorWithName:@"StoreToDelete1"];
    [stack configureStackWithModelDescriptors:nil
                             storeDescriptors:@[storeDescriptor]
                                   completion:^(BOOL success, NSError *error)
    {
        // Check store exists in file system
        XCTAssertTrue([[NSFileManager defaultManager]fileExistsAtPath:[storeDescriptor.URL path]]);
        
        
        // WHEN
        [stack deletePersistentStoreWithURL:storeDescriptor.URL
                                    withCompletion:^(BOOL success, NSError *error)
        {
            // THEN
            XCTAssertTrue(success);
            XCTAssertNil(error,@"<ERROR> %@",error.localizedDescription);
            XCTAssertFalse([[NSFileManager defaultManager]fileExistsAtPath:[storeDescriptor.URL path]]);
            [expectation fulfill];
        }];
        
    }];
    
    
    // Wait
    [self waitForExpectationsWithTimeout:5.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];
}

-(void)testDeleteAllPersistentStores_WithMultipleStores_ShouldDeleteAll{
    
    
    // Expect
    XCTestExpectation *expectation = [self expectationWithDescription:@"Should have completed with success and deleted all stores"];
    
    // GIVEN
    CDSCoreDataStack *stack = [[CDSCoreDataStack alloc]init];
    CDSPersistentStoreDescriptor *storeDescriptor1 = [CDSPersistentStoreDescriptor persistentStoreDescriptorWithName:@"StoreToDelete1"];
    CDSPersistentStoreDescriptor *storeDescriptor2 = [CDSPersistentStoreDescriptor persistentStoreDescriptorWithName:@"StoreToDelete2"];
    CDSPersistentStoreDescriptor *storeDescriptor3 = [CDSPersistentStoreDescriptor persistentStoreDescriptorWithName:@"StoreToDelete3"];

    [stack configureStackWithModelDescriptors:nil
                             storeDescriptors:@[storeDescriptor1,storeDescriptor2,storeDescriptor3]
                                   completion:^(BOOL success, NSError *error)
     {
         // Check store exists in file system
         XCTAssertTrue([[NSFileManager defaultManager]fileExistsAtPath:[storeDescriptor1.URL path]]);
         XCTAssertTrue([[NSFileManager defaultManager]fileExistsAtPath:[storeDescriptor2.URL path]]);
         XCTAssertTrue([[NSFileManager defaultManager]fileExistsAtPath:[storeDescriptor3.URL path]]);

         
         // WHEN
         [stack deleteAllPersistentStoresWithCompletion:^(BOOL success, NSError *error)
          {
              // THEN
              XCTAssertTrue(success);
              XCTAssertNil(error,@"<ERROR> %@",error.localizedDescription);
              XCTAssertFalse([[NSFileManager defaultManager]fileExistsAtPath:[storeDescriptor1.URL path]]);
              XCTAssertFalse([[NSFileManager defaultManager]fileExistsAtPath:[storeDescriptor2.URL path]]);
              XCTAssertFalse([[NSFileManager defaultManager]fileExistsAtPath:[storeDescriptor3.URL path]]);
              [expectation fulfill];
          }];
         
     }];
    
    
    
    // Wait
    [self waitForExpectationsWithTimeout:10.0f handler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"### ERROR ### : %@",error.localizedDescription);
        }
    }];

    
}





@end
