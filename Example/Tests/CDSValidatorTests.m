
@import XCTest;
#import <CDSCoreDataSolutions/CDSCoreDataStack.h>
#import <CDSCoreDataSolutions/CDSValidator.h>

@interface CDSValidatorTests : XCTestCase
@property (strong, nonatomic) CDSValidator *sut;
@end



@implementation CDSValidatorTests
//======================================================
#pragma mark - ** Setup, Tear down **
//======================================================
- (void)setUp {
    [super setUp];
    self.sut = [[CDSValidator alloc]init];
    
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
#pragma mark - ** Test Validate Stack **
//======================================================
- (void)testValidateStack_WithInvalidStack_ShouldReturnFALSE{
    
    NSError *error;
    BOOL isValid = NO;
    isValid = [self.sut validateStack:nil
                            withError:&error];
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

- (void)testValidateStack_WithInvalidStackAndNilError_ShouldReturnFALSE{
    
    BOOL isValid = NO;
    isValid = [self.sut validateStack:nil
                            withError:nil];
    XCTAssertFalse(isValid);
}

-(void)testValidateStack_WithValidStack_ShouldReturnTRUE{
    
    // GIVEN
    
    // WHEN
    NSError *error;
    BOOL isValid = NO;
    isValid = [self.sut validateStack:[CDSCoreDataStack sharedStack]
                            withError:&error];
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
}




//======================================================
#pragma mark - ** Test Validate Context **
//======================================================
- (void)testValidateContext_WithInvalidContext_ShouldReturnFALSE{
    
    NSError *error;
    BOOL isValid = NO;
    isValid = [self.sut validateContext:nil
                              withError:&error];
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

- (void)testValidateContext_WithInvalidContextAndNilError_ShouldReturnFALSE{
    
    BOOL isValid = NO;
    isValid = [self.sut validateContext:nil
                              withError:nil];
    XCTAssertFalse(isValid);
}

-(void)testValidateContext_WithValidContext_ShouldReturnTRUE{
    
    // GIVEN
    
    // WHEN
    NSError *error;
    BOOL isValid = NO;
    isValid = [self.sut validateContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
}

//======================================================
#pragma mark - ** Test Validate Model **
//======================================================
- (void)testValidateModel_WithInvalidModel_ShouldReturnFALSE{
    
    NSError *error;
    BOOL isValid = NO;
    isValid = [self.sut validateModel:nil
                            withError:&error];
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

- (void)testValidateModel_WithInvalidModelAndNilError_ShouldReturnFALSE{
    
    BOOL isValid = NO;
    isValid = [self.sut validateModel:nil
                            withError:nil];
    XCTAssertFalse(isValid);
    
}
-(void)testValidateModel_WithValidModel_ShouldReturnTRUE{
    
    // WHEN
    NSError *error;
    BOOL isValid = NO;
    isValid = [self.sut validateModel:[CDSCoreDataStack sharedStack].managedObjectModel
                            withError:&error];
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
}


//======================================================
#pragma mark - ** Test Validate String **
//======================================================
-(void)testValidateString_WithInvalidString_ShouldHandleNilError{
    // GIVEN
    NSString *invalidString;
    BOOL isValid = NO;
    
    // WHEN
    isValid = [self.sut validateString:invalidString
                             withError:nil];
    
    // THEN
    XCTAssertFalse(isValid);
}

-(void)testValidateString_WithNilString_ShouldReturnFALSE{
    
    // GIVEN
    NSString *invalidString;
    BOOL isValid = NO;
    NSError *error;
    
    // WHEN
    isValid = [self.sut validateString:invalidString
                             withError:&error];
    
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateString_WithEmptyString_ShouldReturnFALSE{
    
    // GIVEN
    NSString *invalidString = @"";
    BOOL isValid = NO;
    NSError *error;
    
    // WHEN
    isValid = [self.sut validateString:invalidString
                             withError:&error];
    
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateString_WithValidString_ShouldReturnTRUE{
    
    // GIVEN
    NSString *validString = @"validString";
    BOOL isValid = NO;
    NSError *error;
    
    // WHEN
    isValid = [self.sut validateString:validString
                             withError:&error];
    
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
}




//======================================================
#pragma mark - ** Test Validate Number **
//======================================================
-(void)testValidateNumber_WithInvalidNumber_ShouldHandleNilError{
    // GIVEN
    NSNumber *invalidNumber;
    BOOL isValid = NO;
    
    // WHEN
    isValid = [self.sut validateNumber:invalidNumber
                             withError:nil];
    // THEN
    XCTAssertFalse(isValid);
}

-(void)testValidateNumber_WithNilNumber_ShouldReturnFALSE{
    
    // GIVEN
    NSNumber *invalidNumber;
    BOOL isValid = NO;
    NSError *error;
    
    // WHEN
    isValid = [self.sut validateNumber:invalidNumber
                             withError:&error];
    
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}


-(void)testValidateNumber_WithValidNumber_ShouldReturnTRUE{
    
    // GIVEN
    NSNumber *validNumber = @42;
    BOOL isValid = NO;
    NSError *error;
    
    // WHEN
    isValid = [self.sut validateNumber:validNumber
                             withError:&error];
    
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
}




//======================================================
#pragma mark - ** Test Validate Date **
//======================================================
-(void)testValidateDate_WithInvalidNumber_ShouldHandleNilError{
    // GIVEN
    NSDate *invalidDate;
    BOOL isValid = NO;
    
    // WHEN
    isValid = [self.sut validateDate:invalidDate
                           withError:nil];
    // THEN
    XCTAssertFalse(isValid);
}

-(void)testValidateDate_WithNilDate_ShouldReturnFALSE{
    
    // GIVEN
    NSDate *invalidDate;
    BOOL isValid = NO;
    NSError *error;
    
    // WHEN
    isValid = [self.sut validateDate:invalidDate
                           withError:&error];
    
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}


-(void)testValidateSting_WithValidDate_ShouldReturnTRUE{
    
    // GIVEN
    NSDate *validDate = [NSDate date];
    BOOL isValid = NO;
    NSError *error;
    
    // WHEN
    isValid = [self.sut validateDate:validDate
                           withError:&error];
    
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
}



//======================================================
#pragma mark - ** Test Validate Object is correct for attribute **
//======================================================
-(void)testValidateObjectIsCorrectForAttribute_WithNilObject_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObject:nil
            isCorrectForAttributeNamed:@"priceInPence"
                         forEntityName:@"Product"
                             inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                             withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObject:nil
            isCorrectForAttributeNamed:@"priceInPence"
                         forEntityName:@"Product"
                             inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                             withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateObjectIsCorrectForAttribute_WithNilContext_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObject:@999999
            isCorrectForAttributeNamed:@"priceInPence"
                         forEntityName:@"Product"
                             inContext:nil
                             withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObject:@999999
            isCorrectForAttributeNamed:@"priceInPence"
                         forEntityName:@"Product"
                             inContext:nil
                             withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateObjectIsCorrectForAttribute_WithInvalidEntityName_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObject:@999999
            isCorrectForAttributeNamed:@"priceInPence"
                         forEntityName:nil
                             inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                             withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObject:@999999
            isCorrectForAttributeNamed:@"priceInPence"
                         forEntityName:@"tumbleweed"
                             inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                             withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateObjectIsCorrectForAttribute_WithInvalidAttributeName_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObject:@999999
            isCorrectForAttributeNamed:@"nil-nil"
                         forEntityName:@"Product"
                             inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                             withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObject:@999999
            isCorrectForAttributeNamed:nil
                         forEntityName:@"Product"
                             inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                             withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateObjectIsCorrectForAttribute_WithValidArguments_ShouldReturnTRUE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObject:@999999
            isCorrectForAttributeNamed:@"priceInPence"
                         forEntityName:@"Product"
                             inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                             withError:nil];
    // THEN
    XCTAssertTrue(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObject:@999999
            isCorrectForAttributeNamed:@"priceInPence"
                         forEntityName:@"Product"
                             inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                             withError:&error];
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
}



//======================================================
#pragma mark - ** Test Validate Entity Name In Context **
//======================================================
-(void)testValidateEntityNameInContext_WithInvalidEntityName_ShouldHandleNilErrorAndReturnFALSE{
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateEntityName:@"Fakington"
                                 inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                                 withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateEntityName:nil
                                 inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                                 withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateEntityNameInContext_WithInvalidContext_ShouldHandleNilErrorAndReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateEntityName:@"Business"
                                 inContext:nil
                                 withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateEntityName:@"Business"
                                 inContext:nil
                                 withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
    
}

-(void)testValidateEntityNameInContext_WithValidArguments_ShouldReturnTRUE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateEntityName:@"Business"
                                 inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                                 withError:nil];
    // THEN
    XCTAssertTrue(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateEntityName:@"Business"
                                 inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                                 withError:&error];
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
}



//======================================================
#pragma mark - ** Test Validate Entity Name In Model **
//======================================================
-(void)testValidateEntityNameInModel_WithInvalidEntityName_ShouldHandleNilErrorAndReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateEntityName:nil
                                   inModel:[CDSCoreDataStack sharedStack].managedObjectModel
                                 withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateEntityName:nil
                                   inModel:[CDSCoreDataStack sharedStack].managedObjectModel
                                 withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateEntityNameInModel_WithInvalidModel_ShouldHandleNilErrorAndReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateEntityName:@"Business"
                                   inModel:nil
                                 withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateEntityName:@"Business"
                                   inModel:nil
                                 withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
    
}

-(void)testValidateEntityNameInModel_WithValidArguments_ShouldReturnTRUE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateEntityName:@"Business"
                                   inModel:[CDSCoreDataStack sharedStack].managedObjectModel
                                 withError:nil];
    // THEN
    XCTAssertTrue(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateEntityName:@"Business"
                                   inModel:[CDSCoreDataStack sharedStack].managedObjectModel
                                 withError:&error];
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
}




//======================================================
#pragma mark - ** Test Validate Key Paths **
//======================================================
-(void)testValidateKeyPaths_WithInvalidContext_ShouldReturnFALSE{
    
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateKeyPath:@"name"
                          forEntityName:@"Business"
                              inContext:nil
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateKeyPath:@"name"
                          forEntityName:@"Business"
                              inContext:nil
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateKeyPaths_WithInvalidEntityName_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateKeyPath:@"name"
                          forEntityName:@"Bum"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateKeyPath:@"name"
                          forEntityName:@"Nob"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateKeyPaths_WithInvalidKeyPath_ShouldReturnFALSE{
    
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateKeyPath:@"ladyparts.boobies"
                          forEntityName:@"Business"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateKeyPath:@"boyparts.winkle"
                          forEntityName:@"Business"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateKeyPaths_WithValidArguments_ShouldReturnTRUE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateKeyPath:@"employees"
                          forEntityName:@"Business"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertTrue(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateKeyPath:@"employees"
                          forEntityName:@"Business"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
}



//======================================================
#pragma mark - ** Test Validate ArrayOfStrings & ArrayOfKeypaths **
//======================================================
-(void)testValidateStringsAndKeyPaths_WithInvalidContext_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper"]
                            forKeyPaths:@[@"name",@"blurb"]
                          forEntityName:@"Product"
                              inContext:nil
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper"]
                            forKeyPaths:@[@"name",@"blurb"]
                          forEntityName:@"Product"
                              inContext:nil
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateStringsAndKeyPaths_WithInvalidEntityName_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper"]
                            forKeyPaths:@[@"name",@"blurb"]
                          forEntityName:@"FakeProduct"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper"]
                            forKeyPaths:@[@"name",@"blurb"]
                          forEntityName:@"FakeProduct"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateStringsAndKeyPaths_WithNilKeyPaths_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper"]
                            forKeyPaths:nil
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper"]
                            forKeyPaths:nil
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateStringsAndKeyPaths_WithUnrecognisedKeyPaths_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper"]
                            forKeyPaths:@[@"FakeKeyPath",@"Laces"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper"]
                            forKeyPaths:@[@"FakeKeyPath",@"Laces"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateStringsAndKeyPaths_WithNilStrings_ShouldReturnFALSE{
    
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:nil
                            forKeyPaths:@[@"name",@"blurb"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:nil
                            forKeyPaths:@[@"name",@"blurb"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateStringsAndKeyPaths_WithEmptyStrings_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@"",@""]
                            forKeyPaths:@[@"name",@"blurb"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"",@""]
                            forKeyPaths:@[@"name",@"blurb"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateStringsAndKeyPaths_WithUnpairedStringsAndKeys_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@"Nike Air"]
                            forKeyPaths:@[@"name",@"blurb"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super Duper"]
                            forKeyPaths:@[@"name"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}



-(void)testValidateStringsAndKeyPaths_WithValidArguments_ShouldReturnTRUE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper"]
                            forKeyPaths:@[@"name",@"blurb"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertTrue(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper"]
                            forKeyPaths:@[@"name",@"blurb"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
    
}


//======================================================
#pragma mark - ** Test Validate ArrayOfNumbers & ArrayOfKeypaths **
//======================================================

-(void)testValidateNumbersAndKeyPaths_WithInvalidContext_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@2123]
                            forKeyPaths:@[@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:nil
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@9999]
                            forKeyPaths:@[@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:nil
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}
-(void)testValidateNumbersAndKeyPaths_WithInvalidEntityName_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@2123]
                            forKeyPaths:@[@"priceInPence"]
                          forEntityName:nil
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@9999]
                            forKeyPaths:@[@"priceInPence"]
                          forEntityName:nil
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateNumbersAndKeyPaths_WithNilKeyPaths_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@2123]
                            forKeyPaths:nil
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@9999]
                            forKeyPaths:nil
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateNumbersAndKeyPaths_WithUnrecognisedKeyPaths_ShouldReturnFALSE{
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@2123]
                            forKeyPaths:@[@"asffgname"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@9999]
                            forKeyPaths:@[@"psfds.rice"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateNumbersAndKeyPaths_WithNilNumbers_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:nil
                            forKeyPaths:@[@"priceInPence",@"name"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:nil
                            forKeyPaths:@[@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}


-(void)testValidateNumbersAndKeyPaths_WithUnpairedNumbersAndKeys_ShouldReturnFALSE{
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@2500]
                            forKeyPaths:@[@"priceInPence",@"name"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@2342,@"hello!"]
                            forKeyPaths:@[@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateNumbersAndKeyPaths_WithValidArguments_ShouldReturnTRUE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@2500]
                            forKeyPaths:@[@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertTrue(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@2500]
                            forKeyPaths:@[@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
}




//======================================================
#pragma mark - ** Test Validate ArrayOfObjects & ArrayOfKeypaths **
//======================================================
-(void)testValidateObjectsAndKeyPaths_WithInvalidContext_ShouldReturnFALSE{
    
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper",@2500]
                            forKeyPaths:@[@"name",@"blurb",@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:nil
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper",@2500]
                            forKeyPaths:@[@"name",@"blurb",@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:nil
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
    
}


-(void)testValidateObjectsAndKeyPaths_WithInvalidEntityName_ShouldReturnFALSE{
    
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper",@2500]
                            forKeyPaths:@[@"name",@"blurb",@"priceInPence"]
                          forEntityName:@"Productasdas"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper",@2500]
                            forKeyPaths:@[@"name",@"blurb",@"priceInPence"]
                          forEntityName:@"Producttesco"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
    
}

-(void)testValidateObjectsAndKeyPaths_WithNilKeyPaths_ShouldReturnFALSE{
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper",@2500]
                            forKeyPaths:nil
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper",@2500]
                            forKeyPaths:nil
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
    
}

-(void)testValidateObjectsAndKeyPaths_WithUnrecognisedKeyPaths_ShouldReturnFALSE{
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper",@2500]
                            forKeyPaths:@[@"not.a.keypath",@"product.Description",@"price.of.milk"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper",@2500]
                            forKeyPaths:@[@"not.a.keypath",@"product.Description",@"price.of.milk"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateObjectsAndKeyPaths_WithNilObjects_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:nil
                            forKeyPaths:@[@"name",@"blurb",@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:nil
                            forKeyPaths:@[@"name",@"blurb",@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateObjectsAndKeyPaths_WithInvalidObjects_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[[NSDate date],@2500,self]
                            forKeyPaths:@[@"name",@"blurb",@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[[NSDate date],@2500,self]
                            forKeyPaths:@[@"name",@"blurb",@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateObjectsAndKeyPaths_WithUnpairedObjectsAndKeys_ShouldReturnFALSE{
    
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@2500]
                            forKeyPaths:@[@"name",@"blurb",@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertFalse(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"Nike Air"]
                            forKeyPaths:@[@"name",@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertFalse(isValid);
    XCTAssertNotNil(error);
}

-(void)testValidateObjectsAndKeyPaths_WithValidArguments_ShouldReturnTRUE{
    // WHEN
    BOOL isValid = NO;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper",@2500]
                            forKeyPaths:@[@"name",@"blurb",@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:nil];
    // THEN
    XCTAssertTrue(isValid);
    
    // WHEN with error
    NSError *error;
    isValid = [self.sut validateObjects:@[@"Nike Air",@"Super duper",@2500]
                            forKeyPaths:@[@"name",@"blurb",@"priceInPence"]
                          forEntityName:@"Product"
                              inContext:[CDSCoreDataStack sharedStack].mainQueueContext
                              withError:&error];
    // THEN
    XCTAssertTrue(isValid);
    XCTAssertNil(error);
}



@end
