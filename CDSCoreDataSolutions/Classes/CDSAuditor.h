/********************************
 *
 * Copyright © 2016-2018 Christian Fox
 *
 * MIT Licence - Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with CDSCoreDataSolutions
 *
 ************************************/



#import <Foundation/Foundation.h>
@class CDSCoreDataStack;

NS_ASSUME_NONNULL_BEGIN
@interface CDSAuditor : NSObject


//--------------------------------------------------------
#pragma mark - Initilisation
//--------------------------------------------------------
/// Returns an instance of CDSAuditor
+(instancetype)auditor;

//--------------------------------------------------------
#pragma mark - Entity Audit
//--------------------------------------------------------
/**
 *  Determines if the model contains an entity with the specified name. 
 *
 *  @param entityName The entity name to look for.
 *  @param model      The NSManagedObjectModel to search in.
 *  @param error      If an entity does not exist or the model does not exist, upon return contains an NSError object that describes the reason.
 *
 *  @return YES if the model does contain an entity with that name, NO if it does not.
 *
 *  @since 0.1.0
 */
-(BOOL)existsEntityNamed:(NSString *)entityName
                 inModel:(NSManagedObjectModel*)model
                   error:(NSError*__nullable*)error;

/**
 *  Determines if the context contains an entity with the specified name.
 *
 *  @param entityName The entity name to look for.
 *  @param context    The NSManagedObjectContext to search in.
 *  @param error      If an entity does not exist or the context does not exist, upon return contains an NSError object that describes the reason.
 *
 *  @return YES if the context does contain an entity with that name, NO if it does not.
 *
 *  @since 0.1.0
 */
-(BOOL)existsEntityNamed:(NSString*)entityName
               inContext:(NSManagedObjectContext*)context
                   error:(NSError*__nullable*)error;

/**
 *  Determines if an entity has an attribute with the specified name.
 *
 *  @param attributeName The name of the attribute.
 *  @param entityName The name of the entity to check.
 *  @param context    The NSManagedObjectContext to search in.
 *  @param error      If an entity does not have the named attribute or the context or entity does not exist, upon return contains an NSError object that describes the reason.
 *
 *  @return YES if the entity has an attribute with that name, NO if it does not.
 *
 *  @since 0.1.0
 */
-(BOOL)existsAttributeNamed:(NSString*)attributeName
             forEntityNamed:(NSString*)entityName
                  inContext:(NSManagedObjectContext*)context
                      error:(NSError*__nullable*)error;

/**
 *  Determines if an entity has a relationship with the specified name.
 *
 *  @param relationshipName The name of the relationship
 *  @param entityName The name of the entity to check.
 *  @param context    The NSManagedObjectContext to search in.
 *  @param error      If an entity does not have the named relationship or the context or entity does not exist, upon return contains an NSError object that describes the reason.
 *
 *  @return YES if the entity has an relationship with that name, NO if it does not.
 *
 *  @since 0.1.0
 */
-(BOOL)existsRelationshipNamed:(NSString*)relationshipName
                forEntityNamed:(NSString*)entityName
                     inContext:(NSManagedObjectContext*)context
                         error:(NSError*__nullable*)error;


//--------------------------------------------------------
#pragma mark - Context Contents Audit
//--------------------------------------------------------


/**
 *  Determines if the context has contents.
 *
 *  @param entityName The name of the entity to check.
 *  @param context    The NSManagedObjectContext to check.
 *  @param error      If context does not have any contents, upon return contains an NSError object that describes the reason.
 *
 *  @return YES if the context has contents, NO if it does not.
 *
 *  @since 0.1.0
 */
-(BOOL)existsContentsForEntityNamed:(NSString*)entityName
                          inContext:(NSManagedObjectContext*)context
                              error:(NSError*__nullable*)error;

//--------------------------------------------------------
#pragma mark - Stack Contents Audit
//--------------------------------------------------------

/**
 *  Determines if the stack has contents
 *
 *  @param stack The CDSCoreDataStack to check.
 *  @param error If CDSCoreDataStack does not have any contents, upon return contains an NSError object that describes the reason.
 *
 *  @return YES if the stack has contents, NO if it does not.
 *
 *  @warning This method queries the stack's mainQueueContext (and therefore it's parent persistent context as well) but does not take into account and contexts created using the -newBackgroundContext method, so if you have inserted any ManagedObjects using a background context and have not saved them to the store they will not be counted.
 *
 *  @since 0.1.0
 */
-(BOOL)existsContentsInStack:(CDSCoreDataStack*)stack
                       error:(NSError *__nullable*)error;


//--------------------------------------------------------
#pragma mark - Managed Object Count Audit
//--------------------------------------------------------


/**
 *  Determines how many managed objects exist in the given context for the given entity name.
 *
 *  @param entityName The name of the entity
 *  @param context    The NSManagedObjectContext to check
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem.
 *
 *  @return The number of NSManagedObject instances of the entity in the context
 *
 *  @since 0.1.0
 */
-(NSUInteger)countOfManagedObjectsForEntityName:(NSString*)entityName
                                      inContext:(NSManagedObjectContext*)context
                                          error:(NSError*__nullable*)error;

/**
 *  Determines how many managed objects exist in the given stack for the given entity name.
 *
 *  @param stack    The CDSCoreDataStack to check
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem.
 *
 *  @return The number of NSManagedObject instances of the entity in the stack
 *
 *  @warning This method queries the stack's mainQueueContext (and therefore it's parent persistent context as well) but does not take into account and contexts created using the -newBackgroundContext method, so if you have inserted any ManagedObjects using a background context and have not saved them to the store they will not be counted.
 *
 *  @since 0.1.0
 */
-(NSUInteger)countOfManagedObjectsInStack:(CDSCoreDataStack*)stack
                                    error:(NSError*__nullable*)error;

/**
 *  Determines how many managed objects exist in the given CDSCoreDataStack for each entity defined in all the NSManagedObjectModels
 *
 *  @param stack    The CDSCoreDataStack to check
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem.
 *
 *  @return An NSDictionary where the keys are entity names found in any of the models represented by the stack, and values are a NSNumber storing the amount of managed objects for that entity.
 *
 *  @warning This method queries the stack's mainQueueContext (and therefore it's parent persistent context as well) but does not take into account and contexts created using the -newBackgroundContext method, so if you have inserted any ManagedObjects using a background context and have not saved them to the store they will not be counted.
 *
 *  @since 0.1.0
 */
-(NSDictionary*)countsKeyedByNamesOfEntitiesInStack:(CDSCoreDataStack*)stack
                                              error:(NSError*__nullable*)error;





@end
NS_ASSUME_NONNULL_END
