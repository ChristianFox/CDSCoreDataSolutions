//
//  CDSCoreDataStack+ForUnitTesting.h
//  Pods
//
//  Created by Eyeye on 14/08/2016.
//
//

#import <CDSCoreDataSolutions/CDSCoreDataStack.h>

@interface CDSCoreDataStack (ForUnitTesting)

//--------------------------------------------------------
#pragma mark - ManagedObjectContext
//--------------------------------------------------------
/**
 * Clears the current context. Just sets the context property to nil and created a new one.
 * @warning Really this is intended for unit testing rather than production code, if you hold a reference to the context in another object and call this method that reference will remain & but the context it holds will no longer be part of the stack - this will cause problems if you then try and use the disconnected reference
 * @param completionHandler: Provides a BOOL for success status and an NSError object which may be nil
 */
-(void)clearContextWithCompletion:(nullable CDSBooleanCompletionHandler)handlerOrNil;



@end
