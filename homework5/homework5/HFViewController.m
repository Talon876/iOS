//
//  HFViewController.m
//  homework5
//
//  Created by Talon Daniels on 2/27/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import "HFViewController.h"

static NSString* const kServerAddress = @"https://weatherparser.herokuapp.com";

@interface HFViewController () <UIPickerViewDataSource, UIPickerViewDelegate> {
    __weak IBOutlet UIDatePicker *datePicker;
    __weak IBOutlet UIPickerView *picker;
    __weak IBOutlet UITextView *output;
}
-(IBAction) tappedDatePicker;
-(IBAction) tappedPicker;
@end

NSArray *rowIds;
NSArray *variables;
NSDictionary *variableMap;
id collections;

@implementation HFViewController

NSString *currentVariable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    rowIds = [NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:3], [NSNumber numberWithInt:4], nil];
    variables = [NSArray arrayWithObjects:@"csnowsfc", @"crainsfc", @"tmin2m", @"apcpsfc", @"tmax2m", nil];
    NSLog(@"lengths %d %d", [rowIds count], [variables count]);
    variableMap = [NSDictionary dictionaryWithObjects:rowIds forKeys:variables];
    [output setText:@"Select a date and variable then tap on the variable picker"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherRefreshed:) name:@"weatherRefreshed" object:nil];
    
    [self performSelectorInBackground:@selector(refreshWeather) withObject:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) tappedDatePicker
{
    NSLog( @"date picker picked %@", datePicker.date );
}

-(IBAction) tappedPicker
{
    int row = [picker selectedRowInComponent:0];
    currentVariable = [variables objectAtIndex:row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyy-MM-dd"];
    
    NSString *selectedDate = [dateFormatter stringFromDate:datePicker.date];
    NSLog( @"variable %@ for %@", currentVariable, selectedDate);
    if(collections == nil) {
        [output setText:@"No data yet...try again soon"];
    } else {
        [output setText:[NSString stringWithFormat:@"Values for %@ on %@:\n", currentVariable, selectedDate]];
        
        NSDictionary *varDict;
        NSArray *datePredMapArray;
        for(NSDictionary *variable in collections) {
            if([variable[@"variable"] isEqualToString:currentVariable]) {
                varDict = variable;
            }
        }
        BOOL foundData = false;
        datePredMapArray = varDict[@"values"];
        for(NSDictionary *variable in datePredMapArray) {
            NSString *date = [variable[@"date"] substringWithRange:NSMakeRange(0, 10)];
           
            if ([date isEqualToString:selectedDate]) {
                NSLog(@"date selectedDate \n'%@'\n'%@'\n\n", date, selectedDate);
                foundData = true;
                NSArray *predictions = variable[@"predictions"];
                for (NSString *val in predictions) {
                    [output setText:[output.text stringByAppendingFormat:@"%@,",val]];
                }
            }
            
        }
        
        if(foundData == false) {
            [output setText:[NSString stringWithFormat:@"No data found for %@", selectedDate ]];
        }
        
        //NSLog(@"Dictionary: %@", varDict);
    }
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSLog(@"pickerview num components");
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSLog(@"pickerview numberofrows");
    return 5;
}

-(UIView*) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NSString *variable = @"";
    variable = [variables objectAtIndex:row];
    NSLog(@"variable: %@", variable);
    
    UILabel *v = [[UILabel alloc] initWithFrame:CGRectMake( 0., 0., 250., 25. )];
    v.text = variable;
    v.backgroundColor = [UIColor clearColor];
    
    return v;
}

-(void) refreshWeather
{
    NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:kServerAddress]];
    if( [json length] == 0 ) {
#if DEBUG
        NSLog( @"using fake data..." );
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"fake-data" ofType:@"json"];
        json = [NSData dataWithContentsOfFile:filePath];
#else
        NSLog( @"server returned nothing" );
        return;
#endif
    }
    
    NSError* error = nil;
    collections = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    
    if (error)
    {
        NSLog(@"Error parsing JSON %@: %@", [[NSString alloc] initWithData:json encoding:NSASCIIStringEncoding], [error localizedDescription]);
        return;
    }
    
    NSMutableDictionary *currentForecast = [NSMutableDictionary new];
    for( NSDictionary *variable in collections ) {
        //NSArray *predictions = [EWWeatherPrediction newWeatherPredictionsFromDictionary:variable];
        //currentForecast[variable[@"variable"]] = predictions;
        NSLog( @"var: %@", variable[@"variable"] );
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weatherRefreshed" object:currentForecast];
}


-(void) weatherRefreshed:(NSNotification*)note
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"weather refreshed");
}

@end
