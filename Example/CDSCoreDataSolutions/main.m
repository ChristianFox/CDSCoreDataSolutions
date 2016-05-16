//
//  main.m
//  CDSCoreDataSolutions
//
//  Created by Christian Fox on 05/16/2016.
//  Copyright (c) 2016 Christian Fox. All rights reserved.
//

@import UIKit;
#import "DEMOAppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        Class appDelegateClass = NSClassFromString(@"CDSTestsAppDelegate");
        if (appDelegateClass == nil) {
            appDelegateClass = [DEMOAppDelegate class];
        }
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass(appDelegateClass));
    }
}
