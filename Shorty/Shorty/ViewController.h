//
//  ViewController.h
//  Shorty
//
//  Created by X on 12/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate,
NSURLConnectionDelegate,
NSURLConnectionDataDelegate>

@property (weak,nonatomic) IBOutlet UITextField *urlField;
@property (weak,nonatomic) IBOutlet UIWebView *webView;

@property (weak,nonatomic) IBOutlet UIBarButtonItem *shortenButton;
@property (weak,nonatomic) IBOutlet UIBarButtonItem *shortLabel;
@property (weak,nonatomic) IBOutlet UIBarButtonItem *clipboardButton;

- (IBAction)loadLocation:(id)sender;
- (IBAction)shortenURL:(id)sender;
- (IBAction)clipboardURL:(id)sender;

@end

