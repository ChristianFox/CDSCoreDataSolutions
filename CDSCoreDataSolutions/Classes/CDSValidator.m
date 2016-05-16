//
//  CDSValidator.m
//  Pods
//
//  Created by Eyeye on 08/05/2016.
//
//

#import "CDSValidator.h"
#import "CDSErrors.h"

@implementation CDSValidator


+(instancetype)validator{
    return [[self alloc]init];
}




// Validate Stack
-(BOOL)validateStack:(nullable CDSCoreDataStack*)stack
           withError:(NSError*_Nullable*)error{
    
    if (stack == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeCDSCoreDataStackIsNull
                                       withObject:nil];
        }
        return NO;
    }
    return YES;
}





-(BOOL)validateContext:(NSManagedObjectContext *)context
             withError:(NSError *__autoreleasing *)error{
    if (context == nil) {
        if (error != nil) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeManagedObjectContextIsNull
                                       withObject:nil];
        }
        return NO;
    }
    return YES;
}

-(BOOL)validateModel:(NSManagedObjectModel *)model
           withError:(NSError *__autoreleasing *)error{
    if (model == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeManagedObjectModelIsNull
                                       withObject:nil];
        }
        return NO;
    }
    return YES;
}

-(BOOL)validateString:(NSString *)string
            withError:(NSError *__autoreleasing *)error{
    if (string == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeStringIsNull
                                       withObject:nil];
        }
        return NO;
    }else if (string.length == 0){
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeStringLengthIsZero
                                       withObject:nil];
        }
        return NO;
    }
    
    return YES;
}

-(BOOL)validateNumber:(NSNumber *)number
            withError:(NSError *__autoreleasing *)error{
    
    if (number == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeNumberIsNull
                                       withObject:nil];
        }
        return NO;
    }
    
    return YES;
}

-(BOOL)validateDate:(NSDate*)date
          withError:(NSError*__autoreleasing*)error{
    
    if (date == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeDateIsNull
                                       withObject:nil];
        }
        return NO;
    }
    return YES;
    
}

-(BOOL)validateObject:(id)object
isCorrectForAttributeNamed:(NSString *)attributeName
        forEntityName:(NSString *)entityName
            inContext:(NSManagedObjectContext *)context
            withError:(NSError **)error{
    
    if (![self validateKeyPath:attributeName forEntityName:entityName inContext:context withError:error]) {
        return NO;
    }else if (object == nil){
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeObjectIsNull
                                       withObject:nil];
        }
        return NO;
    }
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName
                                                  inManagedObjectContext:context];
    NSDictionary *attributes = [entityDesc attributesByName];
    NSAttributeDescription *attDesc = attributes[attributeName];
    
    NSString *objClassName = NSStringFromClass([object superclass]);
    NSString *attClassName = attDesc.attributeValueClassName;
    NSLog(@"attClassName %@",attClassName);
    if ([attClassName isEqualToString:objClassName]) {
        return YES;
    }
    return NO;
    
    
}



-(BOOL)validateEntityName:(NSString *)entityName
                inContext:(NSManagedObjectContext *)context
                withError:(NSError *__autoreleasing *)error{
    if (![self validateContext:context withError:error]) {
        return NO;
    }
    
    if (entityName == nil ) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeEntityNameStringIsNull
                                       withObject:nil];
        }
        return NO;
    }else if (entityName.length == 0){
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeEntityNameStringLengthIsZero
                                       withObject:nil];
        }
        return NO;
    }else if (![NSEntityDescription entityForName:entityName inManagedObjectContext:context]){
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeContextDoesNotRecogniseEntityName
                                       withObject:entityName];
        }
        return NO;
    }
    
    return YES;
}

-(BOOL)validateEntityName:(NSString *)entityName
                  inModel:(NSManagedObjectModel *)model
                withError:(NSError *__autoreleasing *)error{
    
    if (entityName == nil ) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeEntityNameStringIsNull
                                       withObject:nil];
        }
        return NO;
    }else if (entityName.length == 0){
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeEntityNameStringLengthIsZero
                                       withObject:nil];
        }
        return NO;
    }
    
    NSDictionary *allEntityDescriptions = [model entitiesByName];
    if ([allEntityDescriptions valueForKey:entityName] == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeModelDoesNotRecogniseEntityName
                                       withObject:entityName];
        }
        return NO;
    }
    return YES;
    
    
}

-(BOOL)validateKeyPath:(NSString *)keyPath
         forEntityName:(NSString *)entityName
             inContext:(NSManagedObjectContext *)context
             withError:(NSError *__autoreleasing *)error{
    
    if (![self validateContext:context withError:error]) {
        return NO;
    }else if (![self validateEntityName:entityName inContext:context withError:error]){
        return NO;
    }
    
    if (keyPath == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeKeyPathIsNull
                                       withObject:nil];
        }
        return NO;
    }else if (keyPath.length == 0){
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeKeyPathStringLengthIsZero
                                       withObject:nil];
        }
        return NO;
    }
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    if (![[entityDesc propertiesByName]objectForKey:keyPath]) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeEntityDoesNotRecogniseKeyPath
                                       withObject:@[entityName,keyPath]];
        }
        return NO;
    }
    return YES;
}


-(BOOL)validateStrings:(NSArray *)strings
           forKeyPaths:(NSArray *)keyPaths
         forEntityName:(NSString *)entityName
             inContext:(NSManagedObjectContext *)context
             withError:(NSError *__autoreleasing *)error{
    
    if (strings == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayIsNull
                                       withObject:@"'strings'"];
        }
        return NO;
    }else if (strings.count == 0){
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayIsEmpty
                                       withObject:@"'strings'"];
        }
        return NO;
    }else if (keyPaths == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayIsNull
                                       withObject:@"'keyPaths'"];
        }
        return NO;
    }else if (keyPaths.count == 0){
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayIsEmpty
                                       withObject:@"'keyPaths'"];
        }
        return NO;
        
    }else if (strings.count != keyPaths.count) {
        if (error) {
            
            NSString *message = [NSString stringWithFormat:@"KeyPaths == %lu and Strings == %lu",(unsigned long)keyPaths.count, (unsigned long)strings.count];
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayCountsAreNotEqual
                                       withObject:message];
        }
        return NO;
    }
    
    // validation
    BOOL validationSuccess = NO;
    for (int idx = 0; idx < strings.count; idx++) {
        // strings
        BOOL isStringValid = NO;
        isStringValid = [self validateString:strings[idx]
                                   withError:error];
        if (!isStringValid) {
            validationSuccess = NO;
            break;
        }
        
        // keypaths
        BOOL isKeyPathValid = NO;
        isKeyPathValid = [self validateKeyPath:keyPaths[idx]
                                 forEntityName:entityName
                                     inContext:context
                                     withError:error];
        if (!isKeyPathValid) {
            validationSuccess = NO;
            break;
        }
        
        // both
        if (isStringValid && isKeyPathValid) {
            validationSuccess = YES;
        }
        
    }
    return validationSuccess;
}

-(BOOL)validateNumbers:(NSArray *)numbers
           forKeyPaths:(NSArray *)keyPaths
         forEntityName:(NSString *)entityName
             inContext:(NSManagedObjectContext *)context
             withError:(NSError *__autoreleasing *)error{
    // defensive
    if (numbers == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayIsNull
                                       withObject:@"'numbers'"];
        }
        return NO;
    }else if (numbers.count == 0){
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayIsEmpty
                                       withObject:@"'numbers'"];
        }
        return NO;
    }else if (keyPaths == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayIsNull
                                       withObject:@"'keyPaths'"];
        }
        return NO;
    }else if (keyPaths.count == 0){
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayIsEmpty
                                       withObject:@"'keyPaths'"];
        }
        return NO;
        
    }else if (numbers.count != keyPaths.count) {
        if (error) {
            NSString *message = [NSString stringWithFormat:@"keyPaths == %lu and numbers == %lu",(unsigned long)keyPaths.count, (unsigned long)numbers.count];
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayCountsAreNotEqual
                                       withObject:message];
        }
        return NO;
    }
    
    // validation
    BOOL validationSuccess = NO;
    for (int idx = 0; idx < numbers.count; idx++) {
        // strings
        BOOL isNumberValid = NO;
        isNumberValid = [self validateNumber:numbers[idx]
                                   withError:error];
        if (!isNumberValid) {
            validationSuccess = NO;
            break;
        }
        
        // keypaths
        BOOL isKeyPathValid = NO;
        isKeyPathValid = [self validateKeyPath:keyPaths[idx]
                                 forEntityName:entityName
                                     inContext:context
                                     withError:error];
        if (!isKeyPathValid) {
            validationSuccess = NO;
            break;
        }
        
        // both
        if (isNumberValid && isKeyPathValid) {
            validationSuccess = YES;
        }
    }
    return validationSuccess;
    
}


-(BOOL)validateObjects:(NSArray *)objects forKeyPaths:(NSArray *)keyPaths forEntityName:(NSString *)entityName inContext:(NSManagedObjectContext *)context withError:(NSError *__autoreleasing *)error{
    // defensive
    if (objects == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayIsNull
                                       withObject:@"'objects'"];
        }
        return NO;
    }else if (objects.count == 0){
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayIsEmpty
                                       withObject:@"'objects'"];
        }
        return NO;
    }else if (keyPaths == nil) {
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayIsNull
                                       withObject:@"'keyPaths'"];
        }
        return NO;
    }else if (keyPaths.count == 0){
        if (error) {
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayIsEmpty
                                       withObject:@"'keyPaths'"];
        }
        return NO;
        
    }else if (objects.count != keyPaths.count) {
        if (error) {
            NSString *message = [NSString stringWithFormat:@"keyPaths == %lu and objects == %lu",(unsigned long)keyPaths.count, (unsigned long)objects.count];
            *error = [CDSErrors errorForErrorCode:CDSErrorCodeArrayCountsAreNotEqual
                                       withObject:message];
        }
        return NO;
    }
    
    // validation
    BOOL validationSuccess = NO;
    for (int idx = 0; idx < objects.count; idx++) {
        // strings
        BOOL isObjectValid = NO;
        id obj = objects[idx];
        if ([obj isKindOfClass:[NSString class]]) {
            isObjectValid = [self validateString:obj
                                       withError:error];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            isObjectValid = [self validateNumber:obj
                                       withError:error];
        }else if ([obj isKindOfClass:[NSDate class]]){
            isObjectValid = [self validateDate:obj
                                     withError:error];
        }else{
            if (error) {
                *error = [CDSErrors errorForErrorCode:CDSErrorCodeClassTypeIsNotSupported
                                           withObject:NSStringFromClass([obj class])];
                return NO;
            }
        }
        
        if (!isObjectValid) {
            validationSuccess = NO;
            break;
        }
        
        // keypaths
        BOOL isKeyPathValid = NO;
        isKeyPathValid = [self validateKeyPath:keyPaths[idx]
                                 forEntityName:entityName
                                     inContext:context
                                     withError:error];
        if (!isKeyPathValid) {
            validationSuccess = NO;
            break;
        }
        
        // both
        if (isObjectValid && isKeyPathValid) {
            validationSuccess = YES;
        }
    }
    return validationSuccess;
    
}





@end
