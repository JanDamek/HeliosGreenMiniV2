//
//  SeznamGadgetuViewController.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 05.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SeznamGadgetuViewController : UITableViewController

@property (readonly) AppDelegate *d;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *done;

-(IBAction)editBtn:(id)sender;
-(IBAction)doneBtn:(id)sender;
-(IBAction)refreshBtn:(id)sender;

@end
