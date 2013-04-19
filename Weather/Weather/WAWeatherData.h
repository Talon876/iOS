//
//  WAWeatherData.h
//  Weather
//
//  Created by Talon Daniels on 3/25/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAWeatherData : NSObject {
    @public
    BOOL loaded;
    NSMutableArray *minsF;
    NSMutableArray *maxsF;
    NSMutableArray *snowChances;
    NSMutableArray *rainChances;
    NSMutableArray *dates;
    
    int todayMinF;
    int todayMaxF;
    float todaySnowChance;
    float todayRainChance;
}

-(void)load;

@end
