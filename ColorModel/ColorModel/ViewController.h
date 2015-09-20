//
//  ViewController.h
//  ColorModel
//
//  Created by X on 20/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Color.h"

@interface ViewController : UIViewController

@property (strong,nonatomic) Color *colorModel;
@property (weak,nonatomic) IBOutlet UIView *colorView;

@property (weak,nonatomic) IBOutlet UILabel *hueLabel;
@property (weak,nonatomic) IBOutlet UILabel *saturationLabel;
@property (weak,nonatomic) IBOutlet UILabel *brightnessLabel;

- (IBAction)changeHue:(UISlider *)sender;
- (IBAction)changeSaturation:(UISlider *)sender;
- (IBAction)changeBrightness:(UISlider *)sender;

@end

