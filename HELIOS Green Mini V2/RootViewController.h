//
//  RootViewController.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.10.12.
//  Copyright (c) 2012 Jan Damek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface RootViewController : UIViewController <UIPageViewControllerDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (readonly) AppDelegate *d;

-(IBAction)obnovaData:(id)sender;

@end
