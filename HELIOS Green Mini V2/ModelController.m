//
//  ModelController.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.10.12.
//  Copyright (c) 2012 Jan Damek. All rights reserved.
//

#import "ModelController.h"
#import "DataViewController.h"

@implementation ModelController

@synthesize aktServerIndex=_aktServerIndex;

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        _pageData = [[dateFormatter monthSymbols] copy];
        self.pin = @"";
        self.servery = [[NSMutableArray alloc]init];
        ServerData *s = [[ServerData alloc]init];
        [self.servery addObject:s];
        self.aktServerIndex = 0;
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        self.servery = [aDecoder decodeObjectForKey:@"servery"];
        self.pin = [aDecoder decodeObjectForKey:@"pin"];
        self.dokovane_zobrazeni = [aDecoder decodeBoolForKey:@"dokovat"];
    }
    if (!self.pin)
        self.pin = @"";
    if (!self.servery){
        self.servery = [[NSMutableArray alloc]init];
    }
    if ([self.servery count]==0){
        ServerData *s = [[ServerData alloc]init];
        [self.servery addObject:s];        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.servery forKey:@"servery"];
    [aCoder encodeObject:self.pin forKey:@"pin"];
    [aCoder encodeBool:self.dokovane_zobrazeni forKey:@"dokovat"];
}
-(ServerData*)aktServer{
    if (self.aktServerIndex>-1 && self.aktServerIndex<[self.servery count]){
        return [self.servery objectAtIndex:self.aktServerIndex];
    }else
        return nil;
}
-(void)setAktServerIndex:(int)aktServerIndex{
    _aktServerIndex = aktServerIndex;
    _seznamJazyky = self.aktServer.seznamJazyku;
    _seznamProfily = self.aktServer.seznamProfilu;
    
}
-(int)aktServerIndex{
    return _aktServerIndex;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    // Return the data view controller for the given index.
    if (([self.servery count] == 0) || (index >= [self.servery count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.dataObject = self.servery[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.servery indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    //self.aktServerIndex = index;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.servery count]) {
        return nil;
    }
    //self.aktServerIndex = index;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

-(void)nastavAktServerIndex:(ServerData *)_serverData{
    int index = [self.servery indexOfObject:_serverData];
    _aktServerIndex = index;
}

@end
