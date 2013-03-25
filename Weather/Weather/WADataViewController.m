//
//  WADataViewController.m
//  Weather
//
//  Created by Talon Daniels on 3/25/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import "WADataViewController.h"

@interface WADataViewController ()

@end

@implementation WADataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

@end
