//
//  Paginator.h
//  Wonderland
//
//  Created by X on 18/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Paginator : NSObject

@property (strong,nonatomic) NSString *bookText;
@property (strong, nonatomic) UIFont *font;
@property (readonly,nonatomic) NSDictionary *fontAttrs;
@property (nonatomic) CGSize viewSize;
@property (readonly,nonatomic) NSUInteger lastKnownPage;

- (BOOL)availablePage:(NSUInteger)page;
- (NSString*)textForPage:(NSUInteger)page;

@end
