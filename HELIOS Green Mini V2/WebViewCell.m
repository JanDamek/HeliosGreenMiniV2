//
//  WebViewCell.m
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import "WebViewCell.h"
#import "AppDelegate.h"
#import "GadgetyData.h"

@implementation WebViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat webHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"] floatValue];
    
    webHeight += self.frame.size.height - webView.frame.size.height;
    
    AppDelegate *d = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    d.modelController.aktServer.aktGadgetId = [NSString stringWithFormat:@"%d", webView.tag];
    GadgetyData *g = d.modelController.aktServer.aktGadget;
    
    if (g.html_size != webHeight){
        g.html_size = webHeight;
        [self.delegate reloadData];
    }
}

@end
