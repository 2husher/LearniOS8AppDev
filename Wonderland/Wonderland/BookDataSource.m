//
//  BookDataSource.m
//  Wonderland
//
//  Created by X on 18/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "BookDataSource.h"

@interface BookDataSource ()
{
    Paginator *paginator;
}
@end

@implementation BookDataSource

- (Paginator*)paginator
{
    if (paginator==nil)
    {
        paginator = [Paginator new];
        paginator.font = [UIFont fontWithName:@"Times New Roman" size:18];
    }
    return paginator;
}

- (OnePageViewController*)pageViewController:(UIPageViewController*)pageViewController loadPage:(NSUInteger)page
{
    if (page<1 || ![paginator availablePage:page])
        return nil;
    OnePageViewController *controller; controller = [pageViewController.storyboard instantiateViewControllerWithIdentifier:@"OnePage"];
    controller.paginator = self.paginator;
    controller.pageNumber = page;
    return controller;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger currentPageNumber = ((OnePageViewController*)viewController).pageNumber;
    return [self pageViewController:pageViewController loadPage:currentPageNumber+1];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger currentPageNumber = ((OnePageViewController*)viewController).pageNumber;
    return [self pageViewController:pageViewController loadPage:currentPageNumber-1];
}

@end
