/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with CDSCoreDataSolutions
 *
 ************************************/

#import <Foundation/Foundation.h>
@import CoreData;
@class CDSCoreDataStack;

NS_ASSUME_NONNULL_BEGIN
@interface CDSValidator : NSObject

//--------------------------------------------------------
#pragma mark - Initilisation
//--------------------------------------------------------
/// Returns an instance of CDSValidator
+(instancetype)validator; 



//--------------------------------------------------------
#pragma mark - Validate Stack, Context, Model
//--------------------------------------------------------
/**
 *  Validates a CDSCoreDataStack. Checks for nullability of the stack instance as well as the managedObjectContext and managedObjectModel.
 *
 *  @param stack  The CDSCoreDataStack to validate.
 *  @param error  If an error occurs, upon return contains an NSError object that describes the problem. Could be a CDSErrorCodeCDSCoreDataStackIsNull, CDSErrorCodeManagedObjectContextIsNull or a CDSErrorCodeManagedObjectModelIsNull error.
 *
 *  @return YES if the stack and it's components are valid, NO if not.
 *
 *  @since 0.1.0
 */
-(BOOL)validateStack:(nullable CDSCoreDataStack*)stack
           withError:(NSError*_Nullable*)error;


/**
 *  Validates a NSManagedObjectContext
 *
 *  @param context The context to validate
 *  @param error  If an error occurs, upon return contains an NSError object that describes the problem. Will be a CDSErrorCodeManagedObjectContextIsNull error.
 *
 *  @return YES if the context is valid, NO if not.
 *
 *  @since 0.1.0
 */
-(BOOL)validateContext:(nullable NSManagedObjectContext*)context
             withError:(NSError*_Nullable*)error;


/**
 *  Validates a NSManagedObjectModel
 *
 *  @param model The model to validate.
 *  @param error  If an error occurs, upon return contains an NSError object that describes the problem. Will be a CDSErrorCodeManagedObjectModelIsNull error.
 *
 *  @return YES if the model is valid, NO if not.
 *
 *  @since 0.1.0
 */
-(BOOL)validateModel:(nullable NSManagedObjectModel*)model
           withError:(NSError*_Nullable*)error;



//--------------------------------------------------------
#pragma mark - Validate Objects
//--------------------------------------------------------

/**
 *  Validates an NSString
 *
 *  @param string The NSString to validate
 *  @param error  If an error occurs, upon return contains an NSError object that describes the problem. Could be either a CDSErrorCodeStringIsNull or CDSErrorCodeStringLengthIsZero error.
 *
 *  @return YES if the string is valid, NO if not.
 *
 *  @since 0.1.0
 */
-(BOOL)validateString:(nullable NSString*)string
            withError:(NSError*_Nullable*)error;

/**
 *  Validates an NSNumber
 *
 *  @param number The NSNumber to validate
 *  @param error  If an error occurs, upon return contains an NSError object that describes the problem. Will be a CDSErrorCodeNumberIsNull error.
 *
 *  @return YES if the number is valid, NO if not.
 *
 *  @since 0.1.0
 */
-(BOOL)validateNumber:(nullable NSNumber*)number
            withError:(NSError*_Nullable*)error;

/**
 *  Validates an NSDate
 *
 *  @param date The NSDate to validate
 *  @param error  If an error occurs, upon return contains an NSError object that describes the problem. Will be a CDSErrorCodeDateIsNull error.
 *
 *  @return YES if the date is valid, NO if not.
 *
 *  @since 0.1.0
 */
-(BOOL)validateDate:(nullable NSDate*)date
          withError:(NSError*_Nullable*)error;

/**
 *  Validates an object. Is the object of the correct type for the specified attribute for the specified entity.
 *
 *  @param object        The object to validate.
 *  @param attributeName The name of the attribute that the object should be of matching class.
 *  @param entityName    The name of the entity.
 *  @param context       The NSManagedObjectContext that the entity is stored with.
 *  @param error         If an error occurs, upon return contains an NSError object that describes the problem.
 *
 *  @return YES if the object is valid with that attribute and entity, NO if not.
 *
 *  @since 0.1.0
 */
-(BOOL)validateObject:(nullable id)object
isCorrectForAttributeNamed:(nullable NSString*)attributeName
        forEntityName:(nullable NSString*)entityName
            inContext:(nullable NSManagedObjectContext*)context
            withError:(NSError*_Nullable*)error;


//--------------------------------------------------------
#pragma mark - Validate Entity
//--------------------------------------------------------
/**
 *  Validates an entity name in a NSManagedObjectContext.
 *
 *  @param entityName The name of the entity to check.
 *  @param context    The NSManagedObjectContext
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem.
 *
 *  @return YES if there is an entity with the given name in the context.
 *
 *  @since 0.1.0
 */
-(BOOL)validateEntityName:(nullable NSString*)entityName
                inContext:(nullable NSManagedObjectContext*)context
                withError:(NSError*_Nullable*)error;

/**
 *  Validates an entity name in a NSManagedObjectModel.
 *
 *  @param entityName The name of the entity to check.
 *  @param context    The NSManagedObjectModel
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem.
 *
 *  @return YES if there is an entity with the given name in the model.
 *
 *  @since 0.1.0
 */
-(BOOL)validateEntityName:(nullable NSString*)entityName
                  inModel:(nullable NSManagedObjectModel*)model
                withError:(NSError*_Nullable*)error;

//--------------------------------------------------------
#pragma mark - Validate KeyPaths (Attributes & Relationships)
//--------------------------------------------------------

/**
 *  Validates a key path for an entity in a context. Does the specified entity have an attribute at the key path.
 *
 *  @param keyPath    The key path to check if it exists.
 *  @param entityName The name of the entity.
 *  @param context    The NSManagedObjectContext
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem.
 *
 *  @return YES if there is an entity with a valid attribute at the key path.
 *
 *  @since 0.1.0
 */
-(BOOL)validateKeyPath:(nullable NSString*)keyPath
         forEntityName:(nullable NSString*)entityName
             inContext:(nullable NSManagedObjectContext*)context
             withError:(NSError*_Nullable*)error;


//--------------------------------------------------------
#pragma mark - Validate Collections
//--------------------------------------------------------
/**
 *  Validates an array of Objects to see if they fit with the given keypaths for the specified entity.
 *
 *  @param objects    An array of objects, can be NSString, NSNumber, NSDate.
 *  @param keyPaths   An array of key paths.
 *  @param entityName The name of the entity.
 *  @param context    The NSManagedObjectContext
 *  @param error      If an error occurs, upon return contains an NSError object that describes the problem.
 *
 *  @return YES if the objects are valid and match with the keypaths for the specified \\\\\\/entity.
 *
 *  @since 0.1.0
 */
-(BOOL)validateObjects:(nullable NSArray*)objects
           forKeyPaths:(nullable NSArray*)keyPaths
         forEntityName:(nullable NSString*)entityName
             inContext:(nullable NSManagedObjectContext*)context
             withError:(NSError*_Nullable*)error;


@end
NS_ASSUME_NONNULL_END
