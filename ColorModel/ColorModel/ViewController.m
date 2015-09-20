//
//  ViewController.m
//  ColorModel
//
//  Created by X on 20/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (void)updateColor;
@end

@implementation ViewController

- (IBAction)changeHue:(UISlider *)sender
{
    self.colorModel.hue = sender.value;
    [self updateColor];
}

- (IBAction)changeSaturation:(UISlider *)sender
{
    self.colorModel.saturation = sender.value;
    [self updateColor];
}

- (IBAction)changeBrightness:(UISlider *)sender
{
    self.colorModel.brightness = sender.value;
    [self updateColor];
}

- (void)updateColor
{
    self.colorView.backgroundColor = self.colorModel.color;
    self.hueLabel.text = [NSString stringWithFormat:@"%.0f\u00b0",
                          self.colorModel.hue];
    self.saturationLabel.text = [NSString stringWithFormat:@"%.0f%%",
                                 self.colorModel.saturation];
    self.brightnessLabel.text = [NSString stringWithFormat:@"%.0f%%",
                                 self.colorModel.brightness];
    CGFloat red, green, blue, alpha;
    [self.colorModel.color getRed:&red green:&green blue:&blue alpha:&alpha];
    self.webLabel.text = [NSString stringWithFormat:@"#%02lx%02lx%02lx",
                          lroundf(red * 255),
                          lroundf(green * 255),
                          lroundf(blue * 255)];
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
