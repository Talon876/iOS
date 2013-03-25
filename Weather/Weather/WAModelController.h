//
//  WAModelController.h
//  Weather
//
//  Created by Talon Daniels on 3/25/13.
//  Copyright (c) 2013 Talon Daniels. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WADataViewController;

@interface WAModelController : NSObject <UIPageViewControllerDataSource>

- (WADataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(WADataViewController *)viewController;

@end
