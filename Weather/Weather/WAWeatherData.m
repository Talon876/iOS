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
        
    }
    
    for (NSDictionary *dict in weatherInfo ) {
        [variableMap setValue:dict[@"values"] forKey:dict[@"variable"]];
    }
    
    NSArray *minTemps = [variableMap objectForKey:@"tmin2m"];
    NSArray *maxTemps = [variableMap objectForKey:@"tmax2m"];
    NSArray *snowVals = [variableMap objectForKey:@"csnowsfc"];
    NSArray *rainVals = [variableMap objectForKey:@"crainsfc"];
    NSLog(@"%d %d %d %d", [minTemps count], [maxTemps count], [snowVals count], [rainVals count]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd H:m:s"];
    
    // if ([minTemps count] == [maxTemps count] == [snowVals count] == [rainVals count]) {
    NSLog(@"Generating arrays of weather information");
    minsF = [NSMutableArray array];
    maxsF = [NSMutableArray array];
    snowChances = [NSMutableArray array];
    rainChances = [NSMutableArray array];
    dates = [NSMutableArray array];
    
    for (int i = 0; i < [minTemps count]; i++) {
        NSDictionary *todayMin = [minTemps objectAtIndex:i];
        NSDictionary *todayMax = [maxTemps objectAtIndex:i];
        NSDictionary *todaySnow = [snowVals objectAtIndex:i];
        NSDictionary *todayRain = [rainVals objectAtIndex:i];
        NSArray *todayMinPredictions = todayMin[@"predictions"];
        NSArray *todayMaxPredictions = todayMax[@"predictions"];
        NSArray *todaySnowPredictions = todaySnow[@"predictions"];
        NSArray *todayRainPredictions = todayRain[@"predictions"];
        NSString *todayDate = todayMin[@"date"];
        todayDate = [todayDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        todayDate = [todayDate stringByReplacingOccurrencesOfString:@".000Z" withString:@""];
        NSDate *date = [dateFormatter dateFromString:todayDate];
        date = [self fixTimeZone:date];
        todayDate = [dateFormatter stringFromDate:date];
        todayDate = [todayDate stringByReplacingOccurrencesOfString:@" 0:0:0" withString:@" Midnight"];
        todayDate = [todayDate stringByReplacingOccurrencesOfString:@" 6:0:0" withString:@" Morning"];
        todayDate = [todayDate stringByReplacingOccurrencesOfString:@" 12:0:0" withString:@" Midday"];
        todayDate = [todayDate stringByReplacingOccurrencesOfString:@" 18:0:0" withString:@" Evening"];
        [dates addObject:todayDate];
        
        //set todayMinF
        NSInteger fahTempMin = 0;
        for (NSString *temp in todayMinPredictions) {
            float tempValue = [temp floatValue];
            NSInteger fahTemp = (NSInteger)[self fahrenheitFromKelvin:tempValue];
            fahTempMin += fahTemp;
        }
        todayMinF = fahTempMin / [todayMinPredictions count];
        [minsF addObject:[NSNumber numberWithFloat:todayMinF]];
        
        //set todayMaxF
        NSInteger fahTempMax = 0;
        for (NSString *temp in todayMaxPredictions) {
            float tempValue = [temp floatValue];
            NSInteger fahTemp = (NSInteger)[self fahrenheitFromKelvin:tempValue];
            fahTempMax += fahTemp;
        }
        todayMaxF = fahTempMax / [todayMaxPredictions count];
        [maxsF addObject:[NSNumber numberWithFloat:todayMaxF]];
        
        //set todaySnowChance
        float snowChance = 0;
        for (NSString *chance in todaySnowPredictions) {
            int chanceVal = [chance intValue];
            snowChance += chanceVal;
        }
        todaySnowChance = snowChance / [todaySnowPredictions count];
        [snowChances addObject:[NSNumber numberWithFloat:todaySnowChance]];
        
        //set todayRainChance
        float rainChance = 0;
        for (NSString *chance in todayRainPredictions) {
            int chanceVal = [chance intValue];
            rainChance += chanceVal;
        }
        todayRainChance = rainChance / [todayRainPredictions count];
        [rainChances addObject:[NSNumber numberWithFloat:todayRainChance]];
    }
    
    NSLog(@"Mins: %@", minsF);
    NSLog(@"Maxs: %@", maxsF);
    NSLog(@"Snows: %@", snowChances);
    NSLog(@"Rains: %@", rainChances);
    
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

-(NSDate*) fixTimeZone:(NSDate*) sourceDate
{
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    return destinationDate;
}

@end
