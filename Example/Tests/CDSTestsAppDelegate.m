//
//  CDSTestsAppDelegate.m
//  CDSCoreDataSolutions
//
//  Created by Eyeye on 08/05/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//

#import "CDSTestsAppDelegate.h"
#import <CDSCoreDataSolutions/CDSCoreDataSolutions.h>
#import "CDSManagedObjectBuilder.h"


@implementation CDSTestsAppDelegate

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    CDSCoreDataStack *stack = [CDSCoreDataStack sharedStack];
    
    CDSManagedObjectModelDescriptor *bizModel = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    bizModel.name = @"BusinessModel";
    CDSPersistentStoreDescriptor *bizStore = [CDSPersistentStoreDescriptor persistentStoreDescriptor];
    bizStore.name = @"BusinessStoreShared";
    
    NSLog(@"Persistent Store URL is: %@",bizStore.URL);
    
    /**** To Test using the Stack with asynchonous configuration ****/
    
    /*
    // We don't want this method to return until the stack has been configured
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [stack configureStackWithModelDescriptors:@[bizModel]
                             storeDescriptors:@[bizStore]
                                   completion:^(BOOL success, NSError * _Nullable error)
    {
       
        NSLog(@"<CONFIGURED> SharedInstance of Stack has been configured with success: %d",success);
        NSManagedObjectContext *bgContext = [stack newBackgroundContext];
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
            NSDictionary *countsDict = [auditor countsKeyedByNamesOfEntitiesInStack:stack
                                                                              error:nil];
            NSLog(@"\n\n* <COUNT> %@", countsDict);
            
            dispatch_semaphore_signal(semaphore);
            
        }];
    
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"<INFO> Can now return %s",__PRETTY_FUNCTION__);
     
     */
    
    
    
    /**** To Test using the Stack with synchonous configuration ****/
    
    NSError *error;
    if (![stack configureStackSynchronouslyWithModelDescriptors:@[bizModel]
                                              storeDescriptors:@[bizStore]
                                                         error:&error]) {
        NSLog(@"ERROR configuring stack: %@",error);
    }else{
        
        NSLog(@"<CONFIGURED> SharedInstance of Stack has been configured");
        NSManagedObjectContext *bgContext = [stack newBackgroundContext];
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
            NSDictionary *countsDict = [auditor countsKeyedByNamesOfEntitiesInStack:stack
                                                                              error:nil];
            NSLog(@"\n\n* <COUNT> %@", countsDict);
            
        }];

        
    }
    
    return YES;
}

@end
