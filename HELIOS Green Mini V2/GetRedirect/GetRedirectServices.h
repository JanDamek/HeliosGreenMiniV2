/*
 GetRedirectServices.h
 Creates a list of the services available with the GetRedirect prefix.
 Generated by SudzC.com
 */
#import "GetRedirectData.h"

@interface GetRedirectServices : NSObject {
	BOOL logging;
	NSString* server;
	NSString* defaultServer;
    GetRedirectData* data;
    
}

-(id)initWithServer:(NSString*)serverName;
-(void)updateService:(SoapService*)service;
-(void)updateServices;
+(GetRedirectServices*)service;
+(GetRedirectServices*)serviceWithServer:(NSString*)serverName;

@property (nonatomic) BOOL logging;
@property (nonatomic, retain) NSString* server;
@property (nonatomic, retain) NSString* defaultServer;

@property (nonatomic, retain, readonly) GetRedirectData* data;

@end