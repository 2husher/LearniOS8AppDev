//
//  DetailViewController.h
//  MyStuff
//
//  Created by X on 14/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyWhatsit;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) MyWhatsit *detailItem;

@property (weak,nonatomic) IBOutlet UITextField *nameField;
@property (weak,nonatomic) IBOutlet UITextField *locationField;

- (IBAction)changedDetail:(id)sender;

@end

