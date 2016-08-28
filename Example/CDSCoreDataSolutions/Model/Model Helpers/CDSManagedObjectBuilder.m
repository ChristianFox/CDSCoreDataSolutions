//
//  CDSManagedObjectBuilder.m
//  CDSCoreDataSolutions
//
//  Created by Eyeye on 07/05/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//

#import "CDSManagedObjectBuilder.h"
#import "Business.h"
#import "Primate.h"
#import "Car.h"
#import "Motorbike.h"

@implementation CDSManagedObjectBuilder

+(void)buildAndInsertBusinesses:(NSUInteger)amount
                    intoContext:(NSManagedObjectContext *)context{
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Business"
                                              inManagedObjectContext:context];
    
    for (NSUInteger idx = 0; idx < amount; idx++) {
    
        Business *biz = [[Business alloc] initWithEntity:entity
                                           insertIntoManagedObjectContext:context];
        biz.name = [NSString stringWithFormat:@"Biz %lu",(unsigned long)idx];
        biz.employees = @(idx);
    }
}

+(void)buildAndInsertMotorbikes:(NSUInteger)amount
                    intoContext:(NSManagedObjectContext*)context{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Motorbike"
                                              inManagedObjectContext:context];
    
    for (NSUInteger idx = 0; idx < amount; idx++) {
        
        Motorbike *bike = [[Motorbike alloc] initWithEntity:entity
                          insertIntoManagedObjectContext:context];
        bike.name = [NSString stringWithFormat:@"Bike %lu",(unsigned long)idx];
        bike.blurb = [NSString stringWithFormat:@"%lu KM",(unsigned long)idx];
    }

}

+(void)buildAndInsertCars:(NSUInteger)amount
              intoContext:(NSManagedObjectContext*)context{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Car"
                                              inManagedObjectContext:context];
    
    for (NSUInteger idx = 0; idx < amount; idx++) {
        
        Car *car = [[Car alloc] initWithEntity:entity
                             insertIntoManagedObjectContext:context];
        car.name = [NSString stringWithFormat:@"Car %lu",(unsigned long)idx];
        car.blurb = @"This is a fast car";}

}

+(void)buildAndInsertPrimates:(NSUInteger)amount intoContext:(NSManagedObjectContext *)context{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Primate"
                                              inManagedObjectContext:context];
    
    for (NSUInteger idx = 0; idx < amount; idx++) {
        
        Primate *primate = [[Primate alloc] initWithEntity:entity
                          insertIntoManagedObjectContext:context];
        primate.name = [NSString stringWithFormat:@"Primate %lu",(unsigned long)idx];
        primate.species = @"Ape";
    }
}



@end
