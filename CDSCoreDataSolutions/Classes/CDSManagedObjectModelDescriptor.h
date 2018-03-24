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

@interface CDSManagedObjectModelDescriptor : NSObject

/// The name of the xcdatamodel file.
@property (copy,nonatomic) NSString *name;
/// The directory the xcdatamodel file can be found in. Defaults to NSBundle.mainBundle.
@property (copy,nonatomic) NSURL *directory;
/// The URL of the xcdatamodel file. Read only. Created by combining the directory and name.
@property (copy,nonatomic, readonly) NSURL *URL;

/// Returns a new instance of CDSManagedObjectModelDescriptor.
+(instancetype)managedObjectModelDescriptor;

@end
