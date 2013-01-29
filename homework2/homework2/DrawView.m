//
//  DrawView.m
//  homework2
//
//  Created by Talon Daniels on 1/27/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import "DrawView.h"
#import "CustomPathDrawView.h"

@implementation DrawView {
    IBOutlet CustomPathDrawView* drawingView1;
    IBOutlet CustomPathDrawView* drawingView2;
    IBOutlet CustomPathDrawView* drawingView3;
    
}

int pattern = 0;


-(void) awakeFromNib {
    NSLog(@"drawview awoke from nib");
}

-(void) changePattern {
    NSLog(@"changing pattern");
    [drawingView1 changePatternToNumber:pattern % 3];
    [drawingView2 changePatternToNumber:(pattern+1) % 3];
    [drawingView3 changePatternToNumber:(pattern+2) % 3];
    pattern++;
}



@end
