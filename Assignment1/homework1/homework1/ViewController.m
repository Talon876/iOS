//
//  ViewController.m
//  homework1
//
//  Created by Talon Daniels on 1/27/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

// good job, 100%

#import "ViewController.h"

@interface ViewController ()

@end

BOOL showString1 = true; // probably should be an instance variable...
NSString *string1 = @"Aloha (Hello)!";
NSString *string2 = @"Aloha (Goodbye)!";

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
