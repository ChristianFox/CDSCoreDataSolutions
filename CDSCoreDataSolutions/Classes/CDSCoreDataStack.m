//
//  CDSCoreDataStack.m
//  Pods
//
//  Created by Christian Fox on 06/05/2016.
//
//

#import "CDSCoreDataStack.h"
#import "CDSCoreDataStack_PrivateExtension.h"
//
#import "CDSPersistentStoreDescriptor.h"
#import "CDSManagedObjectModelDescriptor.h"

@interface CDSCoreDataStack ()


@end

@implementation CDSCoreDataStack



//======================================================
#pragma mark - ** Public Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(instancetype)sharedStack{
    
    static dispatch_once_t oncePredicate;
    static CDSCoreDataStack *sharedStack = nil;
    
    dispatch_once(&oncePredicate,^{
        sharedStack = [[self alloc]init];
    });
    return sharedStack;
}

//--------------------------------------------------------
#pragma mark - Configuration
//--------------------------------------------------------
-(void)configureStackWithModelDescriptors:(NSArray<CDSManagedObjectModelDescriptor *> *)modelDescriptors
                         storeDescriptors:(NSArray<CDSPersistentStoreDescriptor *> *)storeDescriptors
                               completion:(CDSBooleanCompletionHandler)handlerOrNil{
    
    // ## Destroy local stack ##
    // ??? We will have problems if other classes are holding a reference to any of these.
    self.managedObjectModel = nil;
    self.persistentStoreCoordinator = nil;
    self.publicContext = nil;
    self.privateContext = nil;
    
    // ## Create ManagedObjectModel ##
    self.managedObjectModel = [self newManagedObjectModelWithModelDescriptors:modelDescriptors];
    if (self.managedObjectModel == nil) {
        if (handlerOrNil != nil) {
            NSError *error = [CDSErrors errorForErrorCode:CDSErrorCodeFailedToInitiliseManagedObjectModel
                                               withObject:nil];
            handlerOrNil(NO,error);
        }
        return;
    }

    // ## Create NSPersistentStoreCoordinator ##
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managedObjectModel];
    if (self.persistentStoreCoordinator == nil) {
        if (handlerOrNil != nil) {
            NSError *error = [CDSErrors errorForErrorCode:CDSErrorCodeFailedToInitilisePersistentStoreCoordinator
                                               withObject:nil];
            handlerOrNil(NO,error);
        }
        return;
    }

    // ## Create Private NSManagedObjectContext ##
    self.privateContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    if (self.privateContext == nil) {
        if (handlerOrNil != nil) {
            NSError *error = [CDSErrors errorForErrorCode:CDSErrorCodeFailedToInitilisePrivateContext
                                               withObject:nil];
            handlerOrNil(NO,error);
        }
        return;
    }
    
    // ## Create Public NSManagedObjectContext ##
    self.publicContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    if (self.publicContext == nil) {
        if (handlerOrNil != nil) {
            NSError *error = [CDSErrors errorForErrorCode:CDSErrorCodeFailedToInitilisePublicContext
                                               withObject:nil];
            handlerOrNil(NO,error);
        }
        return;
    }

    
    // ## Final Configuration ##
    self.publicContext.parentContext = self.privateContext;
    self.privateContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    
    [self configurePersistentStoresWithStoreDescriptors:storeDescriptors
                                      completionHandler:handlerOrNil];
    
}

//--------------------------------------------------------
#pragma mark - Public Accessors
//--------------------------------------------------------
-(NSManagedObjectContext *)managedObjectContext{
    return self.publicContext;
}

//--------------------------------------------------------
#pragma mark - ManagedObjectContext
//--------------------------------------------------------
-(void)saveWithCompletion:(CDSBooleanCompletionHandler)handlerOrNil{
    
    
    //Always start from the main thread
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self saveWithCompletion:handlerOrNil];
        });
        return;
    }
    
    // if no changes to save, lets get outta here!
    if (![self.privateContext hasChanges] && ![self.managedObjectContext hasChanges]) {
        if (handlerOrNil != nil) {
            handlerOrNil(YES,nil);
        }
        return;
    }
    
    // do saving here
    [self.managedObjectContext performBlockAndWait:^{
        
        NSError *error = nil;
        BOOL mainContextSaved = NO;
        mainContextSaved = [self.managedObjectContext save:&error];
        if (!mainContextSaved) {
            if (handlerOrNil != nil) {
                handlerOrNil(NO,error);
            }
            return;
        }
        
        [self.privateContext performBlock:^{
            
            NSError *privateError = nil;
            BOOL privateContextSaved = NO;
            privateContextSaved = [self.privateContext save:&privateError];
            if (!privateContextSaved) {
                if (handlerOrNil != nil) {
                    handlerOrNil(NO,privateError);
                }
                return;
            }
            
            // SUCCESSFULLY SAVED
            if (handlerOrNil != nil) {
                handlerOrNil(YES,nil);
            }
        }];
    }];

}




//--------------------------------------------------------
#pragma mark - Persistent Store
//--------------------------------------------------------
/// Delete a single persistent store
-(void)deletePersistentStoreWithURL:(NSURL *)URL withCompletion:(CDSBooleanCompletionHandler)handlerOrNil{
    
    // Find a matching NSPersistentStore
    NSString *urlKeyPath = @"URL";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K = %@",urlKeyPath,URL];
    NSArray *matching = [self.persistentStoreCoordinator.persistentStores filteredArrayUsingPredicate:pred];
    
    NSError *error = nil;
    BOOL success = NO;
    if (matching.count == 0) {
        
        // Report an error if no match found.
        error = [CDSErrors errorForErrorCode:CDSErrorCodePersistentStoreNotFoundAtURL
                                  withObject:URL];
        success = NO;
        
    }else{
        
        // If a match is found then attempt to delete it, report the error if deletion fails.
        NSPersistentStore *store = matching.firstObject;
        /* Delete the stores */
        if (![self.persistentStoreCoordinator removePersistentStore:store error:&error]) {
            success = NO;
        }else{
            // Successfully removed store from coordinator, now try and delete the file
            success = [[NSFileManager defaultManager] removeItemAtURL:URL error:&error];
        }
    }
    
    if (handlerOrNil != nil) {
        handlerOrNil(success,error);
    }
    
}

/// Delete all the Persistent Stores - not so persistent now are you!
-(void)deleteAllPersistentStoresWithCompletion:(nullable CDSBooleanCompletionHandler)handlerOrNil{
    
    // ## Delete Stores ##
    // Attempt to remove stores from coordinator but save the url each time
    NSError *error;
    NSMutableArray *storeURLs = [NSMutableArray arrayWithCapacity:self.persistentStoreCoordinator.persistentStores.count];
    for (NSPersistentStore *store in self.persistentStoreCoordinator.persistentStores) {
        
        [storeURLs addObject:[store.URL copy]];
        
        /* Delete the stores */
        if (![self.persistentStoreCoordinator removePersistentStore:store error:&error]) {
            if (handlerOrNil != nil) {
                handlerOrNil(NO,error);
            }
            return;
        }
    }

    // ## Delete Files ##
    for (NSURL *storeURL in storeURLs) {
        
        if (![[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error]) {
            if (handlerOrNil != nil) {
                handlerOrNil(NO,error);
            }
            return;
        }
    }
    
    // ## If this far then success ##
    if (handlerOrNil != nil) {
        handlerOrNil(YES,nil);
    }
    
}


/// Creates persistentStore/s and adds to self.persistentStoreCoordinator. Works on background queue. Creates a store for each storeDescriptor held or if none then creates a single store with the name "MainStore"
-(void)configurePersistentStoresWithStoreDescriptors:(nullable NSArray<CDSPersistentStoreDescriptor *> *)storeDescriptors completionHandler:(CDSBooleanCompletionHandler)handlerOrNil{
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSError *localError = nil;
        
        if (storeDescriptors.count >= 1) {
            
            // For each descriptor, creat a store and add it to coordinator
            for (CDSPersistentStoreDescriptor *descriptor in storeDescriptors) {
                
                NSPersistentStore *store = [self.persistentStoreCoordinator addPersistentStoreWithType:descriptor.type
                                                                                         configuration:descriptor.configuration
                                                                                                   URL:descriptor.URL
                                                                                               options:descriptor.options
                                                                                                 error:&localError];
                // If any of the stores are nil then return/complete
                if (store == nil) {
                    if (handlerOrNil != nil) {
                        handlerOrNil(NO,localError);
                    }
                    return;
                }
            }
            
        }else{
            
            // Create a descriptor which will have default values, use that to add a single store.
            CDSPersistentStoreDescriptor *defaultDescriptor = [CDSPersistentStoreDescriptor persistentStoreDescriptor];
            defaultDescriptor.name = @"MainStore";
            NSPersistentStore *store =  [self.persistentStoreCoordinator addPersistentStoreWithType:defaultDescriptor.type
                                                                                      configuration:defaultDescriptor.configuration
                                                                                                URL:defaultDescriptor.URL
                                                                                            options:defaultDescriptor.options
                                                                                              error:&localError];
            // If the stores is nil then return/complete
            if (store == nil) {
                if (handlerOrNil != nil) {
                    handlerOrNil(NO,localError);
                }
                return;
            }
            
        }
        
        // If we get to this point it must have been a success
        if (handlerOrNil != nil) {
            handlerOrNil(YES,localError);
        }
        
        
    });
}




//--------------------------------------------------------
#pragma mark - Managed Object Model
//--------------------------------------------------------
/// Creates the managedObjectModel. If model descriptors are not nil then those are used to create models and then merge into 1 model. If no descriptors are nil then we merge any models from the main bundle.
-(void)configureManagedObjectModelWithModelDescriptors:(nullable NSArray<CDSManagedObjectModelDescriptor *> *)modelDescriptors completionHandler:(CDSBooleanCompletionHandler)handlerOrNil{
    
    self.managedObjectModel = [self newManagedObjectModelWithModelDescriptors:modelDescriptors];
    
    if (self.managedObjectModel == nil) {
        
        if (handlerOrNil != nil) {
            NSError *error = [CDSErrors errorForErrorCode:CDSErrorCodeFailedToInitiliseManagedObjectModel
                                               withObject:nil];
            handlerOrNil(NO,error);
        }
        return;
        
    }else{
        
        if (handlerOrNil != nil) {
            handlerOrNil(YES,nil);
        }

    }

}



//======================================================
#pragma mark - ** Protocol Methods **
//======================================================




//======================================================
#pragma mark - ** Private Methods **
//======================================================

//--------------------------------------------------------
#pragma mark - Configuration Helpers
//--------------------------------------------------------
/// Creates the managedObjectModel. If model descriptors are not nil then those are used to create models and then merge into 1 model. If no descriptors are nil then we merge any models from the main bundle.
-(NSManagedObjectModel*)newManagedObjectModelWithModelDescriptors:(nullable NSArray<CDSManagedObjectModelDescriptor *> *)modelDescriptors{
    
    NSManagedObjectModel *managedObjectModel;
    
    if (!managedObjectModel) {
        
        if (modelDescriptors.count == 0) {
            
            managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:@[[NSBundle mainBundle]]];
            
        }else{
            
            NSMutableArray *models = [NSMutableArray arrayWithCapacity:modelDescriptors.count];
            for (CDSManagedObjectModelDescriptor *descriptor in modelDescriptors) {
                
                NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:descriptor.URL];
                [models addObject:model];
            }
            
            managedObjectModel = [NSManagedObjectModel modelByMergingModels:[models copy]];
        }
    }
    return managedObjectModel;
}







@end
