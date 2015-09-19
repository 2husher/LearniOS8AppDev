//
//  OnePageView.m
//  Wonderland
//
//  Created by X on 18/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "OnePageView.h"

@implementation OnePageView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [_text drawInRect:self.bounds withAttributes:_fontAttrs];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
