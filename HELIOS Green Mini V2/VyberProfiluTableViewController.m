//
//  VyberProfiluTableViewController.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "VyberProfiluTableViewController.h"

@interface VyberProfiluTableViewController ()

@end

@implementation VyberProfiluTableViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(AppDelegate *)d{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

-(void)viewWillAppear:(BOOL)animated{
    [self addObserver:self.d.modelController forKeyPath:@"seznamProfily" options:0 context:nil];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeObserver:self.d.modelController forKeyPath:@"seznamProfily"];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.d.modelController.seznamProfily count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"profilCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.d.modelController.seznamProfily objectAtIndex:indexPath.row];
    
    if ([self.d.modelController.aktServer.profil isEqualToString:[self.d.modelController.seznamProfily objectAtIndex:indexPath.row]]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *profil = [self.d.modelController.seznamProfily objectAtIndex:indexPath.row];
    self.d.modelController.aktServer.profil = profil;
    [self.tableView reloadData];
}

@end
