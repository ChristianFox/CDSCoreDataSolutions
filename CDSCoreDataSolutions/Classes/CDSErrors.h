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

#pragma mark Enum Defintions
typedef NS_ENUM(NSInteger, CDSErrorCode){
    
    CDSErrorCodeCDSCoreDataStackIsNull = 1030419000,
    CDSErrorCodeManagedObjectContextIsNull,
    CDSErrorCodeManagedObjectModelIsNull,
    CDSErrorCodeManagedObjectModelDoesNotContainEntities,
    CDSErrorCodePersistentStoreCoordinatorIsNull,
    CDSErrorCodePersistentStoreNotFoundAtURL,
    CDSErrorCodeFailedToInitiliseManagedObjectModel,
    CDSErrorCodeFailedToInitilisePersistentStoreCoordinator,
    CDSErrorCodeFailedToInitiliseMainQueueContext,
    CDSErrorCodeFailedToInitilisePersistenceContext,
    CDSErrorCodeFailedToInitiliseBackgroundContext,
    CDSErrorCodeStringIsNull,
    CDSErrorCodeStringLengthIsZero,
    CDSErrorCodeNumberIsNull,
    CDSErrorCodeDateIsNull,
    CDSErrorCodeObjectIsNull,
    CDSErrorCodeEntityNameStringIsNull,
    CDSErrorCodeEntityNameStringLengthIsZero,
    CDSErrorCodeContextDoesNotRecogniseEntityName,
    CDSErrorCodeModelDoesNotRecogniseEntityName,
    CDSErrorCodeKeyPathIsNull,
    CDSErrorCodeKeyPathStringLengthIsZero,
    CDSErrorCodeEntityDoesNotRecogniseKeyPath,
    CDSErrorCodeArrayIsNull,
    CDSErrorCodeArrayIsEmpty,
    CDSErrorCodeArrayIndexOutOfBounds,
    CDSErrorCodeDictionaryIsNull,
    CDSErrorCodeDictionaryIsEmpty,
    CDSErrorCodeDictionaryDoesNotRecogniseKey,
    CDSErrorCodeArrayCountsAreNotEqual,
    CDSErrorCodeClassTypeIsNotSupported
};

NS_ASSUME_NONNULL_BEGIN

//======================================================
#pragma mark - ** Constant Defintions **
//======================================================
extern NSString *const kCDSErrorDomain;





@interface CDSErrors : NSObject

//======================================================
#pragma mark - ** Methods **
//======================================================
/**
 *  Creates an NSError object for the given error code. This isn't or wasn't designed to be particularly user friendly, really it is for use by the other classes in this library and although it can be used by yourself be prepared to read the implementation sometimes.
 *
 *  @param errorCode A value from the CDSErrorCode enum
 *  @param object    An object relevent to the error. Yeah it is vague but if the error code is CDSErrorCodeArrayIndexOutOfBounds then send the array, if the error code is CDSErrorCodeDateIsNull then either send the NSDate or just pass nil. For many errors you can just pass nil, if you think an object is needed send it and hope or check the implementation.
 *
 *  @return An NSError configured with domain, error code and a localised description
 *
 *  @since 0.2.0
 */
+(NSError*)errorForErrorCode:(CDSErrorCode)errorCode withObject:(nullable id)object;

/**
 *  Creates a localised string with key, default value etc for the given error code and in some cases using a passed object. This isn't or wasn't designed to be particularly user friendly, really it is for use by the other classes in this library and although it can be used by yourself be prepared to read the implementation sometimes.
 *
 *  @param errorCode A value from the CDSErrorCode enum
 *  @param object    An object relevent to the error. Yeah it is vague but if the error code is CDSErrorCodeArrayIndexOutOfBounds then send the array, if the error code is CDSErrorCodeDateIsNull then either send the NSDate or just pass nil. For many errors you can just pass nil, if you think an object is needed send it and hope or check the implementation.
 *
 *  @return An NSError configured with domain, error code and a localised description
 *
 *  @since 0.2.0
 */
+(NSString*)localisedDescriptionForErrorCode:(CDSErrorCode)errorCode withObject:(nullable id)object;




@end
NS_ASSUME_NONNULL_END
