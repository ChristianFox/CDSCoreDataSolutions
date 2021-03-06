/********************************
 *
 * Copyright © 2016-2018 Christian Fox
 *
 * MIT Licence - Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with CDSCoreDataSolutions
 *
 ************************************/



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
        [self registerForNotifications];

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
#pragma mark - NSObject
//--------------------------------------------------------
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
    self.mainQueueContext = nil;
    self.persistenceContext = nil;
    
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

    /**********************
     
     WARNING:
     Be careful with changing the order of the code below. If was in a different order and there was a issue which would cause crashes when executing a fetch request on some entities (Motorbike, occassionally Car).
     After much testing and research I found the link below and re-ordered the code and the crash went away.
     http://stackoverflow.com/questions/32216188/crash-with-many-to-many-nsmanagedobject-relationship-lookup-in-swift-2-0
     The commit where this changes will be tag 0.6.3, version 0.6.3, commit name: "Motorbike crash fix"
     
     **********************/
    
    // ## Create Private NSManagedObjectContext ##
    self.persistenceContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.persistenceContext.name = kCDSPersistenceContextName;
    self.persistenceContext.mergePolicy = [[NSMergePolicy alloc]initWithMergeType:NSMergeByPropertyObjectTrumpMergePolicyType];
    if (self.persistenceContext == nil) {
        if (handlerOrNil != nil) {
            NSError *error = [CDSErrors errorForErrorCode:CDSErrorCodeFailedToInitilisePersistenceContext
                                               withObject:nil];
            handlerOrNil(NO,error);
        }
        return;
    }
    
    // ## Create Public NSManagedObjectContext ##
    self.mainQueueContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.mainQueueContext.name = kCDSMainQueueContextName;
    self.mainQueueContext.mergePolicy = [[NSMergePolicy alloc]initWithMergeType:NSMergeByPropertyObjectTrumpMergePolicyType];
    if (self.mainQueueContext == nil) {
        if (handlerOrNil != nil) {
            NSError *error = [CDSErrors errorForErrorCode:CDSErrorCodeFailedToInitiliseMainQueueContext
                                               withObject:nil];
            handlerOrNil(NO,error);
        }
        return;
    }
    self.persistenceContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    self.mainQueueContext.parentContext = self.persistenceContext;

    
    // ## Configure Persistent Stores and finish context config ##
    
    [self configurePersistentStoresWithStoreDescriptors:storeDescriptors
                                      completionHandler:handlerOrNil];
    
}

-(BOOL)configureStackSynchronouslyWithModelDescriptors:(NSArray<CDSManagedObjectModelDescriptor *> *)modelDescriptors
                                      storeDescriptors:(NSArray<CDSPersistentStoreDescriptor *> *)storeDescriptors
                                                 error:(NSError * _Nullable __autoreleasing *)error{
    
    // ## Destroy local stack ##
    // ??? We will have problems if other classes are holding a reference to any of these.
    self.managedObjectModel = nil;
    self.persistentStoreCoordinator = nil;
    self.mainQueueContext = nil;
    self.persistenceContext = nil;
    
    // ## Create ManagedObjectModel ##
    self.managedObjectModel = [self newManagedObjectModelWithModelDescriptors:modelDescriptors];
    if (self.managedObjectModel == nil) {
        if (error != nil) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeFailedToInitiliseManagedObjectModel
                                               withObject:nil];
            
        }
        return NO;
    }
    
    // ## Create NSPersistentStoreCoordinator ##
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managedObjectModel];
    if (self.persistentStoreCoordinator == nil) {
        if (error != nil) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeFailedToInitilisePersistentStoreCoordinator
                                               withObject:nil];
        }
        return NO;
    }
    
    /**********************
     
     WARNING:
     Be careful with changing the order of the code below. If was in a different order and there was a issue which would cause crashes when executing a fetch request on some entities (Motorbike, occassionally Car).
     After much testing and research I found the link below and re-ordered the code and the crash went away.
     http://stackoverflow.com/questions/32216188/crash-with-many-to-many-nsmanagedobject-relationship-lookup-in-swift-2-0
     The commit where this changes will be tag 0.6.3, version 0.6.3, commit name: "Motorbike crash fix"
     
     **********************/
    
    // ## Create Private NSManagedObjectContext ##
    self.persistenceContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.persistenceContext.name = kCDSPersistenceContextName;
    self.persistenceContext.mergePolicy = [[NSMergePolicy alloc]initWithMergeType:NSMergeByPropertyObjectTrumpMergePolicyType];
    if (self.persistenceContext == nil) {
        if (error != nil) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeFailedToInitilisePersistenceContext
                                               withObject:nil];
        }
        return NO;
    }
    
    // ## Create Public NSManagedObjectContext ##
    self.mainQueueContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.mainQueueContext.name = kCDSMainQueueContextName;
    self.mainQueueContext.mergePolicy = [[NSMergePolicy alloc]initWithMergeType:NSMergeByPropertyObjectTrumpMergePolicyType];
    if (self.mainQueueContext == nil) {
        if (error != nil) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeFailedToInitiliseMainQueueContext
                                               withObject:nil];
        }
        return NO;
    }
    self.persistenceContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    self.mainQueueContext.parentContext = self.persistenceContext;
    
    
    // ## Configure Persistent Stores and finish context config ##
    return [self configurePersistentStoresWithStoreDescriptors:storeDescriptors error:error];
}


//--------------------------------------------------------
#pragma mark - Public Accessors
//--------------------------------------------------------



//--------------------------------------------------------
#pragma mark - ManagedObjectContext
//--------------------------------------------------------
-(NSManagedObjectContext*)newBackgroundContext{
    
    // ## Create NSManagedObjectContext ##
    NSManagedObjectContext *bgContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    
    bgContext.parentContext = self.persistenceContext;
    bgContext.name = kCDSBackgroundQueueContextName;
    bgContext.mergePolicy = [[NSMergePolicy alloc]initWithMergeType:NSMergeByPropertyObjectTrumpMergePolicyType];

    return bgContext;
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
    
   
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
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
            handlerOrNil(YES,nil);
        }
        
        
    });
}

-(BOOL)configurePersistentStoresWithStoreDescriptors:(nullable NSArray<CDSPersistentStoreDescriptor *> *)storeDescriptors
                                               error:(NSError * _Nullable __autoreleasing *)error{

    
    
    if (storeDescriptors.count >= 1) {
        
        // For each descriptor, creat a store and add it to coordinator
        for (CDSPersistentStoreDescriptor *descriptor in storeDescriptors) {
            
            
            NSPersistentStore *store = [self.persistentStoreCoordinator addPersistentStoreWithType:descriptor.type
                                                                                     configuration:descriptor.configuration
                                                                                               URL:descriptor.URL
                                                                                           options:descriptor.options
                                                                                             error:error];
            // If any of the stores are nil then return
            if (store == nil) {
                return NO;
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
                                                                                          error:error];
        // If the stores is nil then return
        if (store == nil) {
            return NO;
        }
        
    }
    
    // If we get to this point it must have been a success
    return YES;
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


//--------------------------------------------------------
#pragma mark - Notifications
//--------------------------------------------------------
-(void)registerForNotifications{
    
 
    [[NSNotificationCenter defaultCenter]addObserverForName:NSManagedObjectContextWillSaveNotification
                                                     object:nil
                                                      queue:nil
                                                 usingBlock:^(NSNotification * _Nonnull note)
     {
         NSManagedObjectContext *context = note.object;
         if (context == self.persistenceContext || context.parentContext == self.persistenceContext) {
             
             if ([self.loggingDelegate respondsToSelector:@selector(logNotificationReceived:withMessage:)]) {
                 
                 NSString *message = [NSString stringWithFormat:@"Will save context with name: %@",context.name];
                 [self.loggingDelegate logNotificationReceived:note
                                                   withMessage:message];
             }
             
         }
         
     }];
    
    [[NSNotificationCenter defaultCenter]addObserverForName:NSManagedObjectContextDidSaveNotification
                                                     object:nil
                                                      queue:nil
                                                 usingBlock:^(NSNotification * _Nonnull note)
    {
        
        NSManagedObjectContext *context = note.object;
        if (context == self.persistenceContext || context.parentContext == self.persistenceContext) {

            
            if ([self.loggingDelegate respondsToSelector:@selector(logNotificationReceived:withMessage:)]) {
                NSString *message = [NSString stringWithFormat:@"Inserted: %lu, Updated: %lu, Deleted: %lu, Refresed: %lu, Invalidated: %lu",
                                     (unsigned long)[note.userInfo[NSInsertedObjectsKey] count],
                                     (unsigned long)[note.userInfo[NSUpdatedObjectsKey] count],
                                     (unsigned long)[note.userInfo[NSDeletedObjectsKey] count],
                                     (unsigned long)[note.userInfo[NSRefreshedObjectsKey] count],
                                     (unsigned long)[note.userInfo[NSInvalidatedObjectsKey] count]];
                
                [self.loggingDelegate logNotificationReceived:note
                                                  withMessage:message];
            }
            
            NSManagedObjectContext *parentContext = context.parentContext;
            [parentContext performBlockAndWait:^{
                
                if ([self.loggingDelegate respondsToSelector:@selector(logInfo:)]) {
                    NSString *message = [NSString stringWithFormat:@"Child context saved. Will save parent: %@",parentContext.name];
                    [self.loggingDelegate logInfo:message];
                }
                
                if (parentContext.hasChanges) {
                    NSError *error;
                    if (![parentContext save:&error]) {
                        if (error != nil) {
                            
                            if ([self.loggingDelegate respondsToSelector:@selector(logError:withPrefix:message:)]) {
                                NSString *contextName = [context.name copy];
                                NSString *parentName = [parentContext.name copy];
                                NSString *message = [NSString stringWithFormat:@"Parent context: %@ failed to save after child did save: %@",parentName,contextName];
                                [self.loggingDelegate logError:error withPrefix:@"CDS_ERROR" message:message];
                            }
                        }
                    }
                    
                }
            }];
            
        }

        
        
        
        
    }];

    
}





@end
