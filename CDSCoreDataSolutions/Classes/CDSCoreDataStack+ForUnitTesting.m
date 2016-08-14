//
//  CDSCoreDataStack+ForUnitTesting.m
//  Pods
//
//  Created by Eyeye on 14/08/2016.
//
//

#import "CDSCoreDataStack+ForUnitTesting.h"
#import "CDSCoreDataStack_PrivateExtension.h"

@implementation CDSCoreDataStack (ForUnitTesting)

-(void)clearContextWithCompletion:(CDSBooleanCompletionHandler)handlerOrNil{
    
    if (self.publicContext == nil) {
        
        NSError *error = [CDSErrors errorForErrorCode:CDSErrorCodeManagedObjectContextIsNull
                                           withObject:nil];
        if (handlerOrNil != nil) {
            handlerOrNil(NO,error);
        }
    }else{
        
        // set to nil to clear and then build new
        self.publicContext = nil;
        self.publicContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        self.publicContext.parentContext = self.privateContext;
        
        if (handlerOrNil != nil) {
            handlerOrNil(YES,nil);
        }
    }
}

@end
