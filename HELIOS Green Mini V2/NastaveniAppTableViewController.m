//
//  NastaveniAppTableViewController.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "NastaveniAppTableViewController.h"

@interface NastaveniAppTableViewController ()

@end

@implementation NastaveniAppTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.pin.text = self.d.modelController.pin;
    self.swithcer.on = self.d.modelController.dokovane_zobrazeni;
    self.navigationController.toolbarHidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    self.d.modelController.pin = self.pin.text;
    self.d.modelController.dokovane_zobrazeni = self.swithcer.on;
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(AppDelegate *)d{
    return  (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

@end
