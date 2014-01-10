//
//  NastaveniAppTableViewController.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface NastaveniAppTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITextField *pin;
@property (strong, nonatomic) IBOutlet UISwitch *swithcer;

@property (readonly) AppDelegate *d;

@end
