
#import "GetServiceServiceGateProcess.h"
#import "AppDelegate.h"
#import "XMLreader.h"
#import "ServerData.h"
#import "GadgetyData.h"

@implementation GetServiceServiceGateProcess

@synthesize service = _service;
@synthesize sessionToken = _sessionToken;


- (void)run {
    AppDelegate *d = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ServerData *s = d.modelController.aktServer;
    if ((![s.profil isEqualToString:@""]) && (![s.jazyk isEqualToString:@""])){
        // Create the service
        _service = [GetServiceServiceGate service];
        _service.logging = NO;
        _service.serviceUrl = [s.redirectURL stringByAppendingString:@"/servicegate.asmx"];
        
        _service.username = s.username;
        _service.password = s.password;
        
        // Returns NSString*.
        UIApplication* app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = YES;
        
        [_service LogOn:self action:@selector(LogOnHandler:) profile: s.profil username: s.username password: s.password language: s.jazyk options: s.alternativniKonfigurace];
    }else {
        UIApplication* app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = NO;
    }
}
-(void)doHtml{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    AppDelegate *d = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ServerData *s = d.modelController.aktServer;
    
    NSString *xml = [NSString stringWithFormat:@"<RUN FUNCTIONID=\"5485\"><USERDATA><Version>43.40.00.07</Version><ResponseFormat>Segmented</ResponseFormat><SelectedGadgets>%@</SelectedGadgets></USERDATA></RUN>", [s gadgetOrderingList]];
    
    [_service ProcessXml:self action:@selector(GettingGadgetHandler:) sessionToken:_sessionToken inputXml:xml];
    
}

// Handle the response from KeepAlive.

- (void) KeepAliveHandler: (id) value {
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"ERROR KeepAlive:%@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"FAULT KeepAlive:%@", value);
		return;
	}
    
    
	// Do something with the NSString* result
    //    NSString* result = (NSString*)value;
    
}


// Handle the response from LogOff.

- (void) LogOffHandler: (id) value {
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"ERROR LogOff:%@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"FAULT LogOff:%@", value);
		return;
	}
    
    
	// Do something with the NSString* result
    NSString* result = (NSString*)value;
    if ([result isEqualToString:@"1"]){
        _sessionToken = @"";
    }
}


// Handle the response from LogOn.

- (void) LogOnHandler: (id) value {
    
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
	
    // Handle errors
	if([value isKindOfClass:[NSError class]]) {
        AppDelegate *d = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [d.modelController.aktServer.gadgety removeAllObjects];
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
        AppDelegate *d = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [d.modelController.aktServer.gadgety removeAllObjects];
		return;
	}
    
    
	// Do something with the NSString* result
    NSString* result = (NSString*)value;
    NSArray *sesions = [result componentsSeparatedByString:@","];
    if ([sesions count]>0){
        _sessionToken = [sesions objectAtIndex:0];
        if ([_sessionToken hasPrefix:@"ERROR:"]){
            NSLog(@"LogOn returned the ERROR value: %@", result);
            _sessionToken = @"";
            AppDelegate *d = (AppDelegate*)[[UIApplication sharedApplication]delegate];
            [d.modelController.aktServer.gadgety removeAllObjects];
        }
        else {
            // zadost o seznam gadgetu
            NSString *string = @"<RUN FUNCTIONID=\"5608\"></RUN>";
            [_service ProcessXml:self action:@selector(ProcessXmlHandler:) sessionToken: _sessionToken inputXml: string];
        }
    }
}


- (void) GettingGadgetHandler: (id) value {
    
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
	
    // Handle errors
	if([value isKindOfClass:[NSError class]]) {
        AppDelegate *d = [[UIApplication sharedApplication]delegate];
        [d.modelController.aktServer.gadgety removeAllObjects];
		NSLog(@"ERROR ProcessXml 5485:%@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
        AppDelegate *d = [[UIApplication sharedApplication]delegate];
        [d.modelController.aktServer.gadgety removeAllObjects];
		NSLog(@"FAULT ProcessXml 5485:%@", value);
		return;
	}
    
    AppDelegate *d = [[UIApplication sharedApplication]delegate];
	// Do something with the NSString* result
    NSString* result = (NSString*)value;
    
    if (![result isEqualToString:@""]){
        //provest nacteni potrebnych dat
        NSDictionary* xmlDict = [XMLReader dictionaryForXMLString:result error:nil];
        if (xmlDict.count>0){
            NSMutableArray *gadgets=[xmlDict valueForKey:@"RUNRESULT"];
            
            if (gadgets!=nil && [gadgets count]>0){
                NSMutableDictionary *gg = [gadgets valueForKey:@"USERDATA"];
                NSMutableDictionary *gadgets = [gg objectForKey:@"Gadgets"];
                NSObject *ggg_source = [gadgets objectForKey:@"Gadget"];
                NSMutableArray *ggg;
                if ([ggg_source isKindOfClass:[NSMutableDictionary class]]){
                    ggg = [[NSMutableArray alloc] initWithObjects:ggg_source, nil];
                }else
                {
                    ggg = [ggg_source copy];
                }
                
                
                for (NSMutableDictionary *gg in ggg) {
                    
                    NSMutableDictionary *g;
                    
                    g = [gg objectForKey:@"JssScripts"];
                    NSString *js = [g valueForKey:@"text"];
                    if (js == nil){
                        js = @"";
                    }
                    
                    g = [gg objectForKey:@"CssStyles"];
                    NSString *css = [g valueForKey:@"text"];
                    if (css == nil){
                        css = @"";
                    }
                    
                    g = [gg objectForKey:@"HtmlData"];
                    NSString *html = [g valueForKey:@"text"];
                    if (html == nil){
                        html = @"";
                    }

                    GadgetyData *gadget = [[GadgetyData alloc]init];
                    gadget.js = js;
                    gadget.css = css;
                    gadget.html = html;
                    gadget.gadget_id = [gg objectForKey:@"id"];
                    gadget.nazev_kratky = [gg objectForKey:@"name_minimal"];
                    gadget.nazev = [gg objectForKey:@"name"];
                    gadget.popis = [gg objectForKey:@"description"];

                    [d.modelController.aktServer porovnejGagety:gadget];
                }
                d.modelController.aktServer.gadgety_change = !d.modelController.aktServer.gadgety_change;
            }else{
                [d.modelController.aktServer.gadgety removeAllObjects];
            }
        }else{
            [d.modelController.aktServer.gadgety removeAllObjects];
        }
    }else{
        [d.modelController.aktServer.gadgety removeAllObjects];
    }
    [_service LogOff:self action:@selector(LogOffHandler:) sessionToken:_sessionToken];
}

// Handle the response from ProcessXml.

- (void) ProcessXmlHandler: (id) value {
    
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    AppDelegate *d = [[UIApplication sharedApplication]delegate];
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
        [d.modelController.aktServer.gadgety removeAllObjects];
		NSLog(@"ERROR ProcessXML:%@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
        [d.modelController.aktServer.gadgety removeAllObjects];
		NSLog(@"FAULT ProccesXML:%@", value);
		return;
	}
    
    
	// Do something with the NSString* result
    NSString* result = (NSString*)value;
    
    //nactena data
    //provest proces nacteni dat dle obsahu
    if (![result isEqualToString:@""]){
        //provest nacteni potrebnych dat
        NSDictionary* xmlDict = [XMLReader dictionaryForXMLString:result error:nil];
        if (xmlDict.count>0){
            
            NSMutableArray *gadgets=[xmlDict valueForKey:@"RUNRESULT"];
            
            if (gadgets!=nil && [gadgets count]>0){
                gadgets = [gadgets valueForKey:@"USERDATA"];
                
                if (gadgets!=nil && [gadgets count]>0){
                    gadgets = [gadgets valueForKey:@"Gadgets"];
                    
                    if (gadgets!=nil && [gadgets count]>0){
                        gadgets = [gadgets valueForKey:@"Gadget"];
                        
                        NSMutableArray *dgadgetList = [[NSMutableArray alloc]init];
                        for (int i=0;i<[gadgets count];i++){
                            NSMutableDictionary *gg = [gadgets objectAtIndex:i];
                            [dgadgetList addObject:gg];
                        }
                        [d.modelController.aktServer compareGadget:dgadgetList];
                        [self doHtml];
                    }
                }else
                {
                    [d.modelController.aktServer.gadgety removeAllObjects];
                }
            }else{
                [d.modelController.aktServer.gadgety removeAllObjects];
            }
        }else{
            [d.modelController.aktServer.gadgety removeAllObjects];
        }
    } else {
        [d.modelController.aktServer.gadgety removeAllObjects];
    }
}


@end
