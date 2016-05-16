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

+(instancetype)fetcher;
+(instancetype)fetcherWithValidation:(BOOL)validate;

//--------------------------------------------------------
#pragma mark - Fetch all
//--------------------------------------------------------
-(nullable NSArray<NSManagedObject*>*)fetchAllWithEntityName:(NSString*)entityName
                                                     context:(NSManagedObjectContext*)context
                                                       error:(NSError*_Nullable*)error;
-(nullable NSArray<NSManagedObject*>*)fetchAllWithEntityName:(NSString*)entityName
                                                   batchSize:(NSUInteger)batchSize
                                                  fetchLimit:(NSUInteger)fetchLimit
                                                     context:(NSManagedObjectContext*)context
                                                       error:(NSError*_Nullable*)error;

//--------------------------------------------------------
#pragma mark - Fetch with Fetch Request
//--------------------------------------------------------
-(nullable NSArray<NSManagedObject*>*)fetchWithFetchRequest:(NSFetchRequest*)fetchRequest
                                                    context:(NSManagedObjectContext*)context
                                                      error:(NSError*_Nullable*)error;



//--------------------------------------------------------
#pragma mark - Fetch with predicate
//--------------------------------------------------------
-(nullable NSArray<NSManagedObject*>*)fetchFilteredWithPredicate:(NSPredicate*)predicate
                                                      entityName:(NSString*)entityName
                                                         context:(NSManagedObjectContext*)context
                                                           error:(NSError*_Nullable*)error;
-(nullable NSArray<NSManagedObject*>*)fetchFilteredWithPredicate:(NSPredicate*)predicate
                                                       batchSize:(NSUInteger)batchSize
                                                      fetchLimit:(NSUInteger)fetchLimit
                                                      entityName:(NSString*)entityName
                                                         context:(NSManagedObjectContext*)context
                                                           error:(NSError*_Nullable*)error;

//--------------------------------------------------------
#pragma mark - Fetch Containing string
//--------------------------------------------------------
-(nullable NSArray<NSManagedObject*>*)fetchFilteredByContainingString:(NSString*)string
                                                            atKeyPath:(NSString*)keyPath
                                                           entityName:(NSString*)entityName
                                                              context:(NSManagedObjectContext*)context
                                                                error:(NSError**)error;
-(nullable NSArray<NSManagedObject*>*)fetchFilteredByContainingString:(NSString*)string
                                                            atKeyPath:(NSString*)keyPath
                                                            batchSize:(NSUInteger)batchSize
                                                           fetchLimit:(NSUInteger)fetchLimit
                                                           entityName:(NSString*)entityName
                                                              context:(NSManagedObjectContext*)context
                                                                error:(NSError**)error;


//--------------------------------------------------------
#pragma mark - Fetch matching multiple objects
//--------------------------------------------------------
-(nullable NSArray<NSManagedObject*>*)fetchMatchingAllObjects:(NSArray<id>*)objects
                                                  atKeyPaths:(NSArray<NSString*>*)keyPaths
                                                  entityName:(NSString*)entityName
                                                     context:(NSManagedObjectContext*)context
                                                       error:(NSError**)error;
-(nullable NSArray<NSManagedObject*>*)fetchMatchingAllObjects:(NSArray<id>*)objects
                                                  atKeyPaths:(NSArray<NSString*>*)keyPaths
                                                   batchSize:(NSUInteger)batchSize
                                                  fetchLimit:(NSUInteger)fetchLimit
                                                  entityName:(NSString*)entityName
                                                     context:(NSManagedObjectContext*)context
                                                       error:(NSError**)error;
-(nullable NSArray<NSManagedObject*>*)fetchMatchingAnyObjects:(NSArray<id>*)objects
                                                   atKeyPaths:(NSArray<NSString*>*)keyPaths
                                                   entityName:(NSString*)entityName
                                                      context:(NSManagedObjectContext*)context
                                                        error:(NSError**)error;
-(nullable NSArray<NSManagedObject*>*)fetchMatchingAnyObjects:(NSArray<id>*)objects
                                                   atKeyPaths:(NSArray<NSString*>*)keyPaths
                                                    batchSize:(NSUInteger)batchSize
                                                   fetchLimit:(NSUInteger)fetchLimit
                                                   entityName:(NSString*)entityName
                                                      context:(NSManagedObjectContext*)context
                                                        error:(NSError**)error;






@end
NS_ASSUME_NONNULL_END