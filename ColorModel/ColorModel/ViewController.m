//
//  ViewController.m
//  ColorModel
//
//  Created by X on 20/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)changeHue:(UISlider *)sender
{
    self.colorModel.hue = sender.value;
    self.colorView.backgroundColor = self.colorModel.color;
}

- (IBAction)changeSaturation:(UISlider *)sender
{
    self.colorModel.saturation = sender.value;
    self.colorView.backgroundColor = self.colorModel.color;
}

- (IBAction)changeBrightness:(UISlider *)sender
{
    self.colorModel.brightness = sender.value;
    self.colorView.backgroundColor = self.colorModel.color;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.colorModel = [Color new];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
