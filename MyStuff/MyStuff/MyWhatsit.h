//
//  MyWhatsit.h
//  MyStuff
//
//  Created by X on 14/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWhatsitDidChangeNotification @"MyWhatsitDidChange"

@interface MyWhatsit : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *location;

- (id)initWithName:(NSString*)name location:(NSString*)location;
- (void)postDidChangeNotification;

@end
