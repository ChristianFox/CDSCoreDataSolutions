//
//  CDSManagedObjectBuilder.h
//  CDSCoreDataSolutions
//
//  Created by Eyeye on 07/05/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//

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
