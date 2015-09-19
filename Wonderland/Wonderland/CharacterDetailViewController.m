//
//  CharacterDetailViewController.m
//  Wonderland
//
//  Created by X on 17/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "CharacterDetailViewController.h"
#import "CharacterTableViewController.h"

@interface CharacterDetailViewController ()

@end

@implementation CharacterDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.nameLabel.text = _characterInfo[kNameKey];
    self.imageView.image = [UIImage imageNamed:_characterInfo[kImageKey]];
    self.descriptionView.text = _characterInfo[kDescriptionKey];
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
