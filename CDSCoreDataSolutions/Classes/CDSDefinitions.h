/********************************
 *
 * Copyright © 2016-2018 Christian Fox
 *
 * MIT Licence - Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with CDSCoreDataSolutions
 *
 ************************************/



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//======================================================
#pragma mark - ** TypeDefs **
//======================================================
#pragma mark Block Definitions
typedef void(^CDSBooleanCompletionHandler)(BOOL success, NSError * _Nullable error);



//======================================================
#pragma mark - ** Interface **
//======================================================
@interface CDSDefinitions : NSObject

extern NSString *const kCDSContextNamePrefix;
extern NSString *const kCDSMainQueueContextName;
extern NSString *const kCDSPersistenceContextName;
extern NSString *const kCDSBackgroundQueueContextName;






@end
NS_ASSUME_NONNULL_END
