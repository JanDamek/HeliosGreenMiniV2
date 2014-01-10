//
//  IntervalAktualizaceViewController.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface IntervalAktualizaceViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray *_data;
}

@property (nonatomic, strong) IBOutlet UIPickerView *intervalPicker;
@property (readonly) AppDelegate *d;

-(IBAction)doneBtn:(id)sender;

@end
