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
}

-(void)load;

@end
