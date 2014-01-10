//
//  ModelController.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.10.12.
//  Copyright (c) 2012 Jan Damek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerData.h"

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource, NSCoding>

@property (strong, nonatomic) NSMutableArray *servery;
@property (strong, nonatomic) NSString *pin;
@property BOOL dokovane_zobrazeni;

@property (setter = setAktServerIndex:) int aktServerIndex;
@property (readonly) ServerData *aktServer;
@property (strong) NSArray *seznamJazyky;
@property (strong) NSArray *seznamProfily;

-(void)nastavAktServerIndex:(ServerData*)_serverData;

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end
