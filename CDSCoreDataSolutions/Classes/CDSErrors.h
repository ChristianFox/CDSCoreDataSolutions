//
//  CDSErrors.h
//  Pods
//
//  Created by Eyeye on 08/05/2016.
//
//

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
    CDSErrorCodeFailedToInitilisePrivateContext,
    CDSErrorCodeFailedToInitilisePublicContext,
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
+(NSError*)errorForErrorCode:(CDSErrorCode)errorCode withObject:(nullable id)object;

+(NSString*)localisedDescriptionForErrorCode:(CDSErrorCode)errorCode withObject:(nullable id)object;




@end
NS_ASSUME_NONNULL_END