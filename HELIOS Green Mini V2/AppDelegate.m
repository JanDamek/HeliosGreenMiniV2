//
//  AppDelegate.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.10.12.
//  Copyright (c) 2012 Jan Damek. All rights reserved.
//

#import "AppDelegate.h"
#import "GetRedirectData.h"
#import "GetServiceServiceGateProcess.h"

@implementation AppDelegate

@synthesize modelController = _modelController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self nactiSOAPData];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

-(NSString*)fileName{
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    return [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"saved-3.dat"]];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [NSKeyedArchiver archiveRootObject:self.modelController toFile:[self fileName]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//    _modelController = [NSKeyedUnarchiver unarchiveObjectWithFile:[self fileName]];
    
    [self nactiSOAPData];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (ModelController *)modelController
{
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [NSKeyedUnarchiver unarchiveObjectWithFile:[self fileName]];
        if (!_modelController){
            _modelController = [[ModelController alloc] init];
        }
    }
    return _modelController;
}

-(NSString*)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

-(void)nactiSOAPData{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    NSURL *candidateURL = [NSURL URLWithString:self.modelController.aktServer.URL];
    if (candidateURL && candidateURL.scheme && candidateURL.host) {
        GetRedirectData* _service = [GetRedirectData service];
        _service.logging = NO;
        _service.username = self.modelController.aktServer.username;
        _service.password = self.modelController.aktServer.password;

        [_service GetInfo:self action:@selector(GetRedirectInfo:) myCode: @"GETREDIRECTINFO" myValue:self.modelController.aktServer.alternativniKonfigurace];
    }
}

-(void) GetRedirectInfo: (id) value {
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        return;
    }
    
    NSString* result = (NSString*)value;
    
    self.modelController.aktServer.redirectURL = result;
    
    [self.modelController.aktServer nactiServerProfilesLanguages];
    
    app.networkActivityIndicatorVisible = YES;
    
    GetServiceServiceGateProcess *_ggList = [[GetServiceServiceGateProcess alloc]init];
    [_ggList run];
}


@end
