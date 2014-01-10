/*
	GetServiceServices.m
	Creates a list of the services available with the GetService prefix.
	Generated by SudzC.com
*/
#import "GetServiceServices.h"

@implementation GetServiceServices

@synthesize logging, server, defaultServer;

@synthesize serviceGate;


#pragma mark Initialization

-(id)initWithServer:(NSString*)serverName{
	if(self = [self init]) {
        self.defaultServer = @"/servicegate.asmx";
		self.server = [serverName stringByAppendingString:self.defaultServer];
	}
	return self;
}

+(GetServiceServices*)service{
	return (GetServiceServices*)[[GetServiceServices alloc] init];
}

+(GetServiceServices*)serviceWithServer:(NSString*)serverName{
	return (GetServiceServices*)[[GetServiceServices alloc] initWithServer:serverName];
}

#pragma mark Methods

-(void)setLogging:(BOOL)value{
	logging = value;
	[self updateServices];
}

-(void)setServer:(NSString*)value{
	server = value;
	[self updateServices];
}

-(void)updateServices{

	[self updateService: self.serviceGate];
}

-(void)updateService:(SoapService*)service{
	service.logging = self.logging;
	if(self.server == nil || self.server.length < 1) { return; }
	service.serviceUrl = [service.serviceUrl stringByReplacingOccurrencesOfString:defaultServer withString:self.server];
}

#pragma mark Getter Overrides


-(GetServiceServiceGate*)serviceGate{
	if(serviceGate == nil) {
		serviceGate = [[GetServiceServiceGate alloc] init];
	}
	return serviceGate;
}


@end
			