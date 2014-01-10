//
//  GadgetyData.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 05.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GadgetyData : NSObject <NSCoding, NSCopying>

@property (copy) NSString *gadget_id;
@property (copy) NSString *nazev;
@property (copy) NSString *nazev_kratky;
@property (copy) NSString *popis;

@property BOOL checked;

@property (copy) NSString *css;
@property (copy) NSString *js;
@property (copy) NSString *html;

@property float html_size;

@property (readonly, getter = getFull_html) NSString *full_html;

@end
