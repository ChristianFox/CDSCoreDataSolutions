//
//  CDSTestsAppDelegate.m
//  CDSCoreDataSolutions
//
//  Created by Eyeye on 08/05/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//

#import "CDSTestsAppDelegate.h"
#import <CDSCoreDataSolutions/CDSCoreDataStack.h>
#import <CDSCoreDataSolutions/CDSPersistentStoreDescriptor.h>
#import <CDSCoreDataSolutions/CDSManagedObjectModelDescriptor.h>
#import "CDSManagedObjectBuilder.h"


@implementation CDSTestsAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    CDSCoreDataStack *stack = [CDSCoreDataStack sharedStack];
    
    CDSManagedObjectModelDescriptor *bizModel = [CDSManagedObjectModelDescriptor managedObjectModelDescriptor];
    bizModel.name = @"BusinessModel";
    CDSPersistentStoreDescriptor *bizStore = [CDSPersistentStoreDescriptor persistentStoreDescriptor];
    bizStore.name = @"BusinessStoreShared";
    
    // We don't want this method to return until the stack has been configured
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [stack configureStackWithModelDescriptors:@[bizModel]
                             storeDescriptors:@[bizStore]
                                   completion:^(BOOL success, NSError * _Nullable error)
    {
       
        NSLog(@"<CONFIGURED> SharedInstance of Stack has been configured with success: %d",success);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [CDSManagedObjectBuilder buildAndInsertBusinesses:5
                                                  intoContext:stack.managedObjectContext];
            [CDSManagedObjectBuilder buildAndInsertCars:5
                                            intoContext:stack.managedObjectContext];
            [CDSManagedObjectBuilder buildAndInsertMotorbikes:5
                                                  intoContext:stack.managedObjectContext];
            
        });
        dispatch_semaphore_signal(semaphore);
    
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"<INFO> Can now return %s",__PRETTY_FUNCTION__);
    return YES;
}

@end
