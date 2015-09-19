//
//  Paginator.m
//  Wonderland
//
//  Created by X on 18/09/15.
//  Copyright (c) 2015 Alex Izotov. All rights reserved.
//

#import "Paginator.h"

@interface Paginator ()
{
    NSMutableArray  *ranges;
    NSUInteger      lastPageWithContent;
    NSDictionary    *fontAttrs;
}

- (NSRange)rangeOfTextForPage:(NSUInteger)page;

@end

@implementation Paginator

- (void)resetPageData
{
    ranges = [NSMutableArray array];
    lastPageWithContent = 1;
}

#pragma mark Properties

- (void)setBookText:(NSString *)bookData
{
    _bookText = bookData;
    [self resetPageData];
}


- (void)setFont:(UIFont *)font
{
    if ([_font isEqual: font])
        return;
    _font = font;
    fontAttrs = nil;
    [self resetPageData];
}

- (NSDictionary*)fontAttrs
{
    if (fontAttrs==nil)
    {
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        fontAttrs = @{
                      NSFontAttributeName: self.font,
                      NSParagraphStyleAttributeName: style
                      };
    }
    return fontAttrs;
}

- (void)setViewSize:(CGSize)viewSize
{
    if (CGSizeEqualToSize(_viewSize,viewSize))
        return;
    _viewSize = viewSize;
    [self resetPageData];
}

- (NSUInteger)lastKnownPage
{
    return lastPageWithContent;
}

#pragma mark Pagination

#define SpanRange(LOCATION,LENGTH) \
        ({ NSUInteger loc_=(LOCATION); NSMakeRange(loc_,(LENGTH)-loc_); })

- (NSRange)rangeOfTextForPage:(NSUInteger)page
{
    if (ranges.count>=page)
        return [ranges[page-1] rangeValue];
    CGSize constraintSize = _viewSize;
    CGFloat targetHeight = constraintSize.height;
    constraintSize.height = 32000;
    NSRange textRange = NSMakeRange(0,0);
    if (page!=1)
        textRange.location = NSMaxRange([self rangeOfTextForPage:page-1]);
    NSCharacterSet *wordBreakCharSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];

    while (textRange.location<_bookText.length &&
           [wordBreakCharSet characterIsMember:[_bookText characterAtIndex:textRange.location]])
    {
        textRange.location += 1;
    }
    CGSize textSize = CGSizeMake(0,0);
    CGRect textBounds;
    NSCharacterSet *paraCharSet = [NSCharacterSet characterSetWithCharactersInString:@"\r"];
    while (textSize.height<targetHeight)
    {
        NSRange paraRange = [_bookText rangeOfCharacterFromSet:paraCharSet
                                                       options:NSLiteralSearch
                                                         range:SpanRange(NSMaxRange(textRange),_bookText.length)];
        if (paraRange.location==NSNotFound)
            break;
        textRange.length = NSMaxRange(paraRange)-textRange.location;
        NSString *testText = [_bookText substringWithRange:textRange];
        textBounds = [testText boundingRectWithSize:constraintSize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:self.fontAttrs
                                            context:[NSStringDrawingContext new]];
        textSize = textBounds.size;
    }
    while (textSize.height>targetHeight)
    {
        NSRange wordRange = [_bookText rangeOfCharacterFromSet:wordBreakCharSet
                                                       options:NSBackwardsSearch
                                                         range:textRange];
        if (wordRange.location==NSNotFound)
            break;
        textRange.length = wordRange.location-textRange.location;
        NSString *testText = [_bookText substringWithRange:textRange];
        textBounds = [testText boundingRectWithSize:constraintSize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:self.fontAttrs
                                            context:[NSStringDrawingContext new]];
        textSize = textBounds.size;
    }
    if (textRange.length!=0)
        lastPageWithContent = page;
    [ranges addObject:[NSValue valueWithRange:textRange]];
    return textRange;
}

#pragma mark Data Model Interface

- (BOOL)availablePage:(NSUInteger)page
{
    if (page==1)
        return YES;
    NSRange textRange = [self rangeOfTextForPage:page];
    return (textRange.length!=0);
}

- (NSString*)textForPage:(NSUInteger)page
{
    return [_bookText substringWithRange:[self rangeOfTextForPage:page]];
}

@end