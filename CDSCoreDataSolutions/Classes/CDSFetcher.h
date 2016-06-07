//
//  CDSFetcher.h
//  Pods
//
//  Created by Eyeye on 08/05/2016.
//
//

#import <Foundation/Foundation.h>
@class NSManagedObjectContext;
@class NSManagedObject;
@class NSFetchRequest;

NS_ASSUME_NONNULL_BEGIN
@interface CDSFetcher : NSObject

@property (nonatomic, getter=shouldValidate) BOOL validate;



//--------------------------------------------------------
#pragma mark - Initilise
//--------------------------------------------------------
/**
 *  Initilises an instance of CDSFetcher. If preprocessor flag DEBUG is off then the validate property will be set to NO otherwise it will be set to YES and a validator object initilised as well.
 *
 *  @return An instance of CDSFetcher
 *
 *  @since 0.1.0
 */
+(instancetype)fetcher;

/**
 *  Initilises an instance of CDSFetcher. If validate parameter is set to NO then the receiver's validate property will be set to NO otherwise it will be set to YES and a validator object initilised as well.
 *
 *  @param validate  A boolean indicating if the fetcher should validate the parameters before each fetch request is created/executed.
 *  @return An instance of CDSFetcher
 *
 *  @since 0.1.0
 */
+(instancetype)fetcherWithValidation:(BOOL)validate; 

//--------------------------------------------------------
#pragma mark - Fetch all
//--------------------------------------------------------
/**
 *  Executes a fetch request on the given context. Fetches all instances of the specified entity. If validate property of the receiver is set to YES then will validate parameters and return an error if any of them fail.
 *
 *  @param entityName The name of the entity.
 *  @param context    The context to fetch from.
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem. Can be nil.
 *
 *  @return An array of NSManagedObjects. Could be an empty array if no matching managed objects were found. Could be nil if an error occured.
 *
 *  @since 0.1.0
 */
-(NSArray<NSManagedObject*>*__nullable)fetchAllWithEntityName:(NSString*)entityName
                                                      context:(NSManagedObjectContext*)context
                                                        error:(NSError*__nullable*)error;

/**
 *  Executes a fetch request on the given context. Fetches all instances of the specified entity. If validate property of the receiver is set to YES then will validate parameters and return an error if any of them fail.
 *
 *  @param entityName The name of the entity.
 *  @param batchSize  The batch size to be passed into the fetch request. The default value is 0. A batch size of 0 is treated as infinite, which disables the batch faulting behavior.
 If you set a non-zero batch size, the collection of objects returned when the fetch is executed is broken into batches.
 *  @param fetchLimit The fetch limit to be passed into the fetch request. The fetch limit specifies the maximum number of objects that a request should return when executed.
 *  @param context    The context to fetch from.
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem. Can be nil.
 *
 *  @return An array of NSManagedObjects. Could be an empty array if no matching managed objects were found. Could be nil if an error occured.
 *
 *  @since 0.1.0
 */
-(NSArray<NSManagedObject*>*__nullable)fetchAllWithEntityName:(NSString*)entityName
                                                    batchSize:(NSUInteger)batchSize
                                                   fetchLimit:(NSUInteger)fetchLimit
                                                      context:(NSManagedObjectContext*)context
                                                        error:(NSError*__nullable*)error;

//--------------------------------------------------------
#pragma mark - Fetch with Fetch Request
//--------------------------------------------------------
/**
 *  Executes the given fetch request on the given context. If validate property of the receiver is set to YES then will validate parameters and return an error if any of them fail.
 *
 *  @param fetchRequest The fetch request to execute.
 *  @param context    The context to fetch from.
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem. Can be nil.
 *
 *  @return An array of NSManagedObjects. Could be an empty array if no matching managed objects were found. Could be nil if an error occured.
 *
 *  @since 0.1.0
 */
-(NSArray<NSManagedObject*>*__nullable)fetchWithFetchRequest:(NSFetchRequest*)fetchRequest
                                                     context:(NSManagedObjectContext*)context
                                                       error:(NSError*__nullable*)error;



//--------------------------------------------------------
#pragma mark - Fetch with predicate
//--------------------------------------------------------
/**
 *  Executes a fetch request using the predicate on the given context. If validate property of the receiver is set to YES then will validate parameters and return an error if any of them fail.
 *
 *  @param predicate  The predicate to use to filter the managed objects.
 *  @param entityName The name of the entity.
 *  @param context    The context to fetch from.
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem. Can be nil.
 *
 *  @return An array of NSManagedObjects. Could be an empty array if no matching managed objects were found. Could be nil if an error occured.
 *
 *  @since 0.1.0
 */
-(NSArray<NSManagedObject*>*__nullable)fetchFilteredWithPredicate:(NSPredicate*)predicate
                                                       entityName:(NSString*)entityName
                                                          context:(NSManagedObjectContext*)context
                                                            error:(NSError*__nullable*)error;

/**
 *  Executes a fetch request using the predicate on the given context. If validate property of the receiver is set to YES then will validate parameters and return an error if any of them fail.
 *
 *  @param predicate  The predicate to use to filter the managed objects.
 *  @param batchSize  The batch size to be passed into the fetch request. The default value is 0. A batch size of 0 is treated as infinite, which disables the batch faulting behavior.
 If you set a non-zero batch size, the collection of objects returned when the fetch is executed is broken into batches.
 *  @param fetchLimit The fetch limit to be passed into the fetch request. The fetch limit specifies the maximum number of objects that a request should return when executed.
 *  @param entityName The name of the entity.
 *  @param context    The context to fetch from.
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem. Can be nil.
 *
 *  @return An array of NSManagedObjects. Could be an empty array if no matching managed objects were found. Could be nil if an error occured.
 *
 *  @since 0.1.0
 */
-(NSArray<NSManagedObject*>*__nullable)fetchFilteredWithPredicate:(NSPredicate*)predicate
                                                        batchSize:(NSUInteger)batchSize
                                                       fetchLimit:(NSUInteger)fetchLimit
                                                       entityName:(NSString*)entityName
                                                          context:(NSManagedObjectContext*)context
                                                            error:(NSError*__nullable*)error;

//--------------------------------------------------------
#pragma mark - Fetch Containing string
//--------------------------------------------------------
/**
 *  Executes a fetch request on the given context. Fetches all instances of the specified entity where the value at the key path contains the string. If validate property of the receiver is set to YES then will validate parameters and return an error if any of them fail.
 *
 *  @param string     The string as search term
 *  @param keyPath    The keypath on the entity. Value at key path should be a string.
 *  @param entityName The name of the entity.
 *  @param context    The context to fetch from.
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem. Can be nil.
 *
 *  @return An array of NSManagedObjects. Could be an empty array if no matching managed objects were found. Could be nil if an error occured.
 *
 *  @since 0.1.0
 */
-(NSArray<NSManagedObject*>*__nullable)fetchFilteredByContainingString:(NSString*)string
                                                             atKeyPath:(NSString*)keyPath
                                                            entityName:(NSString*)entityName
                                                               context:(NSManagedObjectContext*)context
                                                                 error:(NSError*__nullable*)error;

/**
 *  Executes a fetch request on the given context. Fetches all instances of the specified entity where the value at the key path contains the string. If validate property of the receiver is set to YES then will validate parameters and return an error if any of them fail.
 *
 *  @param string     The string as search term
 *  @param keyPath    The keypath on the entity. Value at key path should be a string.
 *  @param batchSize  The batch size to be passed into the fetch request. The default value is 0. A batch size of 0 is treated as infinite, which disables the batch faulting behavior.
 If you set a non-zero batch size, the collection of objects returned when the fetch is executed is broken into batches.
 *  @param fetchLimit The fetch limit to be passed into the fetch request. The fetch limit specifies the maximum number of objects that a request should return when executed.
 *  @param entityName The name of the entity.
 *  @param context    The context to fetch from.
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem. Can be nil.
 *
 *  @return An array of NSManagedObjects. Could be an empty array if no matching managed objects were found. Could be nil if an error occured.
 *
 *  @since 0.1.0
 */
-(NSArray<NSManagedObject*>*__nullable)fetchFilteredByContainingString:(NSString*)string
                                                             atKeyPath:(NSString*)keyPath
                                                             batchSize:(NSUInteger)batchSize
                                                            fetchLimit:(NSUInteger)fetchLimit
                                                            entityName:(NSString*)entityName
                                                               context:(NSManagedObjectContext*)context
                                                                 error:(NSError*__nullable*)error;


//--------------------------------------------------------
#pragma mark - Fetch matching multiple objects
//--------------------------------------------------------
/**
 *  Executes a fetch request on the given context. Fetches all instances of the specified entity where all the values at the key paths match the corrresponding objects. Builds a compound predicate with the objects and keypaths. The keypaths and related objects should be using the same indexes - so make sure your arrays are in the right order. If validate property of the receiver is set to YES then will validate parameters and return an error if any of them fail.
 *
 *  @param objects    The objects to match against.
 *  @param keyPaths   The keypaths on the entity. Value at key path should be a NSString, NSNumber or NSDate.
 *  @param entityName The name of the entity.
 *  @param context    The context to fetch from.
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem. Can be nil.
 *
 *  @return An array of NSManagedObjects. Could be an empty array if no matching managed objects were found. Could be nil if an error occured.
 *
 *  @since 0.1.0
 */
-(NSArray<NSManagedObject*>*__nullable)fetchMatchingAllObjects:(NSArray<id>*)objects
                                                    atKeyPaths:(NSArray<NSString*>*)keyPaths
                                                    entityName:(NSString*)entityName
                                                       context:(NSManagedObjectContext*)context
                                                         error:(NSError*__nullable*)error;


/**
 *  Executes a fetch request on the given context. Fetches all instances of the specified entity where all the values at the key paths match the corrresponding objects. Builds a compound predicate with the objects and keypaths. The keypaths and related objects should be using the same indexes - so make sure your arrays are in the right order. If validate property of the receiver is set to YES then will validate parameters and return an error if any of them fail.
 *
 *  @param objects    The objects to match against.
 *  @param keyPaths   The keypaths on the entity. Value at key path should be a NSString, NSNumber or NSDate.
 *  @param batchSize  The batch size to be passed into the fetch request. The default value is 0. A batch size of 0 is treated as infinite, which disables the batch faulting behavior.
 If you set a non-zero batch size, the collection of objects returned when the fetch is executed is broken into batches.
 *  @param fetchLimit The fetch limit to be passed into the fetch request. The fetch limit specifies the maximum number of objects that a request should return when executed.
 *  @param entityName The name of the entity.
 *  @param context    The context to fetch from.
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem. Can be nil.
 *
 *  @return An array of NSManagedObjects. Could be an empty array if no matching managed objects were found. Could be nil if an error occured.
 *
 *  @since 0.1.0
 */
-(NSArray<NSManagedObject*>*__nullable)fetchMatchingAllObjects:(NSArray<id>*)objects
                                                    atKeyPaths:(NSArray<NSString*>*)keyPaths
                                                     batchSize:(NSUInteger)batchSize
                                                    fetchLimit:(NSUInteger)fetchLimit
                                                    entityName:(NSString*)entityName
                                                       context:(NSManagedObjectContext*)context
                                                         error:(NSError*__nullable*)error;
/**
 *  Executes a fetch request on the given context. Fetches all instances of the specified entity where any of the values at the key paths match the corresponding objects. Builds a compound predicate with the objects and keypaths. The keypaths and related objects should be using the same indexes - so make sure your arrays are in the right order. If validate property of the receiver is set to YES then will validate parameters and return an error if any of them fail.
 *
 *  @param objects    The objects to match against.
 *  @param keyPaths   The keypaths on the entity. Value at key path should be a NSString, NSNumber or NSDate.
 *  @param entityName The name of the entity.
 *  @param context    The context to fetch from.
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem. Can be nil.
 *
 *  @return An array of NSManagedObjects. Could be an empty array if no matching managed objects were found. Could be nil if an error occured.
 *
 *  @since 0.1.0
 */
-(NSArray<NSManagedObject*>*__nullable)fetchMatchingAnyObjects:(NSArray<id>*)objects
                                                    atKeyPaths:(NSArray<NSString*>*)keyPaths
                                                    entityName:(NSString*)entityName
                                                       context:(NSManagedObjectContext*)context
                                                         error:(NSError*__nullable*)error;
/**
 *  Executes a fetch request on the given context. Fetches all instances of the specified entity where any of the values at the key paths match the corresponding objects. Builds a compound predicate with the objects and keypaths. The keypaths and related objects should be using the same indexes - so make sure your arrays are in the right order. If validate property of the receiver is set to YES then will validate parameters and return an error if any of them fail.
 *
 *  @param objects    The objects to match against.
 *  @param keyPaths   The keypaths on the entity. Value at key path should be a NSString, NSNumber or NSDate.
 *  @param batchSize  The batch size to be passed into the fetch request. The default value is 0. A batch size of 0 is treated as infinite, which disables the batch faulting behavior.
 If you set a non-zero batch size, the collection of objects returned when the fetch is executed is broken into batches.
 *  @param fetchLimit The fetch limit to be passed into the fetch request. The fetch limit specifies the maximum number of objects that a request should return when executed.
 *  @param entityName The name of the entity.
 *  @param context    The context to fetch from.
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem. Can be nil.
 *
 *  @return An array of NSManagedObjects. Could be an empty array if no matching managed objects were found. Could be nil if an error occured.
 *
 *  @since 0.1.0
 */
-(NSArray<NSManagedObject*>*__nullable)fetchMatchingAnyObjects:(NSArray<id>*)objects
                                                    atKeyPaths:(NSArray<NSString*>*)keyPaths
                                                     batchSize:(NSUInteger)batchSize
                                                    fetchLimit:(NSUInteger)fetchLimit
                                                    entityName:(NSString*)entityName
                                                       context:(NSManagedObjectContext*)context
                                                         error:(NSError*__nullable*)error;






@end
NS_ASSUME_NONNULL_END