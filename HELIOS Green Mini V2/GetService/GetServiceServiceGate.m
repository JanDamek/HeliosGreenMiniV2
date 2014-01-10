/*
	GetServiceServiceGate.m
	The implementation classes and methods for the ServiceGate web service.
	Generated by SudzC.com
*/

#import "GetServiceServiceGate.h"
				
#import "Soap.h"
	

/* Implementation of the service */
				
@implementation GetServiceServiceGate

	- (id) init
	{
		if(self = [super init])
		{
			self.serviceUrl = @"https://open.lcs.cz/extranet42A1/servicegate.asmx";
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
	
	+ (GetServiceServiceGate*) service {
		return [GetServiceServiceGate serviceWithUsername:nil andPassword:nil];
	}
	
	+ (GetServiceServiceGate*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[GetServiceServiceGate alloc] initWithUsername:username andPassword:password];
	}

		
	/* Returns NSString*.  */
	- (SoapRequest*) LogOn: (id <SoapDelegate>) handler profile: (NSString*) profile username: (NSString*) username password: (NSString*) password language: (NSString*) language options: (NSString*) options
	{
		return [self LogOn: handler action: nil profile: profile username: username password: password language: language options: options];
	}

	- (SoapRequest*) LogOn: (id) _target action: (SEL) _action profile: (NSString*) profile username: (NSString*) username password: (NSString*) password language: (NSString*) language options: (NSString*) options
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: profile forName: @"profile"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: username forName: @"username"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: password forName: @"password"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: language forName: @"language"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: options forName: @"options"]];
		NSString* _envelope = [Soap createEnvelope: @"LogOn" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://lcs.cz/webservices/LogOn" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) ProcessXml: (id <SoapDelegate>) handler sessionToken: (NSString*) sessionToken inputXml: (NSString*) inputXml
	{
		return [self ProcessXml: handler action: nil sessionToken: sessionToken inputXml: inputXml];
	}

	- (SoapRequest*) ProcessXml: (id) _target action: (SEL) _action sessionToken: (NSString*) sessionToken inputXml: (NSString*) inputXml
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionToken forName: @"sessionToken"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: inputXml forName: @"inputXml"]];
		NSString* _envelope = [Soap createEnvelope: @"ProcessXml" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://lcs.cz/webservices/ProcessXml" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) LogOff: (id <SoapDelegate>) handler sessionToken: (NSString*) sessionToken
	{
		return [self LogOff: handler action: nil sessionToken: sessionToken];
	}

	- (SoapRequest*) LogOff: (id) _target action: (SEL) _action sessionToken: (NSString*) sessionToken
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionToken forName: @"sessionToken"]];
		NSString* _envelope = [Soap createEnvelope: @"LogOff" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://lcs.cz/webservices/LogOff" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) KeepAlive: (id <SoapDelegate>) handler sessionToken: (NSString*) sessionToken
	{
		return [self KeepAlive: handler action: nil sessionToken: sessionToken];
	}

	- (SoapRequest*) KeepAlive: (id) _target action: (SEL) _action sessionToken: (NSString*) sessionToken
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionToken forName: @"sessionToken"]];
		NSString* _envelope = [Soap createEnvelope: @"KeepAlive" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://lcs.cz/webservices/KeepAlive" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}


@end
	