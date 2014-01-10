//
//  NastaveniServeruViewController.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface NastaveniServeruViewController : UITableViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nazev;

@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *url;

@property (strong, nonatomic) IBOutlet UILabel *profil;
@property (strong, nonatomic) IBOutlet UILabel *jazyk;
@property (strong, nonatomic) IBOutlet UILabel *interval;
@property (strong, nonatomic) IBOutlet UITextField *alternativni;

@property (readonly) AppDelegate *d;

@end
