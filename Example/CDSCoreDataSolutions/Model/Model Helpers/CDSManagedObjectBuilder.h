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
@import CoreData;

@interface CDSManagedObjectBuilder : NSObject

+(void)buildAndInsertBusinesses:(NSUInteger)amount
                    intoContext:(NSManagedObjectContext*)context;
+(void)buildAndInsertMotorbikes:(NSUInteger)amount
                    intoContext:(NSManagedObjectContext*)context;
+(void)buildAndInsertCars:(NSUInteger)amount
                    intoContext:(NSManagedObjectContext*)context;
+(void)buildAndInsertPrimates:(NSUInteger)amount
                    intoContext:(NSManagedObjectContext*)context;

@end
