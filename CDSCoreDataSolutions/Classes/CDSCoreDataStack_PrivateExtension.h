//
//  CDSCoreDataStack_PrivateExtension.h
//  Pods
//
//  Created by Eyeye on 14/08/2016.
//
//

#import <CDSCoreDataSolutions/CDSCoreDataStack.h>
#import "CDSErrors.h"

@interface NSManagedObjectContext ()
@property (copy,nonatomic) NSString *CDSID;
@end



static NSString *kContextCDSIDPrefix = @"CDSolutions_";


@interface CDSCoreDataStack ()

@property (strong,nonatomic,readwrite) NSManagedObjectModel *managedObjectModel;
@property (strong,nonatomic,readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic,readwrite) NSManagedObjectContext *mainQueueContext;
@property (strong,nonatomic) NSManagedObjectContext *persistenceContext;

@end
