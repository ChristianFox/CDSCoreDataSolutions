//
//  CDSLoggingDelegate.h
//  Pods
//
//  Created by Eyeye on 28/08/2016.
//
//

#import <Foundation/Foundation.h>

@protocol CDSLoggingDelegate <NSObject>


@optional
-(void)logInfo:(NSString*)message,...;
-(void)logWarning:(NSString*)message,...;
-(void)logNotice:(NSString*)message,...;
-(void)logFail:(NSString*)message,...;
-(void)logError:(NSError*)error withPrefix:(NSString*)string message:(NSString*)message,...;

-(void)logNotificationSent:(NSNotification*)note withMessage:(NSString*)message,...;
-(void)logNotificationReceived:(NSNotification*)note withMessage:(NSString*)message,...;

@end
