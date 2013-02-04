//
//  HTMasterViewController.h
//  homework3
//
//  Created by Talon Daniels on 2/4/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTDetailViewController;

@interface HTMasterViewController : UITableViewController

@property (strong, nonatomic) HTDetailViewController *detailViewController;

@end
