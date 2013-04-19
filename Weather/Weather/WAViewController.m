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
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *weatherImage;
    __weak IBOutlet UIButton *pastButton;
    __weak IBOutlet UIButton *futureButton;
    int dateIndex;
    int numDates;
}

@end

@implementation WAViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [pastButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [futureButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    pastButton.enabled = NO;
    futureButton.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherRefreshed:) name:@"weatherRefreshed" object:nil];
    weather = [WAWeatherData new];
    [weather load];
    
}

-(void) weatherRefreshed:(NSNotification*)note {
    NSLog(@"reached view controller's weather refreshed");
    loadingIcon.hidden = YES;
    dateIndex = 0;
    
    numDates = [weather->minsF count];
    
    [self updateButtonStates];
    [self updateDataForDate:dateIndex];
}

-(void) updateDataForDate:(int)index {
    tempLabel.text = [NSString stringWithFormat:@"%@/%@ °F", [weather->minsF objectAtIndex:index], [weather->maxsF objectAtIndex:index]];
    if ([[weather->snowChances objectAtIndex:index] floatValue] >= 0.5f) {
        weatherImage.image = [UIImage imageNamed:@"snow"];
        NSLog(@"snowing");
    } else if ([[weather->rainChances objectAtIndex:index] floatValue] >= 0.5f) {
        weatherImage.image = [UIImage imageNamed:@"rain"];
        NSLog(@"raining");
    } else {
        weatherImage.image = [UIImage imageNamed:@"sun"];
        NSLog(@"sunshine");
    }
    dateLabel.text = [NSString stringWithFormat:@"%@", [weather->dates objectAtIndex:index]];
}

-(void) updateButtonStates {
    if (dateIndex <= 0) {
        pastButton.enabled = NO;
    } else {
        pastButton.enabled = YES;
    }
    
    if (dateIndex >= numDates - 1) {
        futureButton.enabled = NO;
    } else {
        futureButton.enabled = YES;
    }
}

-(IBAction) pressedPastButton {
    if (dateIndex > 0) {
        dateIndex--;
    }
    [self updateButtonStates];
    [self updateDataForDate:dateIndex];
}

-(IBAction) pressedFutureButton {
    if (dateIndex < numDates - 1) {
        dateIndex++;
    }
    [self updateButtonStates];
    [self updateDataForDate:dateIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
