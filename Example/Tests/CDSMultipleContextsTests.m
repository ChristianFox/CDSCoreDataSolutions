


#import <XCTest/XCTest.h>
#import <CDSCoreDataSolutions/CDSCoreDataSolutions.h>
#import <CDSCoreDataSolutions/CDSCoreDataStack+ForUnitTesting.h>
#import "Business.h"
#import "Car.h"


@interface CDSMultipleContextsTests : XCTestCase

@property (strong,nonatomic) CDSCoreDataStack *stack;

@end

@implementation CDSMultipleContextsTests

- (void)setUp {
    [super setUp];
    self.stack = [CDSCoreDataStack sharedStack];
    
    CDSFetcher *fetcher = [CDSFetcher fetcher];
    NSArray *businesses = [fetcher fetchFilteredByContainingString:@"Queue Context Biz"
                                                         atKeyPath:@"name"
                                                        entityName:@"Business"
                                                           context:self.stack.mainQueueContext
                                                             error:nil];
    NSArray *cars = [fetcher fetchFilteredByContainingString:@"Queue Context Car"
                                                   atKeyPath:@"name"
                                                  entityName:@"Car"
                                                     context:self.stack.mainQueueContext
                                                       error:nil];
    for (Business *aBiz in businesses) {
        [self.stack.mainQueueContext deleteObject:aBiz];
    }
    for (Car *aCar in cars) {
        [self.stack.mainQueueContext deleteObject:aCar];
    }
    
    [self.stack saveWithCompletion:nil];

}

- (void)tearDown {

    
    [super tearDown];
}


//--------------------------------------------------------
#pragma mark - Test Init
//--------------------------------------------------------
-(void)testStackIsInitilised{
    
    XCTAssertNotNil(self.stack);
}


//--------------------------------------------------------
#pragma mark - Test Contexts on their own
//--------------------------------------------------------
-(void)testMainQueueContext{
    
    // Get mainQ context
    NSManagedObjectContext *context = self.stack.mainQueueContext;
    
    // Create two man objs
    NSEntityDescription *entityBiz = [NSEntityDescription entityForName:@"Business" inManagedObjectContext:context];
    Business *aBiz = [[Business alloc]initWithEntity:entityBiz insertIntoManagedObjectContext:context];
    aBiz.name = @"Main Queue Context Biz";
    aBiz.employees = @99;
    
    NSEntityDescription *entityCar = [NSEntityDescription entityForName:@"Car" inManagedObjectContext:context];
    Car *aCar = [[Car alloc]initWithEntity:entityCar insertIntoManagedObjectContext:context];
    aCar.name = @"Main Queue Context Car";
    aCar.priceInPence = @2999900;
    aCar.business = aBiz;
    
    // Fetch
    CDSFetcher *fetcher = [CDSFetcher fetcher];
    NSArray *businesses = [fetcher fetchFilteredByContainingString:@"Main Queue"
                                                         atKeyPath:@"name"
                                                        entityName:@"Business"
                                                           context:context
                                                             error:nil];
    NSArray *cars = [fetcher fetchFilteredByContainingString:@"Main Queue"
                                                         atKeyPath:@"name"
                                                        entityName:@"Car"
                                                           context:context
                                                             error:nil];
    XCTAssertEqual(businesses.count, 1);
    XCTAssertEqual(cars.count, 1);
    Business *fetchedBiz = businesses.firstObject;
    Car *fetchedCar = cars.firstObject;
    
    XCTAssertEqualObjects(fetchedBiz, aBiz);
    XCTAssertEqualObjects(fetchedCar, aCar);
    XCTAssertEqualObjects(fetchedBiz, aCar.business);
    
    // Save so the new objects are persisted to the store
    [context save:nil];
    // Then clear the context
    [self.stack clearMainQueueContextWithCompletion:nil];
    
    // Now if we fetch we should still get 1 of each object
    businesses = [fetcher fetchFilteredByContainingString:@"Main Queue"
                                                atKeyPath:@"name"
                                               entityName:@"Business"
                                                  context:context
                                                    error:nil];
    cars = [fetcher fetchFilteredByContainingString:@"Main Queue"
                                          atKeyPath:@"name"
                                         entityName:@"Car"
                                            context:context
                                              error:nil];
    XCTAssertEqual(businesses.count, 1);
    XCTAssertEqual(cars.count, 1);
    
    // Now we should be able to delete them both
    [context deleteObject:aBiz];
    [context deleteObject:aCar];
    
    // Then save
    [context save:nil];
    
    // Now if we fetch we should  get 0 of each object
    businesses = [fetcher fetchFilteredByContainingString:@"Main Queue"
                                                atKeyPath:@"name"
                                               entityName:@"Business"
                                                  context:context
                                                    error:nil];
    cars = [fetcher fetchFilteredByContainingString:@"Main Queue"
                                          atKeyPath:@"name"
                                         entityName:@"Car"
                                            context:context
                                              error:nil];
    XCTAssertEqual(businesses.count, 0);
    XCTAssertEqual(cars.count, 0);
    
}


-(void)testBackgroundContext{
    
    // Get mainQ context
    NSManagedObjectContext *context = [self.stack newBackgroundContext];
    
    // Create two man objs
    NSEntityDescription *entityBiz = [NSEntityDescription entityForName:@"Business" inManagedObjectContext:context];
    Business *aBiz = [[Business alloc]initWithEntity:entityBiz insertIntoManagedObjectContext:context];
    aBiz.name = @"Background Queue Context Biz";
    aBiz.employees = @101;
    
    NSEntityDescription *entityCar = [NSEntityDescription entityForName:@"Car" inManagedObjectContext:context];
    Car *aCar = [[Car alloc]initWithEntity:entityCar insertIntoManagedObjectContext:context];
    aCar.name = @"Background Queue Context Car";
    aCar.priceInPence = @1699500;
    aCar.business = aBiz;
    
    // Fetch
    CDSFetcher *fetcher = [CDSFetcher fetcher];
    NSArray *businesses = [fetcher fetchFilteredByContainingString:@"Background Queue"
                                                         atKeyPath:@"name"
                                                        entityName:@"Business"
                                                           context:context
                                                             error:nil];
    NSArray *cars = [fetcher fetchFilteredByContainingString:@"Background Queue"
                                                   atKeyPath:@"name"
                                                  entityName:@"Car"
                                                     context:context
                                                       error:nil];
    XCTAssertEqual(businesses.count, 1);
    XCTAssertEqual(cars.count, 1);
    Business *fetchedBiz = businesses.firstObject;
    Car *fetchedCar = cars.firstObject;
    
    XCTAssertEqualObjects(fetchedBiz, aBiz);
    XCTAssertEqualObjects(fetchedCar, aCar);
    XCTAssertEqualObjects(fetchedBiz, aCar.business);
    
    // Save so the new objects are persisted to the store
    [context save:nil];
    // Then clear the context
    [self.stack clearMainQueueContextWithCompletion:nil];
    
    // Now if we fetch we should still get 1 of each object
    businesses = [fetcher fetchFilteredByContainingString:@"Background Queue"
                                                atKeyPath:@"name"
                                               entityName:@"Business"
                                                  context:context
                                                    error:nil];
    cars = [fetcher fetchFilteredByContainingString:@"Background Queue"
                                          atKeyPath:@"name"
                                         entityName:@"Car"
                                            context:context
                                              error:nil];
    XCTAssertEqual(businesses.count, 1);
    XCTAssertEqual(cars.count, 1);
    
    // Now we should be able to delete them both
    [context deleteObject:aBiz];
    [context deleteObject:aCar];
    
    // Then save
    [context save:nil];
    
    // Now if we fetch we should  get 0 of each object
    businesses = [fetcher fetchFilteredByContainingString:@"Background Queue"
                                                atKeyPath:@"name"
                                               entityName:@"Business"
                                                  context:context
                                                    error:nil];
    cars = [fetcher fetchFilteredByContainingString:@"Background Queue"
                                          atKeyPath:@"name"
                                         entityName:@"Car"
                                            context:context
                                              error:nil];
    XCTAssertEqual(businesses.count, 0);
    XCTAssertEqual(cars.count, 0);
    
}


-(void)testUsingBackgroundQueueAndMainQueueContextsTogether{
    
    
    /**
     Create 2 queues
     Insert 2 objects using bgQueue, don't save.
     Fetch on mainQueue, should be 0.
     Call save on bgQueue
     Fetch on mainQueue, should be 1 of each (car + biz)
     Edit objects
     Call save on mainQueue
     Fetch using bgQueue, edits should be present
     Delete objects
     Fetch on mainQueue, should be 0.
     **/
    
    //  Create 2 queues
    NSManagedObjectContext *mainQueueContext = self.stack.mainQueueContext;
    NSManagedObjectContext *bgQueueContext = [self.stack newBackgroundContext];
    
    
    // Insert 2 objects using bgQueue, don't save.
    [bgQueueContext performBlockAndWait:^{
       
        NSEntityDescription *entityBiz = [NSEntityDescription entityForName:@"Business" inManagedObjectContext:bgQueueContext];
        Business *aBiz = [[Business alloc]initWithEntity:entityBiz insertIntoManagedObjectContext:bgQueueContext];
        aBiz.name = @"Main<>BG Queue Context Biz";
        aBiz.employees = @666;
        
        NSEntityDescription *entityCar = [NSEntityDescription entityForName:@"Car" inManagedObjectContext:bgQueueContext];
        Car *aCar = [[Car alloc]initWithEntity:entityCar insertIntoManagedObjectContext:bgQueueContext];
        aCar.name = @"Main<>BG Queue Context Car";
        aCar.priceInPence = @666;
        aCar.business = aBiz;
        
    }];
    

    // Fetch on mainQueue, should be 0.
    CDSFetcher *fetcher = [CDSFetcher fetcher];
    NSArray *businesses = [fetcher fetchFilteredByContainingString:@"Main<>BG Queue"
                                                         atKeyPath:@"name"
                                                        entityName:@"Business"
                                                           context:mainQueueContext
                                                             error:nil];
    NSArray *cars = [fetcher fetchFilteredByContainingString:@"Main<>BG Queue"
                                                   atKeyPath:@"name"
                                                  entityName:@"Car"
                                                     context:mainQueueContext
                                                       error:nil];
    XCTAssertEqual(businesses.count, 0);
    XCTAssertEqual(cars.count, 0);
    
    // Call save on bgQueue
    [bgQueueContext performBlockAndWait:^{
        [bgQueueContext save:nil];
    }];
    
    // Fetch on mainQueue, should be 1 of each (car + biz)
    businesses = [fetcher fetchFilteredByContainingString:@"Main<>BG Queue"
                                                atKeyPath:@"name"
                                               entityName:@"Business"
                                                  context:mainQueueContext
                                                    error:nil];
    cars = [fetcher fetchFilteredByContainingString:@"Main<>BG Queue"
                                          atKeyPath:@"name"
                                         entityName:@"Car"
                                            context:mainQueueContext
                                              error:nil];
    XCTAssertEqual(businesses.count, 1);
    XCTAssertEqual(cars.count, 1);

    // Edit objects
    Business *mainQBiz = businesses.firstObject;
    Car *mainQCar = cars.firstObject;
    mainQBiz.employees = @333;
    mainQCar.priceInPence = @333;
    
    // Call save on mainQueue
    [mainQueueContext save:nil];
    
    // Fetch using bgQueue, edits should be present
    [bgQueueContext performBlockAndWait:^{
        [bgQueueContext reset];
        NSArray *businesses2 = [fetcher fetchFilteredByContainingString:@"Main<>BG Queue"
                                                             atKeyPath:@"name"
                                                            entityName:@"Business"
                                                               context:bgQueueContext
                                                                 error:nil];
        NSArray *cars2 = [fetcher fetchFilteredByContainingString:@"Main<>BG Queue"
                                                       atKeyPath:@"name"
                                                      entityName:@"Car"
                                                         context:bgQueueContext
                                                           error:nil];
        
        XCTAssertEqual(businesses2.count, 1);
        XCTAssertEqual(cars2.count, 1);

        Business *bgQbiz = businesses2.firstObject;
        Car *bgQCar = cars2.firstObject;
        
        XCTAssertEqualObjects(bgQbiz.employees, mainQBiz.employees);
        XCTAssertEqualObjects(bgQCar.priceInPence, mainQCar.priceInPence);
        
        // Delete objects (from either Q)
        [bgQueueContext deleteObject:bgQCar];
    }];
    
    
    // Delete objects (from either Q)
    [mainQueueContext deleteObject:mainQBiz];
    
    
    // Check there are 0 after deletions
    businesses = [fetcher fetchFilteredByContainingString:@"Main<>BG Queue"
                                                atKeyPath:@"name"
                                               entityName:@"Business"
                                                  context:mainQueueContext
                                                    error:nil];
    cars = [fetcher fetchFilteredByContainingString:@"Main<>BG Queue"
                                          atKeyPath:@"name"
                                         entityName:@"Car"
                                            context:mainQueueContext
                                              error:nil];
    XCTAssertEqual(businesses.count, 0);
    XCTAssertEqual(cars.count, 0);
}





-(void)testUsingTwoBackgroundQueueContextsTogether{
    
    /**
     Create 2 queues
     Insert 2 objects using bgContext1, don't save.
     Fetch on bgContext2, should be 0.
     Call save on bgContext1
     Fetch on bgContext2, should be 1 of each (car + biz)
     Edit objects
     Call save on bgContext2
     Fetch using bgContext1, edits should be present
     Delete objects
     Fetch on bgContext2, should be 0.
     **/
    
    //  Create 2 queues
    NSManagedObjectContext *bgContext1 = [self.stack newBackgroundContext];
    NSManagedObjectContext *bgContext2 = [self.stack newBackgroundContext];
    
    // 2 original manObjs
    __block Business *originalBiz;
    __block Car *originalCar;
    
    // Insert 2 objects using bgQueue, don't save.
    [bgContext1 performBlockAndWait:^{
        
        NSEntityDescription *entityBiz = [NSEntityDescription entityForName:@"Business" inManagedObjectContext:bgContext1];
        originalBiz = [[Business alloc]initWithEntity:entityBiz insertIntoManagedObjectContext:bgContext1];
        originalBiz.name = @"BG1<>BG2 Queue Context Biz";
        originalBiz.employees = @1234;
        
        NSEntityDescription *entityCar = [NSEntityDescription entityForName:@"Car" inManagedObjectContext:bgContext1];
        originalCar = [[Car alloc]initWithEntity:entityCar insertIntoManagedObjectContext:bgContext1];
        originalCar.name = @"BG1<>BG2 Queue Context Car";
        originalCar.priceInPence = @1234;
        originalCar.business = originalBiz;
        
    }];
    
    CDSFetcher *fetcher = [CDSFetcher fetcher];
    __block NSArray *businesses;
    __block NSArray *cars;

    // Fetch on bgContext2, should be 0.
    [bgContext2 performBlockAndWait:^{
        businesses = [fetcher fetchFilteredByContainingString:@"BG1<>BG2 Queue"
                                                             atKeyPath:@"name"
                                                            entityName:@"Business"
                                                               context:bgContext2
                                                                 error:nil];
        cars = [fetcher fetchFilteredByContainingString:@"BG1<>BG2 Queue"
                                                       atKeyPath:@"name"
                                                      entityName:@"Car"
                                                         context:bgContext2
                                                           error:nil];
        XCTAssertEqual(businesses.count, 0);
        XCTAssertEqual(cars.count, 0);

    }];
    
    // Call save on bgContext1
    [bgContext1 performBlockAndWait:^{
        [bgContext1 save:nil];
    }];
    
    // Fetch on bgContext2, should be 1 of each (car + biz)
    [bgContext2 performBlockAndWait:^{
        businesses = [fetcher fetchFilteredByContainingString:@"BG1<>BG2 Queue"
                                                    atKeyPath:@"name"
                                                   entityName:@"Business"
                                                      context:bgContext2
                                                        error:nil];
        cars = [fetcher fetchFilteredByContainingString:@"BG1<>BG2 Queue"
                                              atKeyPath:@"name"
                                             entityName:@"Car"
                                                context:bgContext2
                                                  error:nil];
        XCTAssertEqual(businesses.count, 1);
        XCTAssertEqual(cars.count, 1);
        
        // Edit objects
        Business *fetchedBiz = businesses.firstObject;
        Car *fetchedCar = cars.firstObject;
        fetchedBiz.employees = @4321;
        fetchedCar.priceInPence = @4321;
        
        // Call save on bgContext2
        [bgContext2 save:nil];

    }];
    
    // Fetch using bgContext1, edits should be present
    [bgContext1 performBlockAndWait:^{
        [bgContext1 reset];
        NSArray *businesses2 = [fetcher fetchFilteredByContainingString:@"BG1<>BG2 Queue"
                                                              atKeyPath:@"name"
                                                             entityName:@"Business"
                                                                context:bgContext1
                                                                  error:nil];
        NSArray *cars2 = [fetcher fetchFilteredByContainingString:@"BG1<>BG2 Queue"
                                                        atKeyPath:@"name"
                                                       entityName:@"Car"
                                                          context:bgContext1
                                                            error:nil];
        
        XCTAssertEqual(businesses2.count, 1);
        XCTAssertEqual(cars2.count, 1);
        
        Business *bgQbiz = businesses2.firstObject;
        Car *bgQCar = cars2.firstObject;
        
        [bgContext1 refreshObject:originalBiz mergeChanges:YES];
        XCTAssertEqualObjects(bgQbiz.employees, originalBiz.employees);
        XCTAssertEqualObjects(bgQCar.priceInPence, originalCar.priceInPence);
        
        // Delete Car
        [bgContext1 deleteObject:bgQCar];
    }];
    
    
    [bgContext2 performBlockAndWait:^{
        
        // Delete objects (from either Q)
        [bgContext2 deleteObject:originalBiz];
        
        
        // Check there are 0 after deletions
        businesses = [fetcher fetchFilteredByContainingString:@"BG1<>BG2 Queue"
                                                    atKeyPath:@"name"
                                                   entityName:@"Business"
                                                      context:bgContext2
                                                        error:nil];
        cars = [fetcher fetchFilteredByContainingString:@"BG1<>BG2 Queue"
                                              atKeyPath:@"name"
                                             entityName:@"Car"
                                                context:bgContext2
                                                  error:nil];
        XCTAssertEqual(businesses.count, 0);
        XCTAssertEqual(cars.count, 0);

    }];
}














@end
