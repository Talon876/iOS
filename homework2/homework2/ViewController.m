//
//  ViewController.m
//  homework2
//
//  Created by Talon Daniels on 1/27/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

// 100%

#import "ViewController.h"
#import "DrawView.h"


@interface ViewController ()

@end

@implementation ViewController

DrawView *drawViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    drawViewController = (DrawView*)[self.storyboard instantiateViewControllerWithIdentifier:@"drawView"];
    
    UIViewController *currentChild = [self.childViewControllers lastObject];
    
    drawViewController.view.frame = childView.frame;
    [childView addSubview:drawViewController.view];
    
   // drawViewController.view.frame = childView.frame;
   // childView = drawViewController.view;
    
//    [UIView transitionFromView:drawViewController.view toView:drawViewController.view duration:0.25f options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
//        [currentChild removeFromParentViewController];
//        [self addChildViewController:drawViewController];
//    }];
    
    //drawViewController.view.frame = self.cont
    
    //NSLog(@"created draw view controller");
    
    //[self.view addSubview:drawView.view];
    
    
    //[self.childViewControllers.lastObject addChildViewController:drawView];
    
    //[self addChildViewController:drawView];

    //drawView.title = @"asdf";
    
   // ViewController *c = self.childViewControllers[0];
    //NSLog(@"%@", c.title);
    
    
        //NSLog(@"added draw view");

    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) buttonPressed {
    [drawViewController changePattern];
}

@end
