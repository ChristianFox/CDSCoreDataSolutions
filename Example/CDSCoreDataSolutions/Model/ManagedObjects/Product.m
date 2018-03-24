/********************************
 *
 * Copyright © 2016-2018 Christian Fox
 *
 * MIT Licence - Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with CDSCoreDataSolutions
 *
 ************************************/


#import "Product.h"
#import "Business.h"

@implementation Product

// Insert code here to add functionality to your managed object subclass



-(NSString *)description{
    
    return [NSString stringWithFormat:@"<MANOBJ> Product: name = %@, priceInPence = %@, business.name = %@",
            self.name,self.priceInPence,self.business.name];
    
}

@end
