/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with CDSCoreDataSolutions
 *
 ************************************/

#import <CDSCoreDataSolutions/CDSCoreDataStack.h>
#import "CDSErrors.h"




@interface CDSCoreDataStack ()

@property (strong,nonatomic,readwrite) NSManagedObjectModel *managedObjectModel;
@property (strong,nonatomic,readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic,readwrite) NSManagedObjectContext *mainQueueContext;
@property (strong,nonatomic) NSManagedObjectContext *persistenceContext;

@end
