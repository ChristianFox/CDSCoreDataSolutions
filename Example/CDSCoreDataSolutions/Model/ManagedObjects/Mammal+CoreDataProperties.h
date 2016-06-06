//
//  Mammal+CoreDataProperties.h
//  CDSCoreDataSolutions
//
//  Created by Eyeye on 07/05/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Mammal.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mammal (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *species;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END