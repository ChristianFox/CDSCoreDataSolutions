//
//  CDSFetcherTests.m
//  CDSCoreDataSolutions
//
//  Created by Eyeye on 08/05/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//

@import XCTest;
#import <CDSCoreDataSolutions/CDSCoreDataStack.h>
#import <CDSCoreDataSolutions/CDSFetcher.h>

@interface CDSFetcherTests : XCTestCase
@property (strong, nonatomic) CDSFetcher *sut;
@property (strong,nonatomic) CDSCoreDataStack *stack;
@end



@implementation CDSFetcherTests
//======================================================
#pragma mark - ** Setup, Tear down **
//======================================================
- (void)setUp {
    [super setUp];
    self.sut = [CDSFetcher fetcherWithValidation:YES];
    self.stack = [CDSCoreDataStack sharedStack];
    
}

- (void)tearDown {
    self.sut = nil;
    self.stack = nil;
    [super tearDown];
}


//======================================================
#pragma mark - ** Test Initilisation **
//======================================================
-(void)testCanInitiliseSUT{
    
    XCTAssertNotNil(self.sut);
}

//======================================================
#pragma mark - ** Test Fetching All **
//======================================================
//--------------------------------------------------------
#pragma mark - -fetchAllWithEntityName: context: error:
//--------------------------------------------------------
- (void)testFetchAllManagedObjects_WithInvalidContext_ShouldReturnFALSE{
    
    NSError *error;
    NSManagedObjectContext *context;
    NSArray *matching = [self.sut fetchAllWithEntityName:@"Product"
                                                 context:context
                                                   error:&error];
    XCTAssertNil(matching);
    XCTAssertNotNil(error);
    
    // Test can handle nil error
    matching = [self.sut fetchAllWithEntityName:@"Product"
                                        context:context
                                          error:nil];
    XCTAssertNil(matching);
}

- (void)testFetchAllManagedObjects_WithInvalidEntityName_ShouldReturnFALSE{
    
    // GIVEN
    NSError *error;
    // WHEN
    NSArray *matching = [self.sut fetchAllWithEntityName:@"Poop"
                                                 context:self.stack.managedObjectContext
                                                   error:&error];
    // THEN
    XCTAssertNil(matching);
    XCTAssertNotNil(error);
}

- (void)testFetchAllManagedObjects_WithValidArguments_ShouldReturnArray{
    
    // GIVEN
    NSManagedObjectContext *context = self.stack.managedObjectContext;
    
    // WHEN
    NSError *error;
    NSArray *motorbikes = [self.sut fetchAllWithEntityName:@"Motorbike"
                                                   context:context
                                                     error:&error];
    // THEN
    XCTAssertNotNil(motorbikes);
    XCTAssertTrue(motorbikes.count > 0);
    XCTAssertNil(error);
    
    // WHEN
    NSArray *cars = [self.sut fetchAllWithEntityName:@"Car"
                                             context:context
                                               error:&error];
    // THEN
    XCTAssertNotNil(cars);
    XCTAssertTrue(cars.count > 0);
    XCTAssertNil(error);
    
    // WHEN
    NSArray *products = [self.sut fetchAllWithEntityName:@"Product"
                                                 context:context
                                                   error:&error];
    // THEN
    XCTAssertNotNil(products);
    XCTAssertTrue(products.count > 0);
    XCTAssertNil(error);
    
    // THEN final test
    NSUInteger totalProducts = cars.count + motorbikes.count;
    XCTAssertTrue(totalProducts == products.count);
}


//--------------------------------------------------------
#pragma mark - -fetchWithFetchRequest: context:
//--------------------------------------------------------
-(void)testFetchWithFetchRequest_WithValidFetchRequest_ShouldreturnArray{
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Motorbike"];
    request.fetchLimit = 2;
    
    NSError *error;
    
    NSArray *matching =
    [self.sut fetchWithFetchRequest:request
                            context:self.stack.managedObjectContext
                              error:&error];
    
    XCTAssertNotNil(matching);
    XCTAssertEqual(matching.count, 2);
    XCTAssertNil(error);
}



//--------------------------------------------------------
#pragma mark - -fetchFilteredWithPredicate: entityName: context:
//--------------------------------------------------------
-(void)testFetchWithPredicate_WithValidPredicate_ShouldReturnArray{
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K = %@",@"name",@"Bike 2"];
    
    NSError *error;
    
    NSArray *matching = [self.sut fetchFilteredWithPredicate:pred
                                                  entityName:@"Motorbike"
                                                     context:self.stack.managedObjectContext
                                                       error:&error];
    XCTAssertNotNil(matching);
    XCTAssertEqual(matching.count, 1);
    XCTAssertNil(error);
}



//--------------------------------------------------------
#pragma mark - -fetchFilteredByContainingString: atKeyPath: entityName: context:
//--------------------------------------------------------
-(void)testFetchFilteredByContainingString_WithValidString_ShouldReturnArray{
    
    NSString *subString = @"Car";
    NSError *error;
    NSArray *matching = [self.sut fetchFilteredByContainingString:subString
                                                        atKeyPath:@"name"
                                                        batchSize:2
                                                       fetchLimit:4
                                                       entityName:@"Car"
                                                          context:self.stack.managedObjectContext
                                                            error:&error];
    XCTAssertNotNil(matching);
    XCTAssertTrue(matching.count > 2);
    XCTAssertEqual(matching.count, 4);
    XCTAssertNil(error);
}




//--------------------------------------------------------
#pragma mark - -fetchMatchingAllObjects: atKeyPaths: entityName: context:
//--------------------------------------------------------
-(void)testFetchMatchingAllObjects_WithValidObjects_ShouldReturnArray{
    
    NSArray *objects = @[@"Bike 3",@"3 KM/h"];
    NSArray *keyPaths = @[@"name",@"blurb"];
    NSError *error;
    NSArray *matching = [self.sut fetchMatchingAllObjects:objects
                                               atKeyPaths:keyPaths
                                               entityName:@"Motorbike"
                                                  context:self.stack.managedObjectContext
                                                    error:&error];
    XCTAssertNotNil(matching);
    XCTAssertEqual(matching.count, 1);
    XCTAssertNil(error);
}


//--------------------------------------------------------
#pragma mark - -fetchMatchingAnyObjects: atKeyPaths: entityName: context:
//--------------------------------------------------------
-(void)testFetchMatchingAnyObjects_WithValidObjects_ShouldReturnArray{
    
    NSArray *objects = @[@"Bike 3",@"4 KM/h"];
    NSArray *keyPaths = @[@"name",@"blurb"];
    NSError *error;
    NSArray *matching = [self.sut fetchMatchingAnyObjects:objects
                                               atKeyPaths:keyPaths
                                               entityName:@"Motorbike"
                                                  context:self.stack.managedObjectContext
                                                    error:&error];
    XCTAssertNotNil(matching);
    XCTAssertEqual(matching.count, 2);
    XCTAssertNil(error);
}






















@end
