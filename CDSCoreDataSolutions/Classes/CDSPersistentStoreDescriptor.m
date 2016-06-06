//
//  CDSPersistentStoreDescriptor.m
//  Pods
//
//  Created by Eyeye on 06/05/2016.
//
//

#import "CDSPersistentStoreDescriptor.h"
@import CoreData;

@interface CDSPersistentStoreDescriptor ()

@property (copy,nonatomic, readwrite) NSURL *URL;
@property (copy,nonatomic, readwrite) NSString *type;
@end

@implementation CDSPersistentStoreDescriptor


+(instancetype)persistentStoreDescriptor{
    return [[self alloc]init];
}

+(instancetype)persistentStoreDescriptorWithName:(NSString *)name{
    CDSPersistentStoreDescriptor *descriptor = [self persistentStoreDescriptor];
    descriptor.name = name;
    return descriptor;
}

//--------------------------------------------------------
#pragma mark - Getters / Lazy Load Defaults
//--------------------------------------------------------
-(NSString *)type{
    if (!_type) {
        _type = NSSQLiteStoreType;
    }
    return _type;
}

-(NSDictionary *)options{
    if (!_options) {
        
#if TARGET_OS_IPHONE
        _options = @{NSPersistentStoreFileProtectionKey:NSFileProtectionComplete,
                          NSMigratePersistentStoresAutomaticallyOption : @YES,
                          NSInferMappingModelAutomaticallyOption : @YES,
                          NSSQLitePragmasOption:@{@"journal_mode":@"DELETE"}};
#elif TARGET_OS_MAC
        _options = @{NSMigratePersistentStoresAutomaticallyOption : @YES,
                          NSInferMappingModelAutomaticallyOption : @YES,
                          NSSQLitePragmasOption:@{@"journal_mode":@"DELETE"}};
#endif
        
    }
    return _options;
}

-(NSURL *)directory{
    if (!_directory) {
        _directory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    }
    return _directory;

}

-(NSURL *)URL{
    NSString *extension;
    if (self.type == NSSQLiteStoreType) {
        extension = @"sqlite";
    }
    NSString *name = [self.name stringByAppendingPathExtension:extension];
    _URL = [self.directory URLByAppendingPathComponent:name];
    return _URL;
}

-(NSString *)configuration{
    if (!_configuration) {
        _configuration = @"Default";
    }
    return _configuration;
}


@end