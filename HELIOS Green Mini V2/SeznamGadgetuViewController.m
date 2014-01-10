//
//  SeznamGadgetuViewController.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 05.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "SeznamGadgetuViewController.h"

@interface SeznamGadgetuViewController ()

@end

@implementation SeznamGadgetuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(AppDelegate*)d{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.toolbarHidden = NO;
    [self.tableView reloadData];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.d.modelController.aktServer.gadgety_change = !self.d.modelController.aktServer.gadgety_change;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger *cnt = [self.d.modelController.servery count];
    return cnt;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [(ServerData*)[self.d.modelController.servery objectAtIndex:section]nazev];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ServerData *dat = [self.d.modelController.servery objectAtIndex:section];
    return [dat.gadgety count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"gadgetCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    ServerData *s = [self.d.modelController.servery objectAtIndex:indexPath.section];
    cell.textLabel.text = [[s.gadgety objectAtIndex:indexPath.row] nazev];
    cell.detailTextLabel.text = [[s.gadgety objectAtIndex:indexPath.row] popis];
    if ([[s.gadgety objectAtIndex:indexPath.row] checked]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    if (fromIndexPath.section == toIndexPath.section) {
        NSIndexSet *index = [[NSIndexSet alloc]initWithIndex:fromIndexPath.row];
        self.d.modelController.aktServerIndex = toIndexPath.section;
        [(NSMutableOrderedSet*)self.d.modelController.aktServer.gadgety moveObjectsAtIndexes:index toIndex:toIndexPath.row];
        [self.tableView reloadData];
    }
}
-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    if (sourceIndexPath.section == proposedDestinationIndexPath.section){
        return proposedDestinationIndexPath;
    }else
        return sourceIndexPath;
}
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServerData *s = [self.d.modelController.servery objectAtIndex:indexPath.section];
    GadgetyData *g = [s.gadgety objectAtIndex:indexPath.row];
    g.checked = !g.checked;
    
    [self.tableView reloadData];
}

-(IBAction)editBtn:(id)sender{
    [self.done setEnabled:YES];
    self.tableView.editing = YES;
}
-(IBAction)doneBtn:(id)sender{
    [self.done setEnabled:NO];
    self.tableView.editing = NO;
}
-(IBAction)refreshBtn:(id)sender{
    
}


@end
