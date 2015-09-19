//
//  CharacterTableViewController.h
//  Wonderland
//
//  Created by X on 17/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kImageKey       @"image"
#define kNameKey        @"name"
#define kDescriptionKey @"description"

@interface CharacterTableViewController : UITableViewController

@property (strong,nonatomic) NSArray *tableData;

@end
