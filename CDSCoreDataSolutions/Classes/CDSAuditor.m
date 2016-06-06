//
//  CDSAuditor.m
//  Pods
//
//  Created by Eyeye on 08/05/2016.
//
//

#import "CDSAuditor.h"
#import "CDSValidator.h"
#import "CDSCoreDataStack.h"
#import "CDSErrors.h"

@interface CDSAuditor ()
@property (strong,nonatomic) CDSValidator *validator;
@end

@implementation CDSAuditor



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
        self.validator = [CDSValidator validator];
    }
    return self;
}

+(instancetype)auditor{
    return [[self alloc]init];
}


//--------------------------------------------------------
#pragma mark - Entity Audit
//--------------------------------------------------------
-(BOOL)existsEntityNamed:(NSString *)entityName inModel:(NSManagedObjectModel *)model
                   error:(NSError *__autoreleasing *)error{
    
    if (![self.validator validateModel:model withError:error]) {
        return NO;
    }else if (![self.validator validateEntityName:entityName inModel:model withError:error]) {
        return NO;
    }
    return YES;
}

-(BOOL)existsEntityNamed:(NSString *)entityName inContext:(NSManagedObjectContext *)context
                   error:(NSError *__autoreleasing *)error{
    
    if (![self.validator validateContext:context withError:error]) {
        return NO;
    }else if (![self.validator validateEntityName:entityName inContext:context withError:error]) {
        return NO;
    }
    return YES;

}

/* Entity with Attribute Key */
-(BOOL)existsAttributeNamed:(NSString*)attributeName
             forEntityNamed:(NSString*)entityName
                  inContext:(NSManagedObjectContext*)context
                      error:(NSError*__autoreleasing*)error{
    
    if (![self.validator validateContext:context withError:error]) {
        return NO;
    }else if (![self.validator validateEntityName:entityName inContext:context withError:error]) {
        return NO;
    }else if (![self.validator validateKeyPath:attributeName forEntityName:entityName inContext:context withError:error]){
        return NO;
    }
    return YES;
}

/* Entity with Relationship Key */
-(BOOL)existsRelationshipNamed:(NSString*)relationshipName
                forEntityNamed:(NSString*)entityName
                     inContext:(NSManagedObjectContext*)context
                         error:(NSError*__autoreleasing*)error{
    
    if (![self.validator validateContext:context withError:error]) {
        return NO;
    }else if (![self.validator validateEntityName:entityName inContext:context withError:error]) {
        return NO;
    }else if (![self.validator validateKeyPath:relationshipName forEntityName:entityName inContext:context withError:error]){
        return NO;
    }
    return YES;
}


//--------------------------------------------------------
#pragma mark - Context Contents Audit
//--------------------------------------------------------
-(BOOL)existsContentsForEntityNamed:(NSString*)entityName
                          inContext:(NSManagedObjectContext*)context
                              error:(NSError*__autoreleasing*)error{
    // defensive
    if (![self.validator validateContext:context withError:error]) {
        return NO;
    }else if (![self.validator validateEntityName:entityName inContext:context withError:error]) {
        return NO;
    }
    
    // fetch
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName
                                                  inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    [request setFetchLimit:1];
    if ([context countForFetchRequest:request error:error] == 0) {
        return NO;
    }
    return YES;
}


//--------------------------------------------------------
#pragma mark - Stack Contents Audit
//--------------------------------------------------------
-(BOOL)existsContentsInStack:(CDSCoreDataStack *)stack
                       error:(NSError *__autoreleasing *)error{
    // defensive
    if (![self.validator validateStack:stack withError:error]) {
        return NO;
    }
    
    // validate
    __block BOOL hasContents = NO;
    NSDictionary *entities = [stack.managedObjectModel entitiesByName];
    [entities enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        hasContents = [self existsContentsForEntityNamed:key
                                               inContext:stack.managedObjectContext
                                                   error:error];
        *stop = hasContents;
    }];
    
    return hasContents;
}





//--------------------------------------------------------
#pragma mark - Managed Object Count Audit
//--------------------------------------------------------
-(NSUInteger)countOfManagedObjectsForEntityName:(NSString*)entityName
                                      inContext:(NSManagedObjectContext*)context
                                          error:(NSError**)error{
    // defensive
    if (![self.validator validateContext:context withError:error]) {
        return NO;
    }else if (![self.validator validateEntityName:entityName inContext:context withError:error]) {
        return NO;
    }
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName
                                                  inManagedObjectContext:context];
    // fetch & count
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    NSUInteger count = [context countForFetchRequest:request error:error];
    return count;
    
}

-(NSUInteger)countOfManagedObjectsInStack:(CDSCoreDataStack *)stack error:(NSError *__autoreleasing *)error{
    
    // defensive
    if (![self.validator validateStack:stack withError:error]) {
        return NO;
    }
    
    // count
    __block NSUInteger count = 0;
    NSDictionary *entities = [stack.managedObjectModel entitiesByName];
    [entities enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        count += [self countOfManagedObjectsForEntityName:key
                                                inContext:stack.managedObjectContext
                                                    error:error];
    }];
    
    return count;
}


-(NSDictionary *)countsKeyedByNamesOfEntitiesInStack:(CDSCoreDataStack *)stack error:(NSError *__autoreleasing *)error{
    
    // defensive
    if (![self.validator validateStack:stack withError:error]) {
        return nil;
    }
    
    NSDictionary *entities = [stack.managedObjectModel entitiesByName];
    if (entities == nil || entities.count == 0) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeManagedObjectModelDoesNotContainEntities
                                       withObject:nil];
        }
        return nil;
    }
    
    // count & package into dict
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithCapacity:entities.count];
    for (NSString *key in entities) {
        NSUInteger aCount = [self countOfManagedObjectsForEntityName:key
                                                           inContext:stack.managedObjectContext
                                                               error:error];
        [mutDict setObject:@(aCount) forKey:key];
    }
    return [mutDict copy];
    
}









//======================================================
#pragma mark - ** Protocol Methods **
//======================================================




//======================================================
#pragma mark - ** Private Methods **
//======================================================
//--------------------------------------------------------
#pragma mark - Lazy Load
//--------------------------------------------------------




@end
