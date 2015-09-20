//
//  Color.h
//  ColorModel
//
//  Created by X on 20/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Color : NSObject

@property (nonatomic) float hue;
@property (nonatomic) float saturation;
@property (nonatomic) float brightness;
@property (readonly,nonatomic) UIColor *color;

@end
