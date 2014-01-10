/*
 GetRedirectServices.m
 Creates a list of the services available with the GetRedirect prefix.
 Generated by SudzC.com
 */
#import "GetRedirectServices.h"

@implementation GetRedirectServices

@synthesize logging, server, defaultServer;

@synthesize data;


#pragma mark Initialization

-(id)initWithServer:(NSString*)serverName{
	if(self = [self init]) {
        self.defaultServer = @"/data.asmx";
		self.server = [serverName stringByAppendingString:self.defaultServer];
	}
	return self;
}

+(GetRedirectServices*)service{
	return (GetRedirectServices*)[[GetRedirectServices alloc] init];
}

+(GetRedirectServices*)serviceWithServer:(NSString*)serverName{
	return (GetRedirectServices*)[[GetRedirectServices alloc] initWithServer:serverName];
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
    
	[self updateService: self.data];
}

-(void)updateService:(SoapService*)service{
	service.logging = self.logging;
	if(self.server == nil || self.server.length < 1) { return; }
	service.serviceUrl = [service.serviceUrl stringByReplacingOccurrencesOfString:defaultServer withString:self.server];
}

#pragma mark Getter Overrides


-(GetRedirectData*)data{
	if(data == nil) {
		data = [[GetRedirectData alloc] init];
	}
	return data;
}


@end
