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
    self.hueLabel.text = [NSString stringWithFormat:@"%.0f\u00b0", self.colorModel.hue];
}

- (IBAction)changeSaturation:(UISlider *)sender
{
    self.colorModel.saturation = sender.value;
    self.colorView.backgroundColor = self.colorModel.color;
    self.saturationLabel.text = [NSString stringWithFormat:@"%.0f%%", self.colorModel.saturation];
}

- (IBAction)changeBrightness:(UISlider *)sender
{
    self.colorModel.brightness = sender.value;
    self.colorView.backgroundColor = self.colorModel.color;
    self.brightnessLabel.text = [NSString stringWithFormat:@"%.0f%%", self.colorModel.brightness];
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
