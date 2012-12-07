//
//  SEFilterKnob.m
//  SEFilterControl_Test
//
//  Created by Shady A. Elyaski on 6/15/12.
//  Copyright (c) 2012 mash, ltd. All rights reserved.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "SEFilterKnob.h"

@implementation SEFilterKnob

@synthesize handlerColor = _handlerColor;

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    [self setHandlerColor:[UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1]];
  }
  return self;
}

- (void)setHandlerColor:(UIColor *)hc {
  _handlerColor = hc;
  [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  //
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  //
  UIColor *__autoreleasing handlerColor = [UIColor colorWithRed:73/255.f green:198/255.f blue:215/255.f alpha:1];
  UIColor *__autoreleasing outerShadowColor = [UIColor colorWithRed:13/255.f green:166/255.f blue:187/255.f alpha:1];
  UIColor *__autoreleasing innerShadowColor = [UIColor colorWithRed:198/255.f green:231/255.f blue:235/255.f alpha:1];
  CGColorRef handlerColorRef = handlerColor.CGColor;
  CGColorRef outerShadowColorRef = outerShadowColor.CGColor;
  CGColorRef innerShadowColorRef = innerShadowColor.CGColor;
  
  // Draw Main Cirlce
  CGContextSaveGState(context);
  CGContextSetStrokeColorWithColor(context, outerShadowColorRef);
  CGContextSetLineWidth(context, 7);
  CGContextStrokeEllipseInRect(context, CGRectMake(3.5f, 5.5f, 29, 29));
  CGContextRestoreGState(context);
  //
  CGContextSaveGState(context);
  CGContextSetStrokeColorWithColor(context, innerShadowColorRef);
  CGContextSetLineWidth(context, 6);
  CGContextStrokeEllipseInRect(context, CGRectMake(10, 10, 16, 16));
  CGContextRestoreGState(context);
  //
  CGContextSaveGState(context);
  CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1].CGColor);
  CGContextSetLineWidth(context, 6);
  CGContextStrokeEllipseInRect(context, CGRectMake(10, 12, 16, 16));
  CGContextRestoreGState(context);
  //
  CGContextSaveGState(context);
  CGContextSetStrokeColorWithColor(context, handlerColorRef);
  CGContextSetLineWidth(context, 7);
  CGContextStrokeEllipseInRect(context, CGRectMake(3.5f, 3.5f, 29, 29));
  CGContextRestoreGState(context);
  //
  CGContextSaveGState(context);
  CGContextSetStrokeColorWithColor(context, innerShadowColorRef);
  CGContextSetLineWidth(context, 5);
  CGContextStrokeEllipseInRect(context, CGRectMake(15.5f, 17.5f, 5, 5));
  CGContextRestoreGState(context);
  //
  CGContextSaveGState(context);
  CGContextSetStrokeColorWithColor(context, handlerColorRef);
  CGContextSetLineWidth(context, 5);
  CGContextStrokeEllipseInRect(context, CGRectMake(15.5f, 15.5f, 5, 5));
  CGContextRestoreGState(context);
}

@end
