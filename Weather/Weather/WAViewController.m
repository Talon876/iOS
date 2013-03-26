//
//  WAViewController.m
//  Weather
//
//  Created by Talon Daniels on 3/25/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import "WAViewController.h"
#import "WAWeatherData.h"

@interface WAViewController () {
    WAWeatherData *weather;
    __weak IBOutlet UIActivityIndicatorView *loadingIcon;
    __weak IBOutlet UILabel *tempLabel;
}

@end

@implementation WAViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherRefreshed:) name:@"weatherRefreshed" object:nil];
    weather = [WAWeatherData new];
    [weather load];
    
}

-(void) weatherRefreshed:(NSNotification*)note {
    NSLog(@"reached view controller's weather refreshed");
    loadingIcon.hidden = YES;
    tempLabel.text = @"25 °F";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
