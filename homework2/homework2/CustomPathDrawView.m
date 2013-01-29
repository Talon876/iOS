//
//  CustomPathDrawView.m
//  homework2
//
//  Created by Talon Daniels on 1/27/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import "CustomPathDrawView.h"

@implementation CustomPathDrawView


//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

-(void) awakeFromNib {
    NSLog(@"awoke from nib");
}


-(void) changePatternToNumber:(NSInteger)newPattern {
    
   // NSLog(@"changed pattern to %d", newPattern);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //NSLog(@"creating pattern %d", newPattern);
        switch (newPattern) {
            case 0:
                NSLog(@"case 0");
                int offset = 5;
                path = [UIBezierPath bezierPathWithRect:CGRectMake(0 + offset, 0 + offset, (int)self.frame.size.width - offset*2, (int)self.frame.size.height/4)];
                
                break;
            case 1:
                NSLog(@"case 1");
                
                path = [UIBezierPath new];
                [path moveToPoint:CGPointMake(0, 0)];
                for(int i = 0; i < 100; i++) {
                    int x = rand() % ((int)self.frame.size.width);
                    int y = rand() % ((int)self.frame.size.height);
                    [path addLineToPoint:CGPointMake(x, y)];
                }
                
                break;
                
            case 2:
                NSLog(@"case 2");
                path = [UIBezierPath new];
                [path moveToPoint:CGPointMake(0, 0)];
                for(int i = 0; i < self.bounds.size.height; i+=10) {
                    [path addLineToPoint:CGPointMake((i % 20 == 0) ? 0 : (int)self.frame.size.width, i)];
                }
                
                break;
            default:
                NSLog(@"shouldn't happen");
                break;
        }
        path.lineWidth = 3.;
        
        [self setNeedsDisplay];
    });

}


- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] set];
    [path stroke];
}


@end
