//
//  CDSPersistentStoreDescriptor.h
//  Pods
//
//  Created by Eyeye on 06/05/2016.
//
//

#import <Foundation/Foundation.h>

@interface CDSPersistentStoreDescriptor : NSObject

@property (copy,nonatomic, readonly) NSString *type;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSURL *directory;
@property (copy,nonatomic) NSString *configuration;
@property (copy,nonatomic, readonly) NSURL *URL;
@property (copy,nonatomic) NSDictionary *options;

+(instancetype)persistentStoreDescriptor;
+(instancetype)persistentStoreDescriptorWithName:(NSString*)name;

@end
