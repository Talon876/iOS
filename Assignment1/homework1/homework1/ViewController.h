//
//  ViewController.h
//  homework1
//
//  Created by Talon Daniels on 1/27/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    @private
    IBOutlet UILabel *theLabel;
    IBOutlet UIButton *theButton;
    
}

-(IBAction) onButtonPressed;

@end
