/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with CDSCoreDataSolutions
 *
 ************************************/

#import <Foundation/Foundation.h>

@protocol CDSLoggingDelegate <NSObject>


@optional
-(void)logInfo:(NSString*)message;
-(void)logWarning:(NSString*)message;
-(void)logNotice:(NSString*)message;
-(void)logFail:(NSString*)message;
-(void)logError:(NSError*)error withPrefix:(NSString*)string message:(NSString*)message;

-(void)logNotificationSent:(NSNotification*)note withMessage:(NSString*)message;
-(void)logNotificationReceived:(NSNotification*)note withMessage:(NSString*)message;

@end
