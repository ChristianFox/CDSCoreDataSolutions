//
//  Product+CoreDataProperties.h
//  CDSCoreDataSolutions
//
//  Created by Eyeye on 07/05/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface Product (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *priceInPence;
@property (nullable, nonatomic, retain) NSString *blurb;
@property (nullable, nonatomic, retain) Business *business;

@end

NS_ASSUME_NONNULL_END