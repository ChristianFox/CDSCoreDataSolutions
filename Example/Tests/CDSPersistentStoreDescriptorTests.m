


@import XCTest;
@import CoreData;
#import "CDSPersistentStoreDescriptor.h"

@interface CDSPersistentStoreDescriptorTests : XCTestCase
@property (strong, nonatomic) CDSPersistentStoreDescriptor *sut;
@end



@implementation CDSPersistentStoreDescriptorTests
//======================================================
#pragma mark - ** Setup, Tear down **
//======================================================
- (void)setUp {
    [super setUp];
    
    self.sut = [[CDSPersistentStoreDescriptor alloc]init];
    
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
-(void)testGetStoreType_WhenDefault_ShouldReturnNSSQLiteStoreType{
    
    XCTAssertNotNil(self.sut.type);
    XCTAssertEqualObjects(self.sut.type, NSSQLiteStoreType);
    XCTAssertEqual(self.sut.type, NSSQLiteStoreType);
}


-(void)testGetStoreDirectory_WhenDefault_ShouldReturnDocumentsDirectory{
    
    XCTAssertNotNil(self.sut.directory);
    NSURL *docsDir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    XCTAssertEqualObjects(self.sut.directory, docsDir);
    
}

-(void)testGetStoreOptions_WhenDefault_ShouldReturnSomeOptions{
    
    XCTAssertNotNil(self.sut.options);
    XCTAssertTrue(self.sut.options.count >= 3);
}

-(void)testGetStoreURL_WhenNameIsSet_ShouldReturnURLFromDocumentsDirectory{
    
    self.sut.name = @"StoreName1";
    XCTAssertNotNil(self.sut.directory);
    NSURL *docsDir = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *storeName = [self.sut.name stringByAppendingPathExtension:@"sqlite"];
    NSURL *expectedURL = [docsDir URLByAppendingPathComponent:storeName];
    XCTAssertEqualObjects(self.sut.URL, expectedURL);
    
}




@end
