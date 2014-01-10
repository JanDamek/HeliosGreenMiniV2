/*
	GetRedirectData.m
	The implementation classes and methods for the Data web service.
	Generated by SudzC.com
*/

#import "GetRedirectData.h"
#import "Soap.h"
#import "AppDelegate.h"
#import "ServerData.h"	

/* Implementation of the service */
				
@implementation GetRedirectData

	- (id) init
	{
		if(self = [super init])
		{
            AppDelegate *d = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            ServerData *s = d.modelController.aktServer;
            if (s.URL){
                s.URL =[s.URL stringByReplacingOccurrencesOfString:@"/data.asmx" withString:@""];
                self.serviceUrl = [s.URL stringByAppendingString: @"/data.asmx"];
            }
			self.namespace = @"http://lcs.cz/webservices/";
			self.headers = nil;
			self.logging = NO;
		}
		return self;
	}
	
	- (id) initWithUsername: (NSString*) username andPassword: (NSString*) password {
		if(self = [super initWithUsername:username andPassword:password]) {
		}
		return self;
	}
	
	+ (GetRedirectData*) service {
		return [GetRedirectData serviceWithUsername:nil andPassword:nil];
	}
	
	+ (GetRedirectData*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[GetRedirectData alloc] initWithUsername:username andPassword:password];
	}

		
	/* Returns NSString*.  */
	- (SoapRequest*) GetInfo: (id <SoapDelegate>) handler myCode: (NSString*) myCode myValue: (NSString*) myValue
	{
		return [self GetInfo: handler action: nil myCode: myCode myValue: myValue];
	}

	- (SoapRequest*) GetInfo: (id) _target action: (SEL) _action myCode: (NSString*) myCode myValue: (NSString*) myValue
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: myCode forName: @"myCode"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: myValue forName: @"myValue"]];
		NSString* _envelope = [Soap createEnvelope: @"GetInfo" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://lcs.cz/webservices/GetInfo" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}


@end
	