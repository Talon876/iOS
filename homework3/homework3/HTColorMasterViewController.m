//
//  HTColorMasterViewController.m
//  homework3
//
//  Created by Talon Daniels on 2/4/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import "HTColorMasterViewController.h"
#import "HTDetailViewController.h"

@interface HTColorMasterViewController ()

@end

@implementation HTColorMasterViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

HTDetailViewController *redViewController;
UINavigationController *detailNavController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"creating view controllers from storyboard");
    redViewController = (HTDetailViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"redViewController"];
    detailNavController = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier:@"detailNavController"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onRedPressed {
    NSLog(@"pressed red");
    
    //[self.splitViewController.navigationController presentViewController:redViewController animated:YES completion:NULL];
    //[self.splitViewController.navigationController pushViewController:redViewController animated:YES];
    //[self presentViewController:redViewController animated:YES completion:NULL];
    //[self.navigationController presentViewController:redViewController animated:YES completion:NULL];
    //[self.splitViewController presentViewController:redViewController animated:YES completion:NULL];
    //[self.splitViewController.navigationController pushViewController:redViewController animated:YES];
    //[self.splitViewController presentViewController:redViewController animated:YES completion:NULL];
    //[self.splitViewController presentViewController:redNavController animated:YES completion:NULL];
    //[self.splitViewController.navigationController pushViewController:redNavController animated:YES];
    //[self.splitViewController presentViewController:redNavController animated:YES completion:NULL];
    //[self.splitViewController.navigationController popToRootViewControllerAnimated:YES];
    
    //[self.splitViewController.navigationController presentViewController:redViewController animated:YES completion:NULL];
    //[detailNavController pushViewController:redViewController animated:YES]; //crashes saying can't push more than one of the same
    //[self.splitViewController.navigationController pushViewController:redViewController animated:YES]; //does nothing
    
    
//    if(detailNavController == nil || detailNavController == NULL) {
//        NSLog(@"it's null");
//    }
    
   // [detailNavController performSegueWithIdentifier:@"toRedView" sender:self];
    //[self.splitViewController.navigationController performSegueWithIdentifier:@"redSegue" sender:self];
    
    //[detailNavController performSegueWithIdentifier:@"redSegue" sender:self];
    
    
    //[detailNavController pushViewController:redViewController animated:YES];
    
    //[self.splitViewController.navigationController ]
    
    //[[self.splitViewController.viewControllers lastObject] topViewController]
}

-(IBAction)onGreenPressed {
    NSLog(@"pressed green");
}

-(IBAction)onBluePressed {
    NSLog(@"pressed blue");
}

@end



//[self presentViewController:redViewController animated:YES completion:NULL];
//[self.navigationController pushViewController:redViewController animated:YES];
//    UISplitViewController *parent = (UISplitViewController*) self.parentViewController;
//    [parent.presentingViewController presentViewController:redViewController animated:YES completion:NULL];
//[self.splitViewController pushViewController:redViewController animated:YES completion:NULL];
//[self.splitViewController.navigationController pushViewController:redViewController animated:YES];
