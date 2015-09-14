//
//  DetailViewController.m
//  MyStuff
//
//  Created by X on 14/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "DetailViewController.h"
#import "MyWhatsit.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    if (self.detailItem!=nil)
    {
        self.nameField.text = self.detailItem.name;
        self.locationField.text = self.detailItem.location;
    }
}

- (IBAction)changedDetail:(id)sender
{
    if (sender==self.nameField)
        self.detailItem.name = self.nameField.text;
    else if (sender==self.locationField)
        self.detailItem.location = self.locationField.text;
    [self.detailItem postDidChangeNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
