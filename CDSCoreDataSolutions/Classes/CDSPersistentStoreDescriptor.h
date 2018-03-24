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

@interface CDSPersistentStoreDescriptor : NSObject

/// The type of store (NSSQLiteStoreType or NSInMemoryStoreType). Currently only NSSQLiteStoreType and NSInMemoryStoreType are supported. Defaults to NSSQLiteStoreType
@property (copy,nonatomic) NSString *type;
/// The name of the store in the file system. Must be set before use.
@property (copy,nonatomic) NSString *name;
/// The directory the store should be saved in. Defaults to the Documents Directory.
@property (copy,nonatomic) NSURL *directory;
/// The name of the configuration as specified in the xcdatamodel interface.
@property (copy,nonatomic) NSString *configuration;
/// The URL of the store file in the file system. Read only, is created by combining the directory and the name properties.
@property (copy,nonatomic, readonly) NSURL *URL;
/// The Persistent Store options to be used by the NSPersistentStoreCoordinator.
@property (copy,nonatomic) NSDictionary *options;

/// Returns an instance of CDSPersistentStoreDescriptor
+(instancetype)persistentStoreDescriptor;

/// Returns an instance of CDSPersistentStoreDescriptor set with the name.
+(instancetype)persistentStoreDescriptorWithName:(NSString*)name;

@end
