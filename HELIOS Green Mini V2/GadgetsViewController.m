//
//  GadgetsViewController.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 05.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "GadgetsViewController.h"
#import "DataViewController.h"
#import "GadgetyData.h"
#import "WebViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation GadgetsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(ServerData*)d{
    return [(DataViewController*)self.parentViewController dataObject];
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
    self.navigationController.toolbarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GadgetyData *g = [self.d.gadgety_selected objectAtIndex:section];
    
    float proiPad = 0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            proiPad = 35;
    }
    
    UIView *tableViewHeaderView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    tableViewHeaderView1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(17+proiPad, 0, 20, 20)];
    [tableViewHeaderView1 addSubview:imageView2];
    imageView2.alpha = 1.0;
    imageView2.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    imageView2.image = [UIImage imageNamed:@"sipka.png"];
    imageView2.contentMode = UIViewContentModeScaleToFill;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(45+proiPad, 0, 230, 22)];
    [tableViewHeaderView1 addSubview:label2];
    label2.alpha = 1.0;
    label2.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label2.text = g.nazev;
    label2.textColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    label2.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.shadowOffset = CGSizeMake(0, -1);
    label2.font = [UIFont fontWithName:@".HelveticaNeueUI" size:18.0];
    
    return tableViewHeaderView1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //nacteni a zobrazeni aktualizacnich casu
    
    self.lastUpdate.text = self.d.lastUpdateStr;
    self.nextUpdate.text = self.d.nextUpdateStr;

    return self.d.gadgety_selected_count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GadgetyData *g = [self.d.gadgety_selected objectAtIndex:indexPath.section];
    if (g.html_size<1){
        return 42;
    } else
        return g.html_size;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"webViewCell";
    WebViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSURL *url = [[NSURL alloc]initFileURLWithPath:[(AppDelegate*)[[UIApplication sharedApplication]delegate] applicationDocumentsDirectory]];
    GadgetyData *g = [self.d.gadgety_selected objectAtIndex:indexPath.section];
    
    cell.layer.cornerRadius = 10;
    
    cell.webView.tag = [g.gadget_id intValue];
    [cell.webView loadHTMLString:g.full_html baseURL:url];
    cell.delegate = self.tableView;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
