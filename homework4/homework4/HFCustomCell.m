//
//  HFCustomCell.m
//  homework4
//
//  Created by Talon Daniels on 2/18/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import "HFCustomCell.h"

@implementation HFCustomCell

bool green = true;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) deselect {
    self.backgroundColor = [UIColor redColor];
}

-(void) select {
    self.backgroundColor = [UIColor blueColor];
}



@end
