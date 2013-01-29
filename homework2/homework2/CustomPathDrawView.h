//
//  CustomPathDrawView.h
//  homework2
//
//  Created by Talon Daniels on 1/27/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPathDrawView : UIView {
    UIBezierPath *path;
    
}

- (void)changePatternToNumber:(NSInteger)newPattern;

@end
