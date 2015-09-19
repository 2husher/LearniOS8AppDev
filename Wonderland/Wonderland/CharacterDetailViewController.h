//
//  CharacterDetailViewController.h
//  Wonderland
//
//  Created by X on 17/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterDetailViewController : UIViewController

@property (weak,nonatomic) IBOutlet UILabel *nameLabel;
@property (weak,nonatomic) IBOutlet UIImageView *imageView;
@property (weak,nonatomic) IBOutlet UITextView *descriptionView;
@property (strong,nonatomic) NSDictionary *characterInfo;

@end
