//
//  ViewController.m
//  homework1
//
//  Created by Talon Daniels on 1/27/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

BOOL showString1 = true;
NSString *string1 = @"Hello!";
NSString *string2 = @"Goodbye!";

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    DLog();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction) onButtonPressed {
    //DLog("pressed button");
    if(showString1) {
        theLabel.text = string1;
    } else {
        theLabel.text = string2;
    }
    showString1 = !showString1;
}

@end
