//
//  GadgetsViewController.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 05.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface GadgetsViewController : UITableViewController

@property (readonly) ServerData *d;

@property (strong, nonatomic) IBOutlet UILabel *lastUpdate;
@property (strong, nonatomic) IBOutlet UILabel *nextUpdate;

@end
