//
//  HTDetailViewController.h
//  homework3
//
//  Created by Talon Daniels on 2/4/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
