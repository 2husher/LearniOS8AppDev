//
//  OnePageViewController.h
//  Wonderland
//
//  Created by X on 18/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnePageView.h"
#import "Paginator.h"

@interface OnePageViewController : UIViewController

@property (nonatomic) NSUInteger pageNumber;
@property (strong,nonatomic) Paginator *paginator;
@property (weak,nonatomic) IBOutlet OnePageView *textView;
@property (weak,nonatomic) IBOutlet UILabel *pageLabel;

@end
