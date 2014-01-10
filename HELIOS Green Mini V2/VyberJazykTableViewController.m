//
//  VyberJazykTableViewController.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "VyberJazykTableViewController.h"

@interface VyberJazykTableViewController ()

@end

@implementation VyberJazykTableViewController

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
    [self addObserver:self.d.modelController forKeyPath:@"seznamJazyky" options:0 context:nil];
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self removeObserver:self.d.modelController forKeyPath:@"seznamJazyky"];
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
    return [self.d.modelController.seznamJazyky count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"jazykCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSMutableDictionary *d = [self.d.modelController.seznamJazyky objectAtIndex:indexPath.row];
    cell.textLabel.text = [d objectForKey:@"name"];
    
    if ([self.d.modelController.aktServer.jazyk isEqualToString:[d objectForKey:@"code"]]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.d.modelController.aktServer.jazyk = [[self.d.modelController.seznamJazyky objectAtIndex:indexPath.row] objectForKey:@"code"];
    self.d.modelController.aktServer.jazykTxt = [[self.d.modelController.seznamJazyky objectAtIndex:indexPath.row] objectForKey:@"name"];
    [self.tableView reloadData];
}

@end
