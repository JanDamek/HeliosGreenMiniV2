//  NastaveniServeruViewController.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "NastaveniServeruViewController.h"
#import "TPKeyboardAvoidingTableView.h"

@interface NastaveniServeruViewController ()

@end

@implementation NastaveniServeruViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(AppDelegate *)d{
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
    self.nazev.text = self.d.modelController.aktServer.nazev;
    self.username.text = self.d.modelController.aktServer.username;
    self.url.text = self.d.modelController.aktServer.URL;
    self.password.text = self.d.modelController.aktServer.password;
    self.alternativni.text = self.d.modelController.aktServer.alternativniKonfigurace;
    
    self.profil.text = self.d.modelController.aktServer.profil;
    self.jazyk.text = self.d.modelController.aktServer.jazykTxt;
    
    self.interval.text = self.d.modelController.aktServer.intervalObnovyString;
    self.navigationController.toolbarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    self.d.modelController.aktServer.nazev = self.nazev.text;
    self.d.modelController.aktServer.username = self.username.text;
    self.d.modelController.aktServer.URL = self.url.text;
    self.d.modelController.aktServer.password = self.password.text;
    self.d.modelController.aktServer.alternativniKonfigurace = self.alternativni.text;
    
    [self.d nactiSOAPData];   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    switch (nextTag) {
        case 1:
            [self.url becomeFirstResponder];
            break;
            
        case 2:
            [self.username becomeFirstResponder];
            break;
            
        case 3:
            [self.password becomeFirstResponder];
            break;
            
        case 4:
            [self.alternativni becomeFirstResponder];
            break;
            
        default:
            [textField resignFirstResponder];
            break;
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [(TPKeyboardAvoidingTableView*)self.tableView adjustOffsetToIdealIfNeeded];
}

@end
