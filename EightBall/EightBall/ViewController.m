//
//  ViewController.m
//  EightBall
//
//  Created by X on 13/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "ViewController.h"

static NSString* gAnswers[] = {
    @"\rYES",
    @"\rNO",
    @"\rMAYBE",
    @"I\rDON'T\rKNOW",
    @"TRY\rAGAIN\rSOON",
    @"READ\rTHE\rMANUAL"
};

#define kNumberOfAnswers (sizeof(gAnswers)/sizeof(NSString*))


@interface ViewController ()

- (void)fadeFortune;
- (void)newFortune;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)fadeFortune
{
    [UIView animateWithDuration:0.75 animations:^{
        self.answerView.alpha = 0.0;
    }];
}

- (void)newFortune
{
    self.answerView.text = gAnswers[arc4random_uniform(kNumberOfAnswers)];
    [UIView animateWithDuration:2.0 animations:^{
        self.answerView.alpha = 1.0;
    }];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion==UIEventSubtypeMotionShake)
        [self fadeFortune];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion==UIEventSubtypeMotionShake)
        [self newFortune];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion==UIEventSubtypeMotionShake)
        [self newFortune];
}

@end
