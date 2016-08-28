//
//  DEMOViewController.m
//  CDSCoreDataSolutions
//
//  Created by Christian Fox on 05/16/2016.
//  Copyright (c) 2016 Christian Fox. All rights reserved.
//

#import "DEMOViewController.h"

@interface DEMOViewController ()

@end

@implementation DEMOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self logFormat:@"Hello %@",@"world"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logFormat:(NSString*)format,...{
    
    va_list args;
    va_start(args, format);
    
    NSString *string = [[NSString alloc]initWithFormat:format arguments:args];
    NSLog(@"%@",string);
    
    va_end(args);
    
}

@end
