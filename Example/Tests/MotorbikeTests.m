

#import <XCTest/XCTest.h>
#import <CDSCoreDataSolutions/CDSCoreDataSolutions.h>
#import "Motorbike.h"


@interface MotorbikeTests : XCTestCase <CDSLoggingDelegate>

@property (strong,nonatomic) CDSCoreDataStack *stack;

@end

@implementation MotorbikeTests

- (void)setUp {
    [super setUp];
    self.stack = [CDSCoreDataStack sharedStack];
    self.stack.loggingDelegate = self;
    XCTAssertNotNil(self.stack);
}

- (void)tearDown {
    self.stack = nil;
    [super tearDown];
}


/***************************
 
 Having problems performing fetch requests for Motorbike entity for some reason.
 So this test case is to route out the problem
 
 
 *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '+[NSSQLRow __setObject:forKey:]: unrecognized selector sent to class 0x10c360038'

 
 ***************************/

//--------------------------------------------------------
#pragma mark -
//--------------------------------------------------------
-(void)testCreateAMotorbikeOnTheMainQueueContext{
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Motorbike"
                                              inManagedObjectContext:self.stack.mainQueueContext];
    
    Motorbike *bike = [[Motorbike alloc]initWithEntity:entity
                        insertIntoManagedObjectContext:self.stack.mainQueueContext];
    bike.name = @"Mr Bike";
    bike.priceInPence = @11199;
    
    XCTAssertNotNil(bike);
    
    NSError *error = nil;
    BOOL success = NO;
    success =  [self.stack.mainQueueContext save:&error];
    if (!success) {
        if (error != nil) {
            NSLog(@"Failed to save context with error: %@",error);
        }
    }
    XCTAssertTrue(success);
    XCTAssertNil(error);
}


-(void)testCreateThenDeleteAMotorbikeOnTheMainQueueContext{
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Motorbike"
                                              inManagedObjectContext:self.stack.mainQueueContext];
    
    Motorbike *bike = [[Motorbike alloc]initWithEntity:entity
                        insertIntoManagedObjectContext:self.stack.mainQueueContext];
    bike.name = @"Mr Bike";
    bike.priceInPence = @11199;
    
    XCTAssertNotNil(bike);
    
    NSError *error = nil;
    BOOL success = NO;
    success =  [self.stack.mainQueueContext save:&error];
    if (!success) {
        if (error != nil) {
            NSLog(@"Failed to save context with error: %@",error);
        }
    }
    XCTAssertTrue(success);
    XCTAssertNil(error);
    
    
    [self.stack.mainQueueContext deleteObject:bike];
    
    NSError *error2 = nil;
    BOOL success2 = NO;
    success2 =  [self.stack.mainQueueContext save:&error2];
    if (!success2) {
        if (error2 != nil) {
            NSLog(@"Failed to save context with error: %@",error2);
        }
    }
    XCTAssertTrue(success2);
    XCTAssertNil(error2);
}


-(void)testFetchMotorbikesOnTheMainQueueContext{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = [NSEntityDescription entityForName:@"Motorbike"
                                 inManagedObjectContext:self.stack.mainQueueContext];
    
    NSLog(@"MainQueueContext is still alive: %@",self.stack.mainQueueContext);
    NSLog(@"MainContext's parent = %@",self.stack.mainQueueContext.parentContext);
    NSLog(@"MainContext's parent PSC = %@",self.stack.mainQueueContext.parentContext.persistentStoreCoordinator);
    NSError *error = nil;
    NSArray *matching = [self.stack.mainQueueContext executeFetchRequest:request error:&error];
    if (matching.count == 0) {
        if (error != nil) {
            NSLog(@"Failed to fetch motorbikes with error: %@",error);
        }
    }
    
    XCTAssertNotNil(matching);
    XCTAssertNil(error);
}

-(void)testFetchCarsOnTheMainQueueContext{
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = [NSEntityDescription entityForName:@"Car"
                                 inManagedObjectContext:self.stack.mainQueueContext];

    NSLog(@"MainQueueContext is still alive: %@",self.stack.mainQueueContext);
    NSLog(@"FetchRequest is still alive: %@",request);
    NSError *error = nil;
    NSArray *matching = [self.stack.mainQueueContext executeFetchRequest:request error:&error];
    NSLog(@"Matching : %ld",(long)matching.count);
    if (matching.count == 0) {
        if (error != nil) {
            NSLog(@"Failed to fetch cars with error: %@",error);
        }
    }
    
    XCTAssertNotNil(matching);
    XCTAssertNil(error);
}


-(void)testFetchBagsOnTheMainQueueContext{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = [NSEntityDescription entityForName:@"Bag"
                                 inManagedObjectContext:self.stack.mainQueueContext];
    
    NSLog(@"MainQueueContext is still alive: %@",self.stack.mainQueueContext);
    NSLog(@"FetchRequest is still alive: %@",request);
    NSError *error = nil;
    NSArray *matching = [self.stack.mainQueueContext executeFetchRequest:request error:&error];
    NSLog(@"Matching : %ld",(long)matching.count);
    if (matching.count == 0) {
        if (error != nil) {
            NSLog(@"Failed to fetch bags with error: %@",error);
        }
    }
    
    XCTAssertNotNil(matching);
    XCTAssertNil(error);
}

-(void)testFetchMotorbikeToysOnTheMainQueueContext{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = [NSEntityDescription entityForName:@"MotorbikeToy"
                                 inManagedObjectContext:self.stack.mainQueueContext];
    
    NSLog(@"MainQueueContext is still alive: %@",self.stack.mainQueueContext);
    NSLog(@"FetchRequest is still alive: %@",request);
    NSError *error = nil;
    NSArray *matching = [self.stack.mainQueueContext executeFetchRequest:request error:&error];
    NSLog(@"Matching : %ld",(long)matching.count);
    if (matching.count == 0) {
        if (error != nil) {
            NSLog(@"Failed to fetch MotorbikeToys with error: %@",error);
        }
    }
    
    XCTAssertNotNil(matching);
    XCTAssertNil(error);
}

-(void)testFetchWickerBasketsOnTheMainQueueContext{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = [NSEntityDescription entityForName:@"WickerBasket"
                                 inManagedObjectContext:self.stack.mainQueueContext];
    
    NSLog(@"MainQueueContext is still alive: %@",self.stack.mainQueueContext);
    NSLog(@"FetchRequest is still alive: %@",request);
    NSError *error = nil;
    NSArray *matching = [self.stack.mainQueueContext executeFetchRequest:request error:&error];
    NSLog(@"Matching : %ld",(long)matching.count);
    if (matching.count == 0) {
        if (error != nil) {
            NSLog(@"Failed to fetch WickerBasket with error: %@",error);
        }
    }
    
    XCTAssertNotNil(matching);
    XCTAssertNil(error);
}


-(void)testFetchPiesOnTheMainQueueContext{
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    request.entity = [NSEntityDescription entityForName:@"Pie"
                                 inManagedObjectContext:self.stack.mainQueueContext];
    
    NSLog(@"MainQueueContext is still alive: %@",self.stack.mainQueueContext);
    NSLog(@"FetchRequest is still alive: %@",request);
    NSError *error = nil;
    NSArray *matching = [self.stack.mainQueueContext executeFetchRequest:request error:&error];
    NSLog(@"Matching : %ld",(long)matching.count);
    if (matching.count == 0) {
        if (error != nil) {
            NSLog(@"Failed to fetch Pie with error: %@",error);
        }
    }
    
    XCTAssertNotNil(matching);
    XCTAssertNil(error);
}




//======================================================
#pragma mark - ** Protocol Methods **
//======================================================
-(void)logNotificationReceived:(NSNotification *)note withMessage:(NSString *)message, ...{
    
    NSLog(@"<NOTE> %@",note.name);

    if (message != nil) {
        va_list args;
        va_start(args, message);
        NSLog(@"<NOTE> %@",[[NSString alloc]initWithFormat:message arguments:args]);
        va_end(args);
    }
}




















@end
