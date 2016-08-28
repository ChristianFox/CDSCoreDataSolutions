//
//  CDSCoreDataStack.h
//  Pods
//
//  Created by Christian Fox on 06/05/2016.
//
//

@import Foundation;
@import CoreData;
@class CDSPersistentStoreDescriptor;
@class CDSManagedObjectModelDescriptor;
#import "CDSDefinitions.h"
#import "CDSLoggingDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@interface CDSCoreDataStack : NSObject

@property (weak, nonatomic) id<CDSLoggingDelegate> loggingDelegate;
@property (strong,nonatomic,readonly) NSManagedObjectModel *managedObjectModel;
@property (strong,nonatomic,readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic,readonly) NSManagedObjectContext *mainQueueContext;

//--------------------------------------------------------
#pragma mark - Initilise & Configure
//--------------------------------------------------------
/// Returns a singleton instance of CDSCoreDataStack. Actual stack is not configured yet, you need to call configure method separately.
+(instancetype)sharedStack;

/// Returns an instance of CDSCoreDataStack. Actual stack is not configured yet, you need to call configure method separately.
-(instancetype)init NS_DESIGNATED_INITIALIZER;

/**
 *  Configure the core data stack (model, context, store/s & store coordinator). Call this method after initilising an instance using init or sharedStack. Pass in descriptors or don't. Completion block will be called once the entire stack is initilised. Some of the work will be done on a background queue and the completion block is called from that queue.
 *
 *  @param modelDescriptors An array of CDSManagedObjectModelDescriptor objects. Each descriptor should describe a ManagedObjectModel included in the project. If nil, then all models found in the main bundle will be merged and used.
 *  @param storeDescriptors An array of CDSPersistentStoreDescriptor objects. Each descriptor should describe a persistent store to use to save data. If nil then a single persistent store will be created using the CDSPersistentStoreDescriptor default settings (NSSQLiteType, in the documents directory) with the name "MainStore.sqlite".
 *  @param handlerOrNil     A block to be called once the entire stack has been configured. Will pass NO if the stack configuration failed and may also provide an NSError.
 *
 *  @since 0.1.0
 */
-(void)configureStackWithModelDescriptors:(nullable NSArray<CDSManagedObjectModelDescriptor*>*)modelDescriptors
                         storeDescriptors:(nullable NSArray<CDSPersistentStoreDescriptor*>*)storeDescriptors
                               completion:(nullable CDSBooleanCompletionHandler)handlerOrNil;

//--------------------------------------------------------
#pragma mark - ManagedObjectContext
//--------------------------------------------------------
/**
 * Create a new NSManagedObjectContext with NSPrivateQueueConcurrencyType.
 * You should use one of these to do any long running non-UI related work and then call save on that context to have it's changes propagated to its parent - which is the stack's root context with private concurrency type that has direct access to the store coordinator.
 * @return A newly instantiated context
 */
-(NSManagedObjectContext*)newBackgroundContext;


/**
 * If changes have occurred then save is called on the context
 * @param completionHandler: Provides a BOOL for success status and an NSError object which may be nil
 */
-(void)saveWithCompletion:(nullable CDSBooleanCompletionHandler)handlerOrNil;

//--------------------------------------------------------
#pragma mark - Persistent Store
//--------------------------------------------------------
/**
 *   Delete a single persistent store. Uses the URL & configuration name in the storeDescriptor to find a match with the NSPersistentStoreCoordinator's stores. If no match is found we create an NSError in the completion handler. If a match is found it is deleted.
 *
 *  @param url The URL in the local file system where the store backing file is stored. If you used store descriptors the URL can be gotten from the descriptor used to configure the stack in the first place, if you did not then the URL is the documents directory + the default store name "MainStore".
 *  @param completionHandler: Provides a BOOL for success status and an NSError object which may be nil
 *  @since 0.1.0
 */
-(void)deletePersistentStoreWithURL:(NSURL*)URL withCompletion:(nullable CDSBooleanCompletionHandler)handlerOrNil;

/// Delete all the Persistent Stores - not so persistent now are you!
-(void)deleteAllPersistentStoresWithCompletion:(nullable CDSBooleanCompletionHandler)handlerOrNil;

/// Creates persistentStore/s and adds to self.persistentStoreCoordinator. Works on background queue. Creates a store for each storeDescriptor held or if none then creates a single store with the name "MainStore"
-(void)configurePersistentStoresWithStoreDescriptors:(nullable NSArray<CDSPersistentStoreDescriptor *> *)storeDescriptors completionHandler:(nullable CDSBooleanCompletionHandler)handlerOrNil;

//--------------------------------------------------------
#pragma mark - Managed Object Model
//--------------------------------------------------------
/// Creates the managedObjectModel. If model descriptors are not nil then those are used to create models and then merge into 1 model. If descriptors are nil then we merge any models from the main bundle.
-(void)configureManagedObjectModelWithModelDescriptors:(nullable NSArray<CDSManagedObjectModelDescriptor *> *)modelDescriptors completionHandler:(nullable CDSBooleanCompletionHandler)handlerOrNil;

@end
NS_ASSUME_NONNULL_END