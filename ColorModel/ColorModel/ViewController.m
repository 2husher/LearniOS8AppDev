//
//  ViewController.m
//  ColorModel
//
//  Created by X on 20/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//- (void)updateColor;
@end

@implementation ViewController

- (IBAction)changeHue:(UISlider *)sender
{
    self.colorModel.hue = sender.value;
//    [self updateColor];
}

- (IBAction)changeSaturation:(UISlider *)sender
{
    self.colorModel.saturation = sender.value;
//    [self updateColor];
}

- (IBAction)changeBrightness:(UISlider *)sender
{
    self.colorModel.brightness = sender.value;
//    [self updateColor];
}

//- (void)updateColor
//{
//    [self.colorView setNeedsDisplay];
//    //self.colorView.backgroundColor = self.colorModel.color;
//    self.hueLabel.text = [NSString stringWithFormat:@"%.0f\u00b0",
//                          self.colorModel.hue];
//    self.saturationLabel.text = [NSString stringWithFormat:@"%.0f%%",
//                                 self.colorModel.saturation];
//    self.brightnessLabel.text = [NSString stringWithFormat:@"%.0f%%",
//                                 self.colorModel.brightness];
//    CGFloat red, green, blue, alpha;
//    [self.colorModel.color getRed:&red green:&green blue:&blue alpha:&alpha];
//    self.webLabel.text = [NSString stringWithFormat:@"#%02lx%02lx%02lx",
//                          lroundf(red * 255),
//                          lroundf(green * 255),
//                          lroundf(blue * 255)];
//}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"hue"])
    {
        self.hueLabel.text = [NSString stringWithFormat:@"%.0f\u00b0",
                              self.colorModel.hue];
        self.hueSlider.value = _colorModel.hue;
    }
    else if ([keyPath isEqualToString:@"saturation"])
    {
        self.saturationLabel.text = [NSString stringWithFormat:@"%.0f%%",
                                     self.colorModel.saturation];
        self.saturationSlider.value = _colorModel.saturation;
    }
    else if ([keyPath isEqualToString:@"brightness"])
    {
        self.brightnessLabel.text = [NSString stringWithFormat:@"%.0f%%",
                                     self.colorModel.brightness];
        self.brightnessSlider.value = _colorModel.brightness;
    }
    else if ([keyPath isEqualToString:@"color"])
    {
        [self.colorView setNeedsDisplay];
        CGFloat red, green, blue, alpha;
        [self.colorModel.color getRed:&red green:&green blue:&blue alpha:&alpha];
        self.webLabel.text = [NSString stringWithFormat:@"#%02lx%02lx%02lx",
                              lroundf(red*255),
                              lroundf(green*255),
                              lroundf(blue*255)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.colorModel = [Color new];
    self.colorView.colorModel = self.colorModel;

    [_colorModel addObserver:self forKeyPath:@"hue" options:0 context:NULL];
    [_colorModel addObserver:self forKeyPath:@"saturation" options:0 context:NULL];
    [_colorModel addObserver:self forKeyPath:@"brightness" options:0 context:NULL];
    [_colorModel addObserver:self forKeyPath:@"color" options:0 context:NULL];

    _colorModel.hue        = 60;
    _colorModel.saturation = 50;
    _colorModel.brightness = 100;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
