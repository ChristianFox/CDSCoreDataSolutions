//
//  CDSValidator.h
//  Pods
//
//  Created by Eyeye on 08/05/2016.
//
//

#import <Foundation/Foundation.h>
@import CoreData;
@class CDSCoreDataStack;

NS_ASSUME_NONNULL_BEGIN
@interface CDSValidator : NSObject

+(instancetype)validator;

// Validate Stack
-(BOOL)validateStack:(nullable CDSCoreDataStack*)stack
           withError:(NSError*_Nullable*)error;

// validate stack members
-(BOOL)validateContext:(nullable NSManagedObjectContext*)context
             withError:(NSError*_Nullable*)error;
-(BOOL)validateModel:(nullable NSManagedObjectModel*)model
           withError:(NSError*_Nullable*)error;

// validate objects
-(BOOL)validateString:(nullable NSString*)string
            withError:(NSError*_Nullable*)error;
-(BOOL)validateNumber:(nullable NSNumber*)number
            withError:(NSError*_Nullable*)error;
-(BOOL)validateDate:(nullable NSDate*)date
          withError:(NSError*_Nullable*)error;
-(BOOL)validateObject:(nullable id)object
isCorrectForAttributeNamed:(nullable NSString*)attributeName
        forEntityName:(nullable NSString*)entityName
            inContext:(nullable NSManagedObjectContext*)context
            withError:(NSError*_Nullable*)error;

// validate entity
-(BOOL)validateEntityName:(nullable NSString*)entityName
                inContext:(nullable NSManagedObjectContext*)context
                withError:(NSError*_Nullable*)error;
-(BOOL)validateEntityName:(nullable NSString*)entityName
                  inModel:(nullable NSManagedObjectModel*)model
                withError:(NSError*_Nullable*)error;

// validate properties (attributes and relationships)
-(BOOL)validateKeyPath:(nullable NSString*)keyPath
         forEntityName:(nullable NSString*)entityName
             inContext:(nullable NSManagedObjectContext*)context
             withError:(NSError*_Nullable*)error;

// validate collections for compound predicates
-(BOOL)validateStrings:(nullable NSArray*)strings
           forKeyPaths:(nullable NSArray*)keyPaths
         forEntityName:(nullable NSString*)entityName
             inContext:(nullable NSManagedObjectContext*)context
             withError:(NSError*_Nullable*)error;
-(BOOL)validateNumbers:(nullable NSArray*)numbers
           forKeyPaths:(nullable NSArray*)keyPaths
         forEntityName:(nullable NSString*)entityName
             inContext:(nullable NSManagedObjectContext*)context
             withError:(NSError*_Nullable*)error;
-(BOOL)validateObjects:(nullable NSArray*)objects
           forKeyPaths:(nullable NSArray*)keyPaths
         forEntityName:(nullable NSString*)entityName
             inContext:(nullable NSManagedObjectContext*)context
             withError:(NSError*_Nullable*)error;


@end
NS_ASSUME_NONNULL_END