//
//  Color.m
//  ColorModel
//
//  Created by X on 20/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "Color.h"

@implementation Color

- (UIColor *)color
{
    return [UIColor colorWithHue:self.hue/360
                      saturation:self.saturation/100
                      brightness:self.brightness/100
                           alpha:1];
}

+ (NSSet *)keyPathsForValuesAffectingColor
{
    return [NSSet setWithObjects: @"hue", @"saturation", @"brightness", nil];
}

@end
