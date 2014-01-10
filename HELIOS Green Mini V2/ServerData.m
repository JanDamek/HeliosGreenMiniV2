//
//  ServerData.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 05.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "ServerData.h"
#import "GadgetyData.h"
#import "GetRedirectData.h"
#import "XMLReader.h"

@implementation ServerData

@synthesize aktGadgetId=_aktGadgetId, aktGadget = _aktGadget, gadgety_selected = _gadgety_selected, gadgety_selected_count = _gadgety_selected_count;

-(id)init{
    self = [super init];
    if (self){
        self.nazev = @"Výchozí nastavení";
        
        self.URL = @"https://open.lcs.cz/demo43";
        self.username = @"Gadgety";
        self.password = @"G@dgety";
        
        self.profil = @"Demo43";
        self.jazyk = @"CZ";
        self.jazykTxt = @"Czech";
        
        self.intervalObnovy = 5;
        self.intervalObnovyString = @"1 hodina";
        self.alternativniKonfigurace = @"";
        
        self.gadgety = [[NSMutableArray alloc]init];
        
        self.seznamJazyku = [[NSMutableArray alloc]init];
        self.seznamProfilu = [[NSMutableArray alloc]init];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        self.nazev = [aDecoder decodeObjectForKey:@"nazev"];
        
        self.URL = [aDecoder decodeObjectForKey:@"url"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        
        self.profil = [aDecoder decodeObjectForKey:@"profil"];
        self.jazyk = [aDecoder decodeObjectForKey:@"jazyk"];
        self.jazykTxt = [aDecoder decodeObjectForKey:@"jazykTxt"];
        
        self.seznamJazyku = [aDecoder decodeObjectForKey:@"seznamJazyku"];
        self.seznamProfilu = [aDecoder decodeObjectForKey:@"seznamProfilu"];
        
        self.intervalObnovy = [aDecoder decodeIntForKey:@"interval"];
        self.intervalObnovyString = [aDecoder decodeObjectForKey:@"intervalObnovyString"];
        self.lastUpdate = [aDecoder decodeObjectForKey:@"last_update"];
        
        self.alternativniKonfigurace = [aDecoder decodeObjectForKey:@"alternativni"];
        
        self.gadgety = [aDecoder decodeObjectForKey:@"gadgety"];
        
    }
    if (!self.nazev) self.nazev = @"";
    
    if (!self.URL) self.URL = @"";
    if (!self.username) self.username = @"";
    if (!self.password) self.password = @"";
    
    if (!self.profil) self.profil = @"";
    if (!self.jazyk) self.jazyk = @"";
    if (!self.jazykTxt) self.jazykTxt = @"";
    
    if (!self.alternativniKonfigurace) self.alternativniKonfigurace = @"";
    
    if (!self.gadgety) self.gadgety = [[NSMutableArray alloc]init];
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.nazev forKey:@"nazev"];
    
    [aCoder encodeObject:self.URL forKey:@"url"];
    [aCoder encodeObject:self.username forKey:@"username"];
    [aCoder encodeObject:self.password forKey:@"password"];
    
    [aCoder encodeObject:self.profil forKey:@"profil"];
    [aCoder encodeObject:self.jazyk forKey:@"jazyk"];
    [aCoder encodeObject:self.jazykTxt forKey:@"jazykTxt"];
    
    [aCoder encodeObject:self.seznamJazyku forKey:@"seznamJazyku"];
    [aCoder encodeObject:self.seznamProfilu forKey:@"seznamProfilu"];
    
    [aCoder encodeInt:self.intervalObnovy forKey:@"interval"];
    [aCoder encodeObject:self.intervalObnovyString forKey:@"intervalObnovyString"];
    [aCoder encodeObject:self.lastUpdate forKey:@"last_update"];
    
    [aCoder encodeObject:self.alternativniKonfigurace forKey:@"alternativni"];
    
    [aCoder encodeObject:self.gadgety forKey:@"gadgety"];
}

-(id)copyWithZone:(NSZone *)zone{
    ServerData *c = [[ServerData allocWithZone:zone]init];
    
    c.nazev = [self.nazev copy];
    
    c.URL = [self.URL copy];
    c.username = [self.username copy];
    c.password = [self.password copy];
    
    c.profil = [self.profil copy];
    c.jazyk = [self.jazyk copy];
    
    c.intervalObnovy = self.intervalObnovy;
    c.alternativniKonfigurace = [self.alternativniKonfigurace copy];
    
    c.gadgety = [self.gadgety copy];
    
    return c;
}

-(BOOL)gadgetALL;
{
    _gadgety_selected_count = 0;
    _gadgety_selected = [[NSMutableArray alloc]init];
    for (int i=0; i<[self.gadgety count]; i++) {
        GadgetyData *d=[self.gadgety objectAtIndex:i];
        if (d.checked){
            _gadgety_selected_count +=1;
            [_gadgety_selected addObject:d];
        }
    }
    if (_gadgety_selected_count == 0){
        return YES;
    } else
        return NO;
}
-(int)gadgety_selected_count{
    if ([self gadgetALL]){
        return [self.gadgety count];
    }else
        return _gadgety_selected_count;
}
-(NSMutableArray *)gadgety_selected{
    if ([self gadgetALL]){
        return self.gadgety;
    } else
        return _gadgety_selected;
}

-(NSString*)gadgetOrderingList
{
    if (self.gadgetALL)
    {
        NSString *id_order = @"";
        for (int i=0; i<[self.gadgety count]; i++) {
            id_order = [id_order stringByAppendingFormat:@"<Id>%@</Id>",[(GadgetyData*)[self.gadgety objectAtIndex:i] gadget_id]];
            
        }
        return id_order;
    }else
    {
        NSString *id_order = @"";
        for (int i=0; i<[self.gadgety count]; i++) {
            if ([(GadgetyData*)[self.gadgety objectAtIndex:i] checked]) {
                id_order = [id_order stringByAppendingFormat:@"<Id>%@</Id>",[(GadgetyData*)[self.gadgety objectAtIndex:i] gadget_id]];
            }
        }
        return id_order;
    }
}

-(NSString*)getAktGadgetId{
    return _aktGadgetId;
}
-(void)setAktGadgetId:(NSString*)__aktGadgetId{
    _aktGadgetId= __aktGadgetId;
    _aktGadget = nil;
    
    for (GadgetyData *d in self.gadgety) {
        if ([d.gadget_id isEqualToString:_aktGadgetId]){
            _aktGadget = d;
            break;
        }
    }
}

-(void)compareGadget:(NSMutableArray*)_newGadget{
    for (NSMutableDictionary *d in _newGadget) {
        //porovnat zda je v gadgety, pokud ne vlozit novy, pokud je zalozit
        NSString *gg_id = [d objectForKey:@"id"];
        BOOL je = NO;
        for (GadgetyData *dg in self.gadgety) {
            if ([dg.gadget_id isEqualToString:gg_id]){
                je = YES;
            }
        }
        if (!je){
            GadgetyData *g = [[GadgetyData alloc]init];
            g.gadget_id = gg_id;
            [self.gadgety addObject:g];
        }
    }
    for (GadgetyData *d in self.gadgety) {
        //porovnat zda vzechny stavajici gadgety jsou v seznamu novych poli, pokud ne odstranit
        BOOL je = NO;
        for (NSMutableDictionary *ng in _newGadget) {
            NSString *gg_id = [ng objectForKey:@"id"];
            if ([d.gadget_id isEqualToString:gg_id]){
                je = YES;
            }
        }
        if (!je){
            [self.gadgety removeObject:d];
        }
    }
}

-(void)porovnejGagety:(GadgetyData *)_gadget{
    BOOL zaloz_novy = YES;
    self.lastUpdate = [NSDate date];
    for (GadgetyData *d in self.gadgety) {
        if ([d.gadget_id isEqualToString:_gadget.gadget_id]){
            zaloz_novy = NO;
            
            d.nazev = _gadget.nazev;
            d.nazev_kratky = _gadget.nazev_kratky;
            d.js = _gadget.js;
            d.css = _gadget.css;
            d.html = _gadget.html;
            d.popis = _gadget.popis;
            
            self.gadgety_change = !self.gadgety_change;

            break;
        }
    }
    if (zaloz_novy){
        [self.gadgety addObject:_gadget];
    }
}

-(void)nactiServerProfilesLanguages
{
    self.seznamProfilu = [[NSMutableArray alloc]init];
    self.seznamJazyku = [[NSMutableArray alloc]init];
    
    GetRedirectData* _service = [GetRedirectData service];
    _service.logging = NO;
    _service.username = self.username;
    _service.password = self.password;
    NSString *url =[self.redirectURL stringByReplacingOccurrencesOfString:@"/data.asmx" withString:@""];
    _service.serviceUrl = [url stringByAppendingString: @"/data.asmx"];
    
    // Returns NSString*.
    
    [_service GetInfo:self action:@selector(GetProfileList:) myCode: @"GETPROFILES" myValue: [NSString stringWithFormat:@"delimiter=; %@",self.alternativniKonfigurace]];
    [_service GetInfo:self action:@selector(GetLanguageList:) myCode: @"GETLANGUAGES" myValue: self.alternativniKonfigurace];
    
}

- (void) GetProfileList: (id) value {
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"ERROR: %@", value);
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"FAULT: %@", value);
        return;
    }
    
    NSString* result = (NSString*)value;
    NSArray *profiles = [result componentsSeparatedByString:@";"];
    self.seznamProfilu = [profiles copy];
}

- (void) GetLanguageList: (id) value {
    if([value isKindOfClass:[NSError class]]) {
        NSLog(@"ERROR: %@", value);
        return;
    }
    
    if([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"FAULT: %@", value);
        return;
    }
    
    NSString* result = (NSString*)value;
    
    NSDictionary* xmlDict = [XMLReader dictionaryForXMLString:result error:nil];
    NSDictionary *l = [xmlDict valueForKey:@"languages"];
    self.seznamJazyku = [[l valueForKey:@"language"] copy];
}

-(NSString *)getLastUpdateStr{
    return [NSString stringWithFormat:@"%@", self.lastUpdate];
}
-(NSString *)getNextUpdateStr{
    NSDate *n = [self.lastUpdate dateByAddingTimeInterval:60];
    return [NSString stringWithFormat:@"%@", n];
}

@end
