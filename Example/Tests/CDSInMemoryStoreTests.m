


#import <XCTest/XCTest.h>
// SUT
#import <CDSCoreDataSolutions/CDSCoreDataSolutions.h>
// Helpers
#import "CDSManagedObjectBuilder.h"

@interface CDSInMemoryStoreTests : XCTestCase
@property (strong,nonatomic) CDSCoreDataStack *sut;
@end

@implementation CDSInMemoryStoreTests


//======================================================
#pragma mark - ** Setup, Tear down **
//======================================================
- (void)setUp {
    [super setUp];
    self.sut = [[CDSCoreDataStack alloc]init];
    CDSManagedObjectModelDescriptor *bizModel = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    bizModel.name = @"BusinessModel";
    CDSPersistentStoreDescriptor *bizStore = [CDSPersistentStoreDescriptor persistentStoreDescriptor];
    bizStore.name = @"BusinessStoreShared";
    bizStore.type = NSInMemoryStoreType;
    NSError *error;
    if (![self.sut configureStackSynchronouslyWithModelDescriptors:@[bizModel]
                                                  storeDescriptors:@[bizStore]
                                                             error:&error]) {
        NSLog(@"ERROR: %@",error.localizedDescription);
    }else{
        
        NSLog(@"<CONFIGURED> SharedInstance of Stack has been configured");
        NSManagedObjectContext *bgContext = [self.sut newBackgroundContext];
        [bgContext performBlockAndWait:^{
            
            [CDSManagedObjectBuilder buildAndInsertMotorbikes:5
                                                  intoContext:bgContext];
            [CDSManagedObjectBuilder buildAndInsertBusinesses:5
                                                  intoContext:bgContext];
            [CDSManagedObjectBuilder buildAndInsertCars:5
                                            intoContext:bgContext];
            
            NSError *error;
            BOOL success = NO;
            success = [bgContext save:&error];
            if (!success){
                NSLog(@"<FAIL> Failed to save bgcontext");
                if (error != nil) {
                    NSLog(@"<ERROR> %@",error);
                }
            }
            
            CDSAuditor *auditor = [CDSAuditor auditor];
            NSDictionary *countsDict = [auditor countsKeyedByNamesOfEntitiesInStack:self.sut
                                                                              error:nil];
            NSLog(@"\n\n* <COUNT> %@", countsDict);
            
        }];

        
    }
}

- (void)tearDown {
    self.sut = nil;
    [super tearDown];
}

//======================================================
#pragma mark - ** Initilisation Tests **
//======================================================
-(void)testSUT{
    XCTAssertNotNil(self.sut);
}


//======================================================
#pragma mark - ** Primary Function Tests **
//======================================================




















@end










































