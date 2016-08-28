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

-(void)clearMainQueueContextWithCompletion:(CDSBooleanCompletionHandler)handlerOrNil{
    
    if (self.mainQueueContext == nil) {
        
        NSError *error = [CDSErrors errorForErrorCode:CDSErrorCodeManagedObjectContextIsNull
                                           withObject:nil];
        if (handlerOrNil != nil) {
            handlerOrNil(NO,error);
        }
    }else{
        
        // set to nil to clear and then build new
        self.mainQueueContext = nil;
        self.mainQueueContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];

        if (self.mainQueueContext == nil) {
            if (handlerOrNil != nil) {
                NSError *error = [CDSErrors errorForErrorCode:CDSErrorCodeFailedToInitiliseMainQueueContext
                                                   withObject:nil];
                handlerOrNil(NO,error);
            }
            return;
        }else{
            self.mainQueueContext.name = kCDSMainQueueContextName;
            self.mainQueueContext.parentContext = self.persistenceContext;
            if (handlerOrNil != nil) {
                handlerOrNil(YES,nil);
            }

        }
        
        
    }
}

@end
