//
//  Business.m
//  CDSCoreDataSolutions
//
//  Created by Eyeye on 07/05/2016.
//  Copyright © 2016 Christian Fox. All rights reserved.
//

#import "Business.h"

@implementation Business

// Insert code here to add functionality to your managed object subclass


-(NSString *)description{
 
    return [NSString stringWithFormat:@"<MANOBJ> Business: name = %@, employees = %@, products.count = %ld",
            self.name,self.employees,self.products.count];
    
}

@end
