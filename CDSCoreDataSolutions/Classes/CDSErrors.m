//
//  CDSErrors.m
//  Pods
//
//  Created by Eyeye on 08/05/2016.
//
//

#import "CDSErrors.h"


//======================================================
#pragma mark - ** Constant Defintions **
//======================================================
NSString *const kCDSErrorDomain = @"com.KFXTech.CDSCoreDataSolutions";



@implementation CDSErrors


//======================================================
#pragma mark - ** Public Methods **
//======================================================
+(NSError*)errorForErrorCode:(CDSErrorCode)errorCode withObject:(nullable id)object{
    
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:[self localisedDescriptionForErrorCode:errorCode withObject:object]};
    NSError *error = [NSError errorWithDomain:kCDSErrorDomain
                                         code:errorCode
                                     userInfo:userInfo];
    return error;
}


+(NSString *)localisedDescriptionForErrorCode:(CDSErrorCode)errorCode withObject:(nullable id)object{
    
    NSString *localisedDescription;
    
    // TODO: Rewrite the localised strings to use the more detailed version and so they will always work.
    switch (errorCode) {
        case CDSErrorCodeCDSCoreDataStackIsNull:{
            localisedDescription = NSLocalizedString(@"<ERROR> DBSCoreDataStack is null.", @"The DBSCoreDataStack variable has no value, has not been initilised");
            break;
        }
        case CDSErrorCodeManagedObjectContextIsNull: {
            localisedDescription = NSLocalizedString(@"<ERROR> NSManagedObjectContext is null.", @"The NSManagedObjectContext variable has no value, has not been initilised");
            break;
        }
        case CDSErrorCodeManagedObjectModelIsNull: {
            localisedDescription = NSLocalizedString(@"<ERROR> NSManagedObjectModel is null.", @"The NSManagedObjectModel variable has no value, has not been initilised");
            break;
        }
        case CDSErrorCodeManagedObjectModelDoesNotContainEntities:{
            localisedDescription = NSLocalizedString(@"<ERROR> NSManagedObjectModel is empty. It does not have any entities set.", @"The NSManagedObjectModel is empty. It does not have any entities set, it has not been defined, it is incomplete.");
            break;
        }
        case CDSErrorCodePersistentStoreCoordinatorIsNull: {
            localisedDescription = NSLocalizedString(@"<ERROR> NSPersistentStoreCoordinator is null.", @"The NSManagedObjectContext variable has no value, has not been initilised");
            break;
        }
        case CDSErrorCodePersistentStoreNotFoundAtURL:{
            
            NSString *message = [NSString stringWithFormat:@"<ERROR> No persistent store file (database file) found at URL: %@",object];
            localisedDescription = NSLocalizedString(message, @"The URL was checked for the existence of a database file but it could not be found.");
            break;
        }
        case CDSErrorCodeFailedToInitiliseManagedObjectModel:{
            localisedDescription = NSLocalizedString(@"<ERROR> Failed to initilise a NSManagedObjectModel.", @"The NSManagedObjectModel could not be initilised (aka created)");
            break;
        }
        case CDSErrorCodeFailedToInitilisePersistentStoreCoordinator:{
            localisedDescription = NSLocalizedString(@"<ERROR> Failed to initilise a NSPersistentStoreCoordinator.", @"The NSPersistentStoreCoordinator could not be initilised (aka created)");
            break;
        }
        case CDSErrorCodeFailedToInitilisePrivateContext:{
            localisedDescription = NSLocalizedString(@"<ERROR> Failed to initilise a NSManagedObjectContext for private use.", @"The NSManagedObjectContext could not be initilised (aka created) for private use");
            break;
        }
        case CDSErrorCodeFailedToInitilisePublicContext:{
            localisedDescription = NSLocalizedString(@"<ERROR> Failed to initilise a NSManagedObjectContext for public use.", @"The NSManagedObjectContext could not be initilised (aka created) for public use");
            break;
        }
        case CDSErrorCodeStringIsNull: {
            localisedDescription = NSLocalizedString(@"<ERROR> The NSString is null.", @"The NSString object does not exist, is null, is nil");
            break;
        }
        case CDSErrorCodeStringLengthIsZero: {
            localisedDescription = NSLocalizedString(@"<ERROR> The NSString is empty.", @"The NSString object is empty, has zero length, has no characters");
            break;
        }
        case CDSErrorCodeNumberIsNull: {
            localisedDescription = NSLocalizedString(@"<ERROR> The NSNumber is null.", @"The NSNumber object does not exist, is null, is nil");
            break;
        }
        case CDSErrorCodeDateIsNull: {
            localisedDescription = NSLocalizedString(@"<ERROR> The NSDate is null.", @"The NSDate does not exist, is null, is nil");
            break;
        }
        case CDSErrorCodeObjectIsNull: {
            localisedDescription = NSLocalizedString(@"<ERROR> The unidentified object is null.", @"The object does not exist, is null, is nil");
            break;
        }
        case CDSErrorCodeEntityNameStringIsNull: {
            localisedDescription = NSLocalizedString(@"<ERROR> The Entity Name is null.", @"The NSString used for the entity's name does not exist, is null, is nil");
            break;
        }
        case CDSErrorCodeEntityNameStringLengthIsZero: {
            localisedDescription = NSLocalizedString(@"<ERROR> The Entity name is empty.", @"The Entity name object is empty, has zero length, has no characters");
            break;
        }
        case CDSErrorCodeContextDoesNotRecogniseEntityName: {
            NSString *message = [NSString stringWithFormat:@"<ERROR> The Entity Named %@ does not exist in the ManagedObjectContext",object];
            localisedDescription = NSLocalizedString(message, @"The NSManagedObjectContext object does not recognise the entity with that name");
            break;
        }
        case CDSErrorCodeModelDoesNotRecogniseEntityName: {
            NSString *message = [NSString stringWithFormat:@"<ERROR> The Entity Named %@ does not exist in the ManagedObjectModel",object];
            localisedDescription = NSLocalizedString(message, @"The ManagedObjectModel object does not recognise the entity with that name");
            break;
        }
        case CDSErrorCodeKeyPathIsNull: {
            localisedDescription = NSLocalizedString(@"<ERROR> The KeyPath string is null.", @"The NSString used for the KeyPath does not exist, is null, is nil");
            break;
        }
        case CDSErrorCodeKeyPathStringLengthIsZero: {
            localisedDescription = NSLocalizedString(@"<ERROR> The KeyPath string is null.", @"The NSString used for the KeyPath does not exist, is null, is nil");

            break;
        }
        case CDSErrorCodeEntityDoesNotRecogniseKeyPath: {
            NSArray *args = ([object isKindOfClass:[NSArray class]]) ? (NSArray*)object : nil;
            NSString *message = [NSString stringWithFormat:@"<ERROR> The Entity Named %@ does not recognise the keyPath %@  ",args.firstObject,args.lastObject];
            localisedDescription = NSLocalizedString(message, @"The NSManagedObject does not recognise the keypath, does not have those properties");
            break;
        }
        case CDSErrorCodeArrayIsNull: {
            NSString *message = [NSString stringWithFormat:@"<ERROR> The NSArray named %@ is null.",object];
            localisedDescription = NSLocalizedString(message, @"The NSArray is null, is nil");
            break;
        }
        case CDSErrorCodeArrayIsEmpty: {
            NSString *message = [NSString stringWithFormat:@"<ERROR> The NSArray named %@ is empty.",object];
            localisedDescription = NSLocalizedString(message, @"The NSArray is empty, contains no objects");
            break;
        }
        case CDSErrorCodeArrayIndexOutOfBounds: {
            NSArray *args = ([object isKindOfClass:[NSArray class]]) ? (NSArray*)object : nil;
            NSString *message = [NSString stringWithFormat:@"<ERROR> For NSArray named %@, index is out of bounds. %@ >= %@.",args.firstObject,args[1],args[2]];
            localisedDescription = NSLocalizedString(message, @"The NSArray's count is less or equal to the index used, the index is too high for the amount of objects this array contains");
            break;
        }
        case CDSErrorCodeDictionaryIsNull: {
            NSString *message = [NSString stringWithFormat:@"<ERROR> The NSDictionary named %@ is null.",object];
            localisedDescription = NSLocalizedString(message, @"The NSDictionary is null, is nil");
            break;
        }
        case CDSErrorCodeDictionaryIsEmpty: {
            NSString *message = [NSString stringWithFormat:@"<ERROR> The NSDictionary named %@ is empty.",object];
            localisedDescription = NSLocalizedString(message, @"The NSDictionary is empty, contains no objects");
            break;
        }
        case CDSErrorCodeDictionaryDoesNotRecogniseKey: {
            NSArray *args = ([object isKindOfClass:[NSArray class]]) ? (NSArray*)object : nil;
            NSString *message = [NSString stringWithFormat:@"<ERROR> For NSDictionary named %@, does not contain the key %@.",args.firstObject,args.lastObject];
            localisedDescription = NSLocalizedString(message, @"The NSDictionary does not recognise the specified key");
            break;
        }
        case CDSErrorCodeArrayCountsAreNotEqual: {
            NSString *message = [NSString stringWithFormat:@"<ERROR> The array counts are not equal but should be. %@.",object];
            localisedDescription = NSLocalizedString(message, @"The array counts are not equal but should be");
            break;
        }
        case CDSErrorCodeClassTypeIsNotSupported: {
            NSString *message = [NSString stringWithFormat:@"<ERROR> The class type is not supported. %@.",object];
            localisedDescription = NSLocalizedString(message, @"The class type is not supported");
            break;
        }
        default:{
            NSString *message = [NSString stringWithFormat:@"<ERROR> ? Unknown Error. Error decription was not found for the error code: %ld",(long)errorCode];
            localisedDescription = NSLocalizedString(message, @"Unable to describe this error because a description was not defined for this error code. - Error cause unknown.");
            break;
        }
    }
    
    return localisedDescription;
}




@end
