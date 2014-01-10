//
//  IntervalAktualizaceViewController.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "IntervalAktualizaceViewController.h"

@interface IntervalAktualizaceViewController ()

@end

@implementation IntervalAktualizaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _data = [[NSArray alloc] initWithObjects:@"5 min", @"10 min", @"15 min", @"30 min", @"45 min", @"1 hodina", @"2 hodiny", @"6 hodin", @"12 hodin", @"24 hodin", nil];
    [self.intervalPicker selectRow:self.d.modelController.aktServer.intervalObnovy inComponent:0 animated:YES];
    self.navigationController.toolbarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(AppDelegate*)d{
    return  (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_data count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_data objectAtIndex:row];
}

-(void)doneBtn:(id)sender{
    self.d.modelController.aktServer.intervalObnovy = [self.intervalPicker selectedRowInComponent:0];
    self.d.modelController.aktServer.intervalObnovyString = [_data objectAtIndex:self.d.modelController.aktServer.intervalObnovy];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
