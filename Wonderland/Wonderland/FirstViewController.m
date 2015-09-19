//
//  FirstViewController.m
//  Wonderland
//
//  Created by X on 17/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) dismissInfo: (id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationFullScreen;
}

- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
{
    UIViewController *presentedVC = controller.presentedViewController;
    UINavigationController *replacementController
        = [[UINavigationController alloc] initWithRootViewController: presentedVC];
    UINavigationItem *navigationItem = presentedVC.navigationItem;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                   target:self
                                   action:@selector(dismissInfo:)];
    navigationItem.rightBarButtonItem = doneButton;
    navigationItem.title = @"Author";
    return replacementController;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"info"])
    {
        UIViewController *presented = (UIViewController *)segue.destinationViewController;
        UIPresentationController *presentationController = presented.presentationController;
        if (presentationController)
            presentationController.delegate = self;
    }
}

@end
