//
//  ViewController.h
//  ColorModel
//
//  Created by X on 20/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Color.h"
#import "ColorView.h"

@interface ViewController : UIViewController

@property (strong,nonatomic) Color *colorModel;
@property (weak,nonatomic) IBOutlet ColorView *colorView;

@property (weak,nonatomic) IBOutlet UILabel *hueLabel;
@property (weak,nonatomic) IBOutlet UILabel *saturationLabel;
@property (weak,nonatomic) IBOutlet UILabel *brightnessLabel;

@property (weak,nonatomic) IBOutlet UILabel *webLabel;

@property (weak,nonatomic) IBOutlet UISlider *hueSlider;
@property (weak,nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak,nonatomic) IBOutlet UISlider *brightnessSlider;

- (IBAction)changeHue:(UISlider *)sender;
- (IBAction)changeSaturation:(UISlider *)sender;
- (IBAction)changeBrightness:(UISlider *)sender;

@end

