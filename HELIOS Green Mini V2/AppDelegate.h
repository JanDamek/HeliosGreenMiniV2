//
//  AppDelegate.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.10.12.
//  Copyright (c) 2012 Jan Damek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic, readonly) ModelController *modelController;

-(NSString*)applicationDocumentsDirectory;

-(void)nactiSOAPData;

@end
