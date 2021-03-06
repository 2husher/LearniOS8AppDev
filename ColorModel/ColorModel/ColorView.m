//
//  ColorView.m
//  ColorModel
//
//  Created by X on 20/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "ColorView.h"

#define kCircleRadius 40.0f

@interface ColorView ()
{
    CGImageRef hsImageRef;
    float brightness;
}

- (void)changeHSToPoint:(CGPoint)point;

@end

@implementation ColorView

- (void)dealloc
{
    if (hsImageRef != NULL)
        CGImageRelease(hsImageRef);
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (hsImageRef != NULL &&
        (brightness != _colorModel.brightness ||
         bounds.size.width  != CGImageGetWidth(hsImageRef) ||
         bounds.size.height != CGImageGetHeight(hsImageRef)))
    {
        CGImageRelease(hsImageRef);
        hsImageRef = NULL;
    }
    if (hsImageRef == NULL)
    {
        brightness = _colorModel.brightness;
        NSUInteger width  = bounds.size.width;
        NSUInteger height = bounds.size.height;
        typedef struct {
            uint8_t red;
            uint8_t green;
            uint8_t blue;
            uint8_t alpha;
        } Pixel;
        NSMutableData *bitmapData =
            [NSMutableData dataWithLength:sizeof(Pixel)*width*height];
        for (NSUInteger y = 0; y < height; y++)
        {
            for (NSUInteger x = 0; x < width; x++)
            {
                UIColor *color = [UIColor colorWithHue:(float)x / (float)width
                                            saturation:1.0f-(float)y / (float)height
                                            brightness:brightness / 100
                                                 alpha:1.0f];
                CGFloat red, green, blue, alpha;
                [color getRed:&red green:&green blue:&blue alpha:&alpha];
                Pixel *pixel = ((Pixel *)bitmapData.bytes) + x + y * width;
                pixel->red   = red * 255;
                pixel->green = green * 255;
                pixel->blue  = blue * 255;
                pixel->alpha = 255;
            }
        }
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)bitmapData);
        hsImageRef = CGImageCreate(width, height, 8, 32, width * 4,
                                   colorSpace, kCGBitmapByteOrderDefault,
                                   provider, NULL, false,
                                   kCGRenderingIntentDefault);
        CGColorSpaceRelease(colorSpace);
        CGDataProviderRelease(provider);
    }
    CGContextDrawImage(context, bounds, hsImageRef);
    CGRect circleRect = CGRectMake(bounds.origin.x + bounds.size.width * _colorModel.hue / 360 - kCircleRadius / 2,
                                   bounds.origin.y + bounds.size.height * _colorModel.saturation / 100 - kCircleRadius / 2,
                                   kCircleRadius,
                                   kCircleRadius);
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:circleRect];
    [_colorModel.color setFill];
    [circle fill];
    circle.lineWidth = 3;
    [[UIColor blackColor] setStroke];
    [circle stroke];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self changeHSToPoint:[(UITouch*)[touches anyObject] locationInView:self]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self changeHSToPoint:[(UITouch*)[touches anyObject] locationInView:self]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self changeHSToPoint:[(UITouch*)[touches anyObject] locationInView:self]];
}

- (void)changeHSToPoint:(CGPoint)point
{
    CGRect bounds = self.bounds;
    if (CGRectContainsPoint(bounds,point))
    {
        _colorModel.hue = (point.x-bounds.origin.x)/bounds.size.width*360;
        _colorModel.saturation = (point.y-bounds.origin.y)/bounds.size.height*100;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
