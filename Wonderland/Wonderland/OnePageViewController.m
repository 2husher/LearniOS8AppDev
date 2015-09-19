//
//  OnePageViewController.m
//  Wonderland
//
//  Created by X on 18/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "OnePageViewController.h"

@interface OnePageViewController ()

- (void)loadPageContent;

@end

@implementation OnePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self loadPageContent];
}

- (void)loadPageContent
{
    _paginator.viewSize = _textView.bounds.size;
    if (![_paginator availablePage:_pageNumber])
        _pageNumber = _paginator.lastKnownPage; _textView.fontAttrs = _paginator.fontAttrs;
    _textView.text = [_paginator textForPage:_pageNumber]; [_textView setNeedsDisplay];
    _pageLabel.text = [NSString stringWithFormat:@"Page %u",
                       (unsigned int)_pageNumber];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
