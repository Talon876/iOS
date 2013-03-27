//
//  WAWeatherData.m
//  Weather
//
//  Created by Talon Daniels on 3/25/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import "WAWeatherData.h"

static NSString* const baseUrl = @"https://weatherparser.herokuapp.com";

@implementation WAWeatherData

//NSArray *rowIds;
//NSArray *variables;
NSMutableDictionary *variableMap;
id weatherInfo;

-(void) load {
    NSLog(@"Loading weather data from %@", baseUrl);
    loaded = NO;
    
//    rowIds = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil];
//    variables = [NSArray arrayWithObjects:@"csnowsfc", @"crainsfc", @"tmin2m", @"apcpsfc", @"tmax2m", nil];
//    variableMap = [NSDictionary dictionaryWithObjects:rowIds forKeys:variables];
    variableMap = [NSMutableDictionary new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherRefreshed:) name:@"weatherRefreshed" object:nil];
    [self performSelectorInBackground:@selector(refreshWeather) withObject:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

-(void) refreshWeather {
    NSLog(@"refreshing weather data");
    
    NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:baseUrl]];
    if( [json length] == 0 ) {
        NSLog(@"Server returned nothing, using fake data");
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"fake-data" ofType:@"json"];
        json = [NSData dataWithContentsOfFile:filePath];
    }
    NSError *error = nil;
    weatherInfo = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    if (error) {
        NSLog(@"Error parsing JSON %@: %@", [[NSString alloc] initWithData:json encoding:NSASCIIStringEncoding], [error localizedDescription]);
        return;
    }
    
    for (NSDictionary *dict in weatherInfo ) {
        NSLog(@"var: %@", dict[@"variable"] );
        [variableMap setValue:dict[@"values"] forKey:dict[@"variable"]];
    }
    
    NSArray *minTemps = [variableMap objectForKey:@"tmin2m"];
    NSArray *maxTemps = [variableMap objectForKey:@"tmax2m"];
    NSArray *snowVals = [variableMap objectForKey:@"csnowsfc"];
    NSDictionary *todayMin = [minTemps objectAtIndex:0];
    NSDictionary *todayMax = [maxTemps objectAtIndex:0];
    NSDictionary *todaySnow = [snowVals objectAtIndex:0];
    NSArray *todayMinPredictions = todayMin[@"predictions"];
    NSArray *todayMaxPredictions = todayMax[@"predictions"];
    NSArray *todaySnowPredictions = todaySnow[@"predictions"];
    
    //set todayMinF
    NSInteger fahTempMin = 0;
    for (NSString *temp in todayMinPredictions) {
        float tempValue = [temp floatValue];
        NSInteger fahTemp = (NSInteger)[self fahrenheitFromKelvin:tempValue];
        fahTempMin += fahTemp;
    }
    todayMinF = fahTempMin / [todayMinPredictions count];
    
    //set todayMaxF
    NSInteger fahTempMax = 0;
    for (NSString *temp in todayMaxPredictions) {
        float tempValue = [temp floatValue];
        NSInteger fahTemp = (NSInteger)[self fahrenheitFromKelvin:tempValue];
        fahTempMax += fahTemp;
    }
    todayMaxF = fahTempMax / [todayMaxPredictions count];
    
    //set todaySnowChance
    float snowChance = 0;
    for (NSString *chance in todaySnowPredictions) {
        int chanceVal = [chance intValue];
        snowChance += chanceVal;
    }
    todaySnowChance = snowChance / [todaySnowPredictions count];
    
    loaded = YES;
     NSLog(@"refreshed weather data");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weatherRefreshed" object:nil];
}

-(void) weatherRefreshed:(NSNotification*)note {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(NSInteger) fahrenheitFromKelvin:(float)kelvin {
    return (NSInteger)(9./5. * (kelvin - 273.) + 32.);
}

@end
