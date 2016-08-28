//
//  CDSDefinitions.h
//  Pods
//
//  Created by Eyeye on 07/05/2016.
//
//

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
