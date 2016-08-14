//
//  CDSCoreDataStack_PrivateExtension.h
//  Pods
//
//  Created by Eyeye on 14/08/2016.
//
//

#import <CDSCoreDataSolutions/CDSCoreDataStack.h>
#import "CDSErrors.h"

@interface CDSCoreDataStack ()

@property (strong,nonatomic,readwrite) NSManagedObjectModel *managedObjectModel;
@property (strong,nonatomic,readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic) NSManagedObjectContext *publicContext;
@property (strong,nonatomic) NSManagedObjectContext *privateContext;

@end
