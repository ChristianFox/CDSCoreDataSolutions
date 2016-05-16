//
//  CDSManagedObjectModelDescriptor.h
//  Pods
//
//  Created by Eyeye on 06/05/2016.
//
//

#import <Foundation/Foundation.h>

@interface CDSManagedObjectModelDescriptor : NSObject

@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSURL *directory;
@property (copy,nonatomic, readonly) NSURL *URL;

+(instancetype)managedObjectModelDescriptor;

@end
