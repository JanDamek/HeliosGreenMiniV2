//
//  DataViewController.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.10.12.
//  Copyright (c) 2012 Jan Damek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *container;

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;

@property (strong, readonly) AppDelegate *d;

@end
