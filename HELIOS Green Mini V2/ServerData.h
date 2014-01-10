//
//  ServerData.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 05.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GadgetyData.h"

@interface ServerData : NSObject <NSCoding, NSCopying>

@property (copy) NSString *nazev;

@property (copy) NSString *URL;
@property (copy) NSString *username;
@property (copy) NSString *password;

@property (copy) NSString *profil;
@property (copy) NSString *jazyk;
@property (copy) NSString *jazykTxt;

@property (copy) NSMutableArray *seznamJazyku;
@property (copy) NSMutableArray *seznamProfilu;

@property int intervalObnovy;
@property (copy) NSString* intervalObnovyString;
@property (copy) NSString *alternativniKonfigurace;
@property (copy) NSDate *lastUpdate;
@property (readonly, getter = getLastUpdateStr) NSString *lastUpdateStr;
@property (readonly, getter = getNextUpdateStr) NSString *nextUpdateStr;

@property (strong, nonatomic) NSMutableArray *gadgety;
@property BOOL gadgety_change;
@property (setter = setAktGadgetId:, getter = getAktGadgetId) NSString *aktGadgetId;
@property (strong, nonatomic) GadgetyData* aktGadget;
@property (readonly) int gadgety_selected_count;
@property (strong, readonly) NSMutableArray *gadgety_selected;

@property (copy) NSString *redirectURL;

-(NSString*)gadgetOrderingList;
-(void)compareGadget:(NSMutableArray*)_newGadget;
-(void)porovnejGagety:(GadgetyData*)_gadget;

-(void)nactiServerProfilesLanguages;

@end