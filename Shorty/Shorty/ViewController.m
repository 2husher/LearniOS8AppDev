//
//  ViewController.m
//  Shorty
//
//  Created by X on 12/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSURLConnection *shortenURLConnection;
    NSMutableData *shortURLData;
}

@end

#define kGoDaddyAccountKey @"0123456789abcdef0123456789abcdef"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)loadLocation:(id)sender
{
    NSString *urlText = self.urlField.text;
    if (![urlText hasPrefix:@"http:"] && ![urlText hasPrefix:@"https:"])
    {
        if (![urlText hasPrefix:@"//"])
            urlText = [@"//" stringByAppendingString:urlText];
        urlText = [@"http:" stringByAppendingString:urlText];
    }
    NSURL *url = [NSURL URLWithString:urlText];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (IBAction)shortenURL:(id)sender
{
    NSString *urlToShorten = self.webView.request.URL.absoluteString;
    NSString *urlString = [NSString stringWithFormat:@"http://api.x.co/Squeeze.svc/text/%@?url=%@", kGoDaddyAccountKey, [urlToShorten stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    shortURLData = [NSMutableData new];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    shortenURLConnection = [NSURLConnection connectionWithRequest:request
                                                         delegate:self];
    self.shortenButton.enabled = NO;
}

- (IBAction)clipboardURL:(id)sender
{
    NSString *shortURLString = self.shortLabel.title;
    NSURL *shortURL = [NSURL URLWithString:shortURLString];
    [[UIPasteboard generalPasteboard] setURL:shortURL];
}

#pragma mark - UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.shortenButton.enabled = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.shortenButton.enabled = YES;
    self.urlField.text = webView.request.URL.absoluteString;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSString *message = [NSString stringWithFormat:
                         @"A problem occurred trying to load this page: %@",
                         error.localizedDescription];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not load URL"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"That's Sad"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - NSURLConnectionDelegate Methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.shortLabel.title = @"failed";
    self.clipboardButton.enabled = NO;
    self.shortenButton.enabled = YES;
}

#pragma mark - NSURLConnectionDataDelegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [shortURLData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *shortURLString = [[NSString alloc] initWithData:shortURLData
                                                     encoding:NSUTF8StringEncoding];
    self.shortLabel.title = shortURLString;
    self.clipboardButton.enabled = YES;
}

@end
