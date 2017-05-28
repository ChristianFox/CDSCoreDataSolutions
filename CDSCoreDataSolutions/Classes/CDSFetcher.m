/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with CDSCoreDataSolutions
 *
 ************************************/

#import "CDSFetcher.h"
@import CoreData;
#import "CDSValidator.h"

@interface CDSFetcher ()

@property (strong,nonatomic) CDSValidator *validator;
@end


@implementation CDSFetcher



//======================================================
#pragma mark - ** Public Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Initilisers
//--------------------------------------------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.validate = NO;
    }
    return self;
}


- (instancetype)initWithValidation:(BOOL)validate{
    self = [self init];
    if (self) {
        self.validate = validate;
        if (self.validate) {
            self.validator = [CDSValidator validator];
        }
    }
    return self;
}


+(instancetype)fetcher{
    
    BOOL validate = NO;
#if DEBUG
    validate = YES;
#else
    validate = NO;
#endif
    CDSFetcher *fetcher = [self fetcherWithValidation:validate];
    return fetcher;
}


+(instancetype)fetcherWithValidation:(BOOL)validate{
    CDSFetcher *fetcher = [[self alloc]initWithValidation:validate];
    return fetcher;
}



//--------------------------------------------------------
#pragma mark - Accessors
//--------------------------------------------------------
-(void)setValidate:(BOOL)validate{
    _validate = validate;
    if (_validate) {
        self.validator = [CDSValidator validator];
    }else{
        self.validator = nil;
    }
}

//--------------------------------------------------------
#pragma mark - Fetch all
//--------------------------------------------------------
-(NSArray*)fetchAllWithEntityName:(NSString*)entityName
                          context:(NSManagedObjectContext*)context
                            error:(NSError*_Nullable*)error{
    
    return [self fetchAllWithEntityName:entityName
                              batchSize:0
                             fetchLimit:0
                                context:context
                                  error:error];
}

-(NSArray*)fetchAllWithEntityName:(NSString*)entityName
                        batchSize:(NSUInteger)batchSize
                       fetchLimit:(NSUInteger)fetchLimit
                          context:(NSManagedObjectContext*)context
                            error:(NSError*_Nullable*)error{

    if (self.shouldValidate) {
        if (![self.validator validateContext:context withError:error]) {
            return nil;
        }else if (![self.validator validateEntityName:entityName inContext:context withError:error]) {
            return nil;
        }
    }
    
    
    NSArray *matching =  [self internal_fetchAllWithEntityName:entityName
                                                     batchSize:batchSize
                                                    fetchLimit:fetchLimit
                                                       context:context
                                                         error:error];
    return matching;

}

//--------------------------------------------------------
#pragma mark - Fetch with Fetch Request
//--------------------------------------------------------
-(NSArray*)fetchWithFetchRequest:(NSFetchRequest*)fetchRequest
                         context:(NSManagedObjectContext*)context
                           error:(NSError*_Nullable*)error{

    if (self.shouldValidate) {
        if (![self.validator validateContext:context withError:error]) {
            return nil;
        }
    }
    
    NSArray *matchingObjects = [context executeFetchRequest:fetchRequest error:error];
    return matchingObjects;
}



//--------------------------------------------------------
#pragma mark - Fetch with predicate
//--------------------------------------------------------
-(NSArray*)fetchFilteredWithPredicate:(NSPredicate*)predicate
                           entityName:(NSString*)entityName
                              context:(NSManagedObjectContext*)context
                                error:(NSError*_Nullable*)error{
    
    return [self fetchFilteredWithPredicate:predicate
                                  batchSize:0
                                 fetchLimit:0
                                 entityName:entityName
                                    context:context
                                      error:error];

}

-(NSArray*)fetchFilteredWithPredicate:(NSPredicate*)predicate
                            batchSize:(NSUInteger)batchSize
                           fetchLimit:(NSUInteger)fetchLimit
                           entityName:(NSString*)entityName
                              context:(NSManagedObjectContext*)context
                                error:(NSError*_Nullable*)error{

    if (self.shouldValidate) {
        if (![self.validator validateContext:context withError:error]) {
            return nil;
        }else if (![self.validator validateEntityName:entityName inContext:context withError:error]) {
            return nil;
        }
    }
    
    NSArray *matching = [self internal_fetchWithPredicate:predicate
                                  entityName:entityName
                                   batchSize:batchSize
                                  fetchLimit:fetchLimit
                                     context:context
                                       error:error];
    return matching;

}

//--------------------------------------------------------
#pragma mark - Fetch Containing string
//--------------------------------------------------------
-(NSArray*)fetchFilteredByContainingString:(NSString*)string
                                 atKeyPath:(NSString*)keyPath
                                entityName:(NSString*)entityName
                                   context:(NSManagedObjectContext*)context
                                     error:(NSError**)error{
    
    return [self fetchFilteredByContainingString:string
                                       atKeyPath:keyPath
                                       batchSize:0
                                      fetchLimit:0
                                      entityName:entityName
                                         context:context
                                           error:error];

}

-(NSArray*)fetchFilteredByContainingString:(NSString*)string
                                 atKeyPath:(NSString*)keyPath
                                 batchSize:(NSUInteger)batchSize
                                fetchLimit:(NSUInteger)fetchLimit
                                entityName:(NSString*)entityName
                                   context:(NSManagedObjectContext*)context
                                     error:(NSError**)error{

    if (self.shouldValidate) {
        if (![self.validator validateContext:context withError:error]) {
            return nil;
        }else if (![self.validator validateEntityName:entityName inContext:context withError:error]) {
            return nil;
        }else if (![self.validator validateString:string withError:error]){
            return nil;
        }else if (![self.validator validateKeyPath:keyPath forEntityName:entityName inContext:context withError:error]){
            return nil;
        }
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@",keyPath, string];
    NSArray *matching = [self internal_fetchWithPredicate:predicate
                                               entityName:entityName
                                                batchSize:batchSize
                                               fetchLimit:fetchLimit
                                                  context:context
                                                    error:error];
    return matching;
}


//--------------------------------------------------------
#pragma mark - Fetch matching multiple objects
//--------------------------------------------------------
-(NSArray*)fetchMatchingAllObjects:(NSArray<id>*)objects
                        atKeyPaths:(NSArray<NSString*>*)keyPaths
                        entityName:(NSString*)entityName
                           context:(NSManagedObjectContext*)context
                             error:(NSError**)error{
    
    return [self fetchMatchingAllObjects:objects
                              atKeyPaths:keyPaths
                               batchSize:0
                              fetchLimit:0
                              entityName:entityName
                                 context:context
                                   error:error];
}

-(NSArray*)fetchMatchingAllObjects:(NSArray<id>*)objects
                        atKeyPaths:(NSArray<NSString*>*)keyPaths
                         batchSize:(NSUInteger)batchSize
                        fetchLimit:(NSUInteger)fetchLimit
                        entityName:(NSString*)entityName
                           context:(NSManagedObjectContext*)context
                             error:(NSError**)error{
    
    if (self.shouldValidate) {
        if (![self.validator validateContext:context withError:error]) {
            return nil;
        }else if (![self.validator validateEntityName:entityName inContext:context withError:error]) {
            return nil;
        }else if (![self.validator validateObjects:objects
                                       forKeyPaths:keyPaths
                                     forEntityName:entityName
                                         inContext:context
                                         withError:error]){
            return nil;
        }
    }
    
    NSPredicate *predicate = [self compoundAndPredicateWithObjects:objects andKeyPaths:keyPaths];
    
    NSArray *matching = [self internal_fetchWithPredicate:predicate
                                               entityName:entityName
                                                batchSize:batchSize
                                               fetchLimit:fetchLimit
                                                  context:context
                                                    error:error];
    return matching;

}

-(nullable NSArray<NSManagedObject*>*)fetchMatchingAnyObjects:(NSArray<id>*)objects
                                                   atKeyPaths:(NSArray<NSString*>*)keyPaths
                                                   entityName:(NSString*)entityName
                                                      context:(NSManagedObjectContext*)context
                                                        error:(NSError**)error{
    
    return [self fetchMatchingAnyObjects:objects
                              atKeyPaths:keyPaths
                               batchSize:0
                              fetchLimit:0
                              entityName:entityName
                                 context:context
                                   error:error];
}

-(nullable NSArray<NSManagedObject*>*)fetchMatchingAnyObjects:(NSArray<id>*)objects
                                                   atKeyPaths:(NSArray<NSString*>*)keyPaths
                                                    batchSize:(NSUInteger)batchSize
                                                   fetchLimit:(NSUInteger)fetchLimit
                                                   entityName:(NSString*)entityName
                                                      context:(NSManagedObjectContext*)context
                                                        error:(NSError**)error{
    
    if (self.shouldValidate) {
        if (![self.validator validateContext:context withError:error]) {
            return nil;
        }else if (![self.validator validateEntityName:entityName inContext:context withError:error]) {
            return nil;
        }else if (![self.validator validateObjects:objects
                                       forKeyPaths:keyPaths
                                     forEntityName:entityName
                                         inContext:context
                                         withError:error]){
            return nil;
        }
    }

    NSPredicate *predicate = [self compoundOrPredicateWithObjects:objects andKeyPaths:keyPaths];
    NSArray *matching = [self internal_fetchWithPredicate:predicate
                                               entityName:entityName
                                                batchSize:batchSize
                                               fetchLimit:fetchLimit
                                                  context:context
                                                    error:error];
    return matching;

}

//======================================================
#pragma mark - ** Private Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Predicate builders
//--------------------------------------------------------
-(NSCompoundPredicate*)compoundAndPredicateWithObjects:(NSArray*)objects andKeyPaths:(NSArray*)keyPaths{
    
    __block NSMutableArray *mutArray = [[NSMutableArray alloc]initWithCapacity:keyPaths.count];
    
    [keyPaths enumerateObjectsUsingBlock:^(NSString *keyPath, NSUInteger idx, BOOL *stop) {
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@",keyPath,objects[idx]];
        [mutArray addObject:pred];
    }];
    NSCompoundPredicate *compoundPred = [NSCompoundPredicate andPredicateWithSubpredicates:[mutArray copy]];
    
    return compoundPred;
}

-(NSCompoundPredicate*)compoundOrPredicateWithObjects:(NSArray*)objects andKeyPaths:(NSArray*)keyPaths{
    
    __block NSMutableArray *mutArray = [[NSMutableArray alloc]initWithCapacity:keyPaths.count];
    
    [keyPaths enumerateObjectsUsingBlock:^(NSString *keyPath, NSUInteger idx, BOOL *stop) {
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@",keyPath,objects[idx]];
        [mutArray addObject:pred];
    }];
    NSCompoundPredicate *compoundPred = [NSCompoundPredicate orPredicateWithSubpredicates:[mutArray copy]];
    
    return compoundPred;
}


//--------------------------------------------------------
#pragma mark - Internal fetchers
//--------------------------------------------------------
-(NSArray*)internal_fetchAllWithEntityName:(NSString*)entityName
                                 batchSize:(NSUInteger)batchSize
                                fetchLimit:(NSUInteger)fetchLimit
                                   context:(NSManagedObjectContext*)context
                                     error:(NSError*_Nullable*)error{
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName
                                                  inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    [request setFetchBatchSize:batchSize];
    [request setFetchLimit:fetchLimit];
    NSArray *matchingObjects = [context executeFetchRequest:request error:error];
    return matchingObjects;
}

-(NSArray*)internal_fetchWithPredicate:(NSPredicate*)predicate
                            entityName:(NSString*)entityName
                             batchSize:(NSUInteger)batchSize
                            fetchLimit:(NSUInteger)fetchLimit
                               context:(NSManagedObjectContext*)context
                                 error:(NSError*_Nullable*)error{
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName
                                                  inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    [request setFetchBatchSize:batchSize];
    [request setFetchLimit:fetchLimit];
    [request setPredicate:predicate];
    NSArray *matchingObjects = [context executeFetchRequest:request error:error];
    return matchingObjects;
}


//--------------------------------------------------------
#pragma mark - Lazy Load
//--------------------------------------------------------







@end
