//
//  BookDataSource.h
//  Wonderland
//
//  Created by X on 18/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Paginator.h"
#import "OnePageViewController.h"

@interface BookDataSource : NSObject <UIPageViewControllerDataSource>

@property (readonly,nonatomic) Paginator *paginator;

- (OnePageViewController*)pageViewController:pageViewController
                                      loadPage:(NSUInteger)page;

@end
