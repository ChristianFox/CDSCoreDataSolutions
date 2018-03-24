

@import XCTest;
#import <CDSCoreDataSolutions/CDSCoreDataStack.h>
#import <CDSCoreDataSolutions/CDSAuditor.h>
#import "Business.h"

@interface CDSAuditorTests : XCTestCase
@property (strong, nonatomic) CDSAuditor *sut;
@property (strong,nonatomic) CDSCoreDataStack *stack;
@end



@implementation CDSAuditorTests
//======================================================
#pragma mark - ** Setup, Tear down **
//======================================================
- (void)setUp {
    [super setUp];
    self.sut = [CDSAuditor auditor];
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
#pragma mark - ** Test Entity Auditing **
//======================================================
//--------------------------------------------------------
#pragma mark - existsEntityNamed: inModel:
//--------------------------------------------------------

-(void)existsEntityInModel_WithInvalidNames_ShouldReturnFalse{
    
    BOOL exists = NO;
    exists = [self.sut existsEntityNamed:@"InvalidEntity"
                                 inModel:self.stack.managedObjectModel
                                   error:nil];
    XCTAssertFalse(exists);
    exists = [self.sut existsEntityNamed:@"FakeEntity"
                                 inModel:self.stack.managedObjectModel
                                   error:nil];
    XCTAssertFalse(exists);
    NSString *entityName;
    exists = [self.sut existsEntityNamed:entityName
                                 inModel:self.stack.managedObjectModel
                                   error:nil];
    XCTAssertFalse(exists);
}

-(void)testExistsEntityInModel_WithValidName_ShouldReturnTrue{
    
    BOOL exists = NO;
    exists = [self.sut existsEntityNamed:@"Business"
                                 inModel:self.stack.managedObjectModel
                                   error:nil];
    XCTAssertTrue(exists);
    exists = [self.sut existsEntityNamed:@"Product"
                                 inModel:self.stack.managedObjectModel
                                   error:nil];
    XCTAssertTrue(exists);
    NSError *error;
    exists = [self.sut existsEntityNamed:@"Car"
                                 inModel:self.stack.managedObjectModel
                                   error:&error];
    XCTAssertTrue(exists);
    exists = [self.sut existsEntityNamed:@"Motorbike"
                                 inModel:self.stack.managedObjectModel
                                   error:&error];
    XCTAssertTrue(exists);
    XCTAssertNil(error);
}


-(void)testExistsEntityInModel_WithValidNameButInvalidModel_ShouldReturnFalse{
    BOOL exists = NO;
    NSManagedObjectModel *model;
    exists = [self.sut existsEntityNamed:@"Business"
                                 inModel:model
                                   error:nil];
    XCTAssertFalse(exists);
}


//--------------------------------------------------------
#pragma mark - existsEntityNamed: inContext:
//--------------------------------------------------------

-(void)existsEntityInContext_WithInvalidNames_ShouldReturnFalse{
    
    BOOL exists = NO;
    exists = [self.sut existsEntityNamed:@"InvalidEntity"
                               inContext:self.stack.mainQueueContext
                                   error:nil];
    XCTAssertFalse(exists);
    exists = [self.sut existsEntityNamed:@"FakeEntity"
                               inContext:self.stack.mainQueueContext
                                   error:nil];
    XCTAssertFalse(exists);
    NSString *entityName;
    exists = [self.sut existsEntityNamed:entityName
                               inContext:self.stack.mainQueueContext
                                   error:nil];
    XCTAssertFalse(exists);
}

-(void)testExistsEntityInContext_WithValidName_ShouldReturnTrue{
    
    BOOL exists = NO;
    exists = [self.sut existsEntityNamed:@"Business"
                               inContext:self.stack.mainQueueContext
                                   error:nil];
    XCTAssertTrue(exists);
    exists = [self.sut existsEntityNamed:@"Product"
                               inContext:self.stack.mainQueueContext
                                   error:nil];
    XCTAssertTrue(exists);
    NSError *error;
    exists = [self.sut existsEntityNamed:@"Car"
                               inContext:self.stack.mainQueueContext
                                   error:&error];
    XCTAssertTrue(exists);
    exists = [self.sut existsEntityNamed:@"Motorbike"
                               inContext:self.stack.mainQueueContext
                                   error:&error];
    XCTAssertTrue(exists);
    XCTAssertNil(error);
}


-(void)testExistsEntityInContext_WithValidNameButInvalidContext_ShouldReturnFalse{
    BOOL exists = NO;
    NSManagedObjectContext *context;
    exists = [self.sut existsEntityNamed:@"Business"
                               inContext:context
                                   error:nil];
    XCTAssertFalse(exists);
}


//--------------------------------------------------------
#pragma mark - existsAttributeNamed:
//--------------------------------------------------------
-(void)testExistsAttribute_WithInvalidAttributeAndValidEntity_ShouldReturnFalse{
    
    BOOL exists = NO;
    exists = [self.sut existsAttributeNamed:@"namesake"
                             forEntityNamed:@"Business"
                                  inContext:self.stack.mainQueueContext
                                      error:nil];
    XCTAssertFalse(exists);
    exists = [self.sut existsAttributeNamed:@"prick"
                             forEntityNamed:@"Product"
                                  inContext:self.stack.mainQueueContext
                                      error:nil];
    XCTAssertFalse(exists);
    exists = [self.sut existsAttributeNamed:@"throttle"
                             forEntityNamed:@"Car"
                                  inContext:self.stack.mainQueueContext
                                      error:nil];
    XCTAssertFalse(exists);
    exists = [self.sut existsAttributeNamed:@"door"
                             forEntityNamed:@"Motorbike"
                                  inContext:self.stack.mainQueueContext
                                      error:nil];
    XCTAssertFalse(exists);
}




-(void)testExistsAttribute_WithValidAttributeAndInvalidEntity_ShouldReturnFalse{
    
    BOOL exists = NO;
    exists = [self.sut existsAttributeNamed:@"name"
                             forEntityNamed:@"Busness"
                                  inContext:self.stack.mainQueueContext
                                      error:nil];
    XCTAssertFalse(exists);
    exists = [self.sut existsAttributeNamed:@"price"
                             forEntityNamed:@"Truck"
                                  inContext:self.stack.mainQueueContext
                                      error:nil];
    XCTAssertFalse(exists);
}

-(void)testExistsAttribute_WithValidAttributeAndValidEntity_ShouldReturnTrue{
    
    BOOL exists = NO;
    exists = [self.sut existsAttributeNamed:@"name"
                             forEntityNamed:@"Business"
                                  inContext:self.stack.mainQueueContext
                                      error:nil];
    XCTAssertTrue(exists);
    exists = [self.sut existsAttributeNamed:@"priceInPence"
                             forEntityNamed:@"Product"
                                  inContext:self.stack.mainQueueContext
                                      error:nil];
    XCTAssertTrue(exists);
    NSError *error;
    exists = [self.sut existsAttributeNamed:@"name"
                             forEntityNamed:@"Car"
                                  inContext:self.stack.mainQueueContext
                                      error:&error];
    XCTAssertTrue(exists);
    exists = [self.sut existsAttributeNamed:@"employees"
                             forEntityNamed:@"Business"
                                  inContext:self.stack.mainQueueContext
                                      error:&error];
    XCTAssertTrue(exists);
    XCTAssertNil(error);
}

-(void)testExistsAttribute_WithNilContext_ShouldReturnFalse{
    BOOL exists = NO;
    NSManagedObjectContext *context;
    exists = [self.sut existsAttributeNamed:@"name"
                             forEntityNamed:@"Business"
                                  inContext:context
                                      error:nil];
    XCTAssertFalse(exists);
}



//--------------------------------------------------------
#pragma mark - existsRelationshipNamed:
//--------------------------------------------------------
-(void)testExistsRelationship_WithInvalidRelationshipNameAndValidEntity_ShouldReturnFalse{
    
    BOOL exists = NO;
    exists = [self.sut existsRelationshipNamed:@"mother"
                                forEntityNamed:@"Business"
                                     inContext:self.stack.mainQueueContext
                                         error:nil];
    XCTAssertFalse(exists);
    exists = [self.sut existsRelationshipNamed:@"cuz"
                                forEntityNamed:@"Car"
                                     inContext:self.stack.mainQueueContext
                                         error:nil];
    XCTAssertFalse(exists);
}

-(void)testExistsRelationship_WithValidRelationshipNameAndInvalidEntity_ShouldReturnFalse{
    
    BOOL exists = NO;
    exists = [self.sut existsRelationshipNamed:@"products"
                                forEntityNamed:@"Businessyness"
                                     inContext:self.stack.mainQueueContext
                                         error:nil];
    XCTAssertFalse(exists);
    exists = [self.sut existsRelationshipNamed:@"business"
                                forEntityNamed:@"SteamEngine"
                                     inContext:self.stack.mainQueueContext
                                         error:nil];
    XCTAssertFalse(exists);
}

-(void)testExistsRelationship_WithValidRelationshipNameAndValidEntity_ShouldReturnTrue{
    
    BOOL exists = NO;
    exists = [self.sut existsRelationshipNamed:@"products"
                                forEntityNamed:@"Business"
                                     inContext:self.stack.mainQueueContext
                                         error:nil];
    XCTAssertTrue(exists);
    exists = [self.sut existsRelationshipNamed:@"business"
                                forEntityNamed:@"Product"
                                     inContext:self.stack.mainQueueContext
                                         error:nil];
    XCTAssertTrue(exists);
}

-(void)testExistsRelationship_WithValidNameButNilContext_ShouldReturnFalse{
    BOOL exists = NO;
    NSManagedObjectContext *context;
    exists = [self.sut existsRelationshipNamed:@"name"
                                forEntityNamed:@"Business"
                                     inContext:context
                                         error:nil];
    XCTAssertFalse(exists);
}






//======================================================
#pragma mark - ** Test Context Contents **
//======================================================
-(void)testExistsContentsForEntity_WithValidEntityAndInvalidContext_ShouldReturnFalse{
    
    BOOL exists = NO;
    NSManagedObjectContext *context;
    exists = [self.sut existsContentsForEntityNamed:@"Business"
                                          inContext:context
                                              error:nil];
    XCTAssertFalse(exists);
    exists = [self.sut existsContentsForEntityNamed:@"Motorbike"
                                          inContext:context
                                              error:nil];
    XCTAssertFalse(exists);
    
}

-(void)testExistsContentsForEntity_WithInvalidEntityAndValidContext_ShouldReturnFalse{
    
    BOOL exists = NO;
    exists = [self.sut existsContentsForEntityNamed:@"Bollocks!"
                                          inContext:self.stack.mainQueueContext
                                              error:nil];
    XCTAssertFalse(exists);
    exists = [self.sut existsContentsForEntityNamed:@"Twat!"
                                          inContext:self.stack.mainQueueContext
                                              error:nil];
    XCTAssertFalse(exists);
    
}

-(void)testExistsContentsForEntity_WithValidEntityAndValidContext_ShouldReturnTrue{
    
    
    BOOL exists = NO;
    NSError *error;
    exists = [self.sut existsContentsForEntityNamed:@"Car"
                                          inContext:self.stack.mainQueueContext
                                              error:&error];
    XCTAssertTrue(exists);
    XCTAssertNil(error);
    if (!exists) {
        if (error) {
            NSLog(@"ERROR: %@\n%@",error.localizedDescription,error.userInfo);
        }
    }
    exists = [self.sut existsContentsForEntityNamed:@"Motorbike"
                                          inContext:self.stack.mainQueueContext
                                              error:&error];
    XCTAssertTrue(exists);
    XCTAssertNil(error);
    if (!exists) {
        if (error) {
            NSLog(@"ERROR %s: %@\n%@",__PRETTY_FUNCTION__, error.localizedDescription,error.userInfo);
        }
    }
}


//======================================================
#pragma mark - ** Test Stack Contents **
//======================================================
-(void)testExistsContents_WithNilStack_ShouldReturnFalse{
    
    BOOL exists = NO;
    NSError *error;
    CDSCoreDataStack *stack;
    exists = [self.sut existsContentsInStack:stack
                                       error:&error];
    XCTAssertFalse(exists);
}


-(void)testExistsContents_WithValidStack_ShouldReturnTrue{
    
    
    BOOL exists = NO;
    NSError *error;
    // WHEN
    exists = [self.sut existsContentsInStack:self.stack
                                       error:&error];
    // THEN
    XCTAssertTrue(exists);
    XCTAssertNil(error,@"%@",error.localizedDescription);
    
}



//======================================================
#pragma mark - ** Test Managed Object Count **
//======================================================
#pragma mark - -countOfManObjsInStack
-(void)testCountOfManagedObjectsInStack_WithNilStack_ShouldReturnFalse{
    
    NSUInteger count = 0;
    NSError *error;
    CDSCoreDataStack *stack;
    count = [self.sut countOfManagedObjectsInStack:stack
                                             error:&error];
    XCTAssertTrue(count == 0,@"Count should be 0 but is %@",@(count));
    XCTAssertNotNil(error);
}

-(void)testCountOfManagedObjectsInStack_WithValidStackAfterEnsuringContents_ShouldReturnTrue{
    
    NSUInteger count = 0;
    count = [self.sut countOfManagedObjectsInStack:self.stack
                                             error:nil];
    NSError *error;
    if (count == 0) {
        // add some contents
        NSEntityDescription *entityDesc = [NSEntityDescription entityForName:NSStringFromClass([Business class])
                                                      inManagedObjectContext:self.stack.mainQueueContext];
        Business *aBusiness = [[Business alloc]initWithEntity:entityDesc
                               insertIntoManagedObjectContext:self.stack.mainQueueContext];
        aBusiness.name = @"testCountOfManagedObjectsInStack LTD";
        aBusiness.employees = @420;
        count = [self.sut countOfManagedObjectsInStack:self.stack
                                                 error:&error];
    }
    
    XCTAssertTrue(count >= 1);
    XCTAssertNil(error);
    if (count == 0) {
        XCTAssertNotNil(error);
        if (error) {
            NSLog(@"ERROR %s: %@\n%@",
                  __PRETTY_FUNCTION__,error.localizedDescription,error.userInfo);
        }
    }
}

#pragma mark - -countOfManObjsForEntityName
-(void)testCountOfManagedObjectsForEntity_WithValidEntityNameAndInvalidStack_ShouldReturnFalse{
    
    NSUInteger count = 0;
    NSError *error;
    NSManagedObjectContext *context;
    count = [self.sut countOfManagedObjectsForEntityName:@"Business"
                                               inContext:context
                                                   error:&error];
    XCTAssertTrue(count == 0);
    XCTAssertNotNil(error);
}

-(void)testCountOfManagedObjectsForEntity_WithInvalidEntityNameAndValidStack_ShouldReturnFalse{
    
    NSUInteger count = 0;
    NSError *error;
    count = [self.sut countOfManagedObjectsForEntityName:@"Blahdyblah"
                                               inContext:self.stack.mainQueueContext
                                                   error:&error];
    XCTAssertTrue(count == 0);
    XCTAssertNotNil(error);
}

-(void)testCountOfManagedObjectsForEntity_WithValidEntityNameAndValidStack_ShouldReturnFalse{
    
    NSUInteger count = 0;
    count = [self.sut countOfManagedObjectsForEntityName:@"Business"
                                               inContext:self.stack.mainQueueContext
                                                   error:nil];
    NSError *error;
    if (count == 0) {
        // add some contents
        NSEntityDescription *entityDesc = [NSEntityDescription entityForName:NSStringFromClass([Business class])
                                                      inManagedObjectContext:self.stack.mainQueueContext];
        Business *aBusiness = [[Business alloc]initWithEntity:entityDesc
                               insertIntoManagedObjectContext:self.stack.mainQueueContext];
        aBusiness.name = @"testCountOfManagedObjectsForEntity LTD";
        aBusiness.employees = @42;
        count = [self.sut countOfManagedObjectsForEntityName:@"Business"
                                                   inContext:self.stack.mainQueueContext
                                                       error:&error];
    }
    
    XCTAssertTrue(count >= 1);
    if (count == 0) {
        XCTAssertNotNil(error);
        if (error) {
            NSLog(@"ERROR %s: %@\n%@",
                  __PRETTY_FUNCTION__,error.localizedDescription,error.userInfo);
        }
    }
}

#pragma mark - -countsKeyedByNamesOfEntities
-(void)testCountsKeyedByNamesOfEntities_WithInvalidStack_ShouldReturnFalse{
    
    NSDictionary *dict;
    NSError *error;
    CDSCoreDataStack *stack;
    dict = [self.sut countsKeyedByNamesOfEntitiesInStack:stack
                                                   error:&error];
    XCTAssertNil(dict);
    XCTAssertNotNil(error);
}

-(void)testCountKeyedByNamesOfEntities_WithValidStackAndEnsuringContents_ShouldReturnTrue{
    
    
    NSDictionary *dict;
    NSError *error;
    dict = [self.sut countsKeyedByNamesOfEntitiesInStack:self.stack
                                                   error:&error];
    XCTAssertNil(error);
    if (dict == nil) {
        XCTAssertNotNil(error);
    }
    
    
    XCTAssertNotNil(dict);
    XCTAssertTrue(dict.count == 8, @"Count is %@",@(dict.count));
    XCTAssertTrue([dict[[[dict allKeys]firstObject]] isKindOfClass:[NSNumber class]]);
    NSUInteger totalProducts = [dict[@"Car"]unsignedIntegerValue] + [dict[@"Motorbike"]unsignedIntegerValue];
    XCTAssertTrue(totalProducts == [dict[@"Product"]unsignedIntegerValue]);
    NSLog(@"%@",dict);
}








@end
