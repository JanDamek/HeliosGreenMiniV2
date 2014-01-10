//
//  GadgetyData.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 05.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "GadgetyData.h"
#import "AppDelegate.h"

@implementation GadgetyData

-(id)init{
    self = [super init];
    if (self) {
        self.gadget_id = @"";
        self.nazev = @"";
        self.popis = @"";
        self.nazev_kratky = @"";
        
        self.checked = NO;
        
        self.css = @"";
        self.js = @"";
        self.html = @"";
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        self.gadget_id  = [aDecoder decodeObjectForKey:@"id"];
        self.nazev      = [aDecoder decodeObjectForKey:@"nazev"];
        self.nazev_kratky=[aDecoder decodeObjectForKey:@"nazev_min"];
        self.popis      = [aDecoder decodeObjectForKey:@"popis"];
        
        self.checked    = [aDecoder decodeBoolForKey:@"checked"];
        
        self.css        = [aDecoder decodeObjectForKey:@"css"];
        self.js         = [aDecoder decodeObjectForKey:@"js"];
        self.html       = [aDecoder decodeObjectForKey:@"html"];
        
        self.html_size  = [aDecoder decodeFloatForKey:@"html_size"];
    }
    if (!self.gadget_id) self.gadget_id = @"";
    if (!self.nazev) self.nazev = @"";
    if (self.nazev_kratky) self.nazev_kratky = @"";
    if (!self.popis) self.popis = @"";
    
    if (!self.css) self.css = @"";
    if (!self.js) self.js = @"";
    if (!self.html) self.html = @"";
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.gadget_id forKey:@"id"];
    [aCoder encodeObject:self.nazev forKey:@"nazev"];
    [aCoder encodeObject:self.nazev_kratky forKey:@"nazev_min"];
    [aCoder encodeObject:self.popis forKey:@"popis"];
    
    [aCoder encodeBool:self.checked forKey:@"checked"];
    
    [aCoder encodeObject:self.css forKey:@"css"];
    [aCoder encodeObject:self.js forKey:@"js"];
    [aCoder encodeObject:self.html forKey:@"html"];
    
    [aCoder encodeFloat:self.html_size forKey:@"html_size"];
}

-(id)copyWithZone:(NSZone *)zone{
    GadgetyData *c = [[GadgetyData allocWithZone:zone]init];
    c.gadget_id  = [self.gadget_id copy];
    c.nazev      = [self.nazev copy];
    c.nazev_kratky=[self.nazev_kratky copy];
    c.popis      = [self.popis copy];
    
    c.css        = [self.css copy];
    c.js         = [self.js copy];
    c.html       = [self.html copy];
    
    c.html_size  = self.html_size;
    
    return c;
}

-(NSString*)getFull_html{
    NSString *docsDir = [[NSBundle mainBundle] pathForResource:@"gg" ofType:@"css"];
    
    NSError *error;
    NSString *css_default = [NSString stringWithContentsOfFile:docsDir encoding:NSUnicodeStringEncoding error:&error];
    if (error){
        NSLog(@"Error open CSS:%@:",error);
    }
    
    NSString *html_web = @"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head></head><body id=\"b1\">\n";
    html_web = [html_web stringByAppendingFormat:@"<style type=\"text/css\">\n%@\n</style>\n", css_default];
    
    AppDelegate *d = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (!d.modelController.dokovane_zobrazeni){
        html_web = [html_web stringByAppendingFormat:@"<style type=\"text/css\">\n%@\n.dockedVisible{display:none}\n.undockedVisible{display:}</style>\n", self.css];
    }else{
        html_web = [html_web stringByAppendingFormat:@"<style type=\"text/css\">\n%@\n.undockedVisible{display:none}\n.dockedVisible{display:}</style>\n", self.css];        
    }
    if ([self.js length]>0){
        html_web = [html_web stringByAppendingFormat:@"<script type=\"text/javascript\">\n%@\n</script>", self.js];
    }
    html_web = [html_web stringByAppendingFormat:@"%@\n</body></html>", self.html];
    return html_web;
}

@end
