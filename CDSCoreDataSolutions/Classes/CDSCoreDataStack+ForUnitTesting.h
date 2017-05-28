/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with CDSCoreDataSolutions
 *
 ************************************/


#import <CDSCoreDataSolutions/CDSCoreDataStack.h>

@interface CDSCoreDataStack (ForUnitTesting)

//--------------------------------------------------------
#pragma mark - ManagedObjectContext
//--------------------------------------------------------
/**
 * Clears the current context. Just sets the context property to nil and created a new one.
 * @warning Really this is intended for unit testing rather than production code, if you hold a reference to the context in another object and call this method that reference will remain & but the context it holds will no longer be part of the stack - this will cause problems if you then try and use the disconnected reference
 * @param handlerOrNil Provides a BOOL for success status and an NSError object which may be nil
 */
-(void)clearMainQueueContextWithCompletion:(nullable CDSBooleanCompletionHandler)handlerOrNil;



@end
