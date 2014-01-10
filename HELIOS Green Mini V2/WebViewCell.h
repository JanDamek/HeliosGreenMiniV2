//
//  WebViewCell.h
//  HELIOS Green Mini V2
//
//  Created by Jan Damek on 08.04.13.
//  Copyright (c) 2013 Jan Damek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewCell : UITableViewCell<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UITableView *delegate;

@end
