//
//  DataViewController.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.10.12.
//  Copyright (c) 2012 Jan Damek. All rights reserved.
//

#import "DataViewController.h"
#import "ServerData.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(AppDelegate *)d{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.dataLabel.text = [(ServerData*)self.dataObject nazev];
    self.navigationController.toolbarHidden = YES;
    
    [self.d.modelController nastavAktServerIndex:self.dataObject];
    
    UITableView *tableView = [self.container.subviews objectAtIndex:0];
    [tableView reloadData];
    
    [self.dataObject addObserver:self forKeyPath:@"gadgety_change" options:0 context:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.dataObject removeObserver:self forKeyPath:@"gadgety_change"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    UITableView *tableView = [self.container.subviews objectAtIndex:0];
    [tableView reloadData];
}

@end
