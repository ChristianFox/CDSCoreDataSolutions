//
//  CDSAuditor.h
//  Pods
//
//  Created by Eyeye on 08/05/2016.
//
//

#import <Foundation/Foundation.h>
@class CDSCoreDataStack;

NS_ASSUME_NONNULL_BEGIN
@interface CDSAuditor : NSObject

+(instancetype)auditor;

//--------------------------------------------------------
#pragma mark - Entity Audit
//--------------------------------------------------------
/**
 * @return YES if the model contains an entity of that name
 **/
-(BOOL)existsEntityNamed:(NSString*)entityName
                 inModel:(NSManagedObjectModel*)model
                   error:(NSError*_Nullable*)error;
/**
 * @return YES if the context contains an entity of that name
 **/
-(BOOL)existsEntityNamed:(NSString*)entityName
               inContext:(NSManagedObjectContext*)context
                   error:(NSError*_Nullable*)error;

/**
 * @return YES if the entity has an attribute of that name
 */
-(BOOL)existsAttributeNamed:(NSString*)attributeName
             forEntityNamed:(NSString*)entityName
                  inContext:(NSManagedObjectContext*)context
                      error:(NSError**)error;

/**
 * @return YES if the entity has an relationship of that name
 */
-(BOOL)existsRelationshipNamed:(NSString*)relationshipName
                forEntityNamed:(NSString*)entityName
                     inContext:(NSManagedObjectContext*)context
                         error:(NSError**)error;

//--------------------------------------------------------
#pragma mark - Context Contents Audit
//--------------------------------------------------------

/**
 * @return YES if the context has 1 or more entries for that entity
 */
-(BOOL)existsContentsForEntityNamed:(NSString*)entityName
                          inContext:(NSManagedObjectContext*)context
                              error:(NSError**)error;

//--------------------------------------------------------
#pragma mark - Stack Contents Audit
//--------------------------------------------------------
/**
 * @return YES if the stack has 1 or more entries for that entity
 */
-(BOOL)existsContentsInStack:(CDSCoreDataStack*)stack error:(NSError **)error;


//--------------------------------------------------------
#pragma mark - Managed Object Count Audit
//--------------------------------------------------------
/**
 * @return number of entries for that entity in context
 */
-(NSUInteger)countOfManagedObjectsForEntityName:(NSString*)entityName
                                      inContext:(NSManagedObjectContext*)context
                                          error:(NSError**)error;

/**
 * @return number of entries for that entity in the stack
 */
-(NSUInteger)countOfManagedObjectsInStack:(CDSCoreDataStack*)stack
                                    error:(NSError**)error;

/**
 * @return A NSDictionary where keys are entity names and values are the number of entries for that entity. Includes all entities in stack
 */
-(NSDictionary*)countsKeyedByNamesOfEntitiesInStack:(CDSCoreDataStack*)stack
                                              error:(NSError**)error;





@end
NS_ASSUME_NONNULL_END