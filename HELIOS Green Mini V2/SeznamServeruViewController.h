//
//  SeznamServeruViewController.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SeznamServeruViewController : UITableViewController

@property (readonly) AppDelegate *d;


-(IBAction)addServer:(id)sender;
-(IBAction)edit:(id)sender;
-(IBAction)done:(id)sender;

@end
