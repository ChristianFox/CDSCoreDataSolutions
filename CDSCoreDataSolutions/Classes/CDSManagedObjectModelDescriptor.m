/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with CDSCoreDataSolutions
 *
 ************************************/

#import "CDSManagedObjectModelDescriptor.h"

@interface CDSManagedObjectModelDescriptor ()

@property (copy,nonatomic,readwrite) NSURL *URL;

@end

@implementation CDSManagedObjectModelDescriptor


+(instancetype)managedObjectModelDescriptor{
    return [[self alloc]init];
}

//--------------------------------------------------------
#pragma mark - Getters / Lazy Load Defaults
//--------------------------------------------------------
-(NSURL *)URL{
    if (self.name == nil) {
        return nil;
    }
    NSString *fullModelName = [self.name stringByAppendingPathExtension:@"momd"];
    _URL = [self.directory URLByAppendingPathComponent:fullModelName];
    return _URL;
}

-(NSURL *)directory{
    if (!_directory) {
        _directory = [[NSBundle mainBundle]bundleURL];
    }
    return _directory;
}


@end
