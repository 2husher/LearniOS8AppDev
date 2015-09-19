//
//  MyWhatsit.m
//  MyStuff
//
//  Created by X on 14/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "MyWhatsit.h"

@implementation MyWhatsit

- (id)initWithName:(NSString*)name location:(NSString*)location
{
    self = [super init];
    if (self)
    {
        self.name = name;
        self.location = location;
    }
    return self;
}

- (void)postDidChangeNotification
{
    [[NSNotificationCenter defaultCenter]
        postNotificationName:kWhatsitDidChangeNotification
        object:self];
}

@end
