//
//  SEFilterControl.m
//  SEFilterControl_Test
//
//  Created by Shady A. Elyaski on 6/13/12.
//  Copyright (c) 2012 mash, ltd. All rights reserved.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "SEFilterControl.h"

#define LEFT_OFFSET 25
#define RIGHT_OFFSET 25
#define TITLE_SELECTED_DISTANCE 5
#define TITLE_FADE_ALPHA .5f
#define TITLE_FONT [UIFont fontWithName:@"Optima" size:14]
#define TITLE_SHADOW_COLOR [UIColor lightGrayColor]
#define TITLE_COLOR [UIColor blackColor]

@interface SEFilterControl () {
}

@end

@implementation SEFilterControl {
  SEFilterKnob *handler;
  CGPoint diffPoint;
  NSArray *titlesArr;
  float oneSlotSize;
}

@synthesize SelectedIndex;
@synthesize progressColor;

#pragma mark -
#pragma mark Init

- (id)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles {
  if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 70)]) {
    [self setBackgroundColor:[UIColor clearColor]];
    titlesArr = [[NSArray alloc] initWithArray:titles];
    
    [self setProgressColor:[UIColor colorWithRed:103 / 255.f green:173 / 255.f blue:202 / 255.f alpha:1]];
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ItemSelected:)];
    [self addGestureRecognizer:gest];
    
    handler = [SEFilterKnob buttonWithType:UIButtonTypeCustom];
    [handler setFrame:CGRectMake(LEFT_OFFSET, 10, 36, 38)];
    [handler setAdjustsImageWhenHighlighted:NO];
    [handler setCenter:CGPointMake(handler.center.x - (handler.frame.size.width / 2.f), 19)];
    [handler addTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
    [handler addTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [handler addTarget:self action:@selector(TouchMove:withEvent:) forControlEvents: UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
    [self addSubview:handler];
    
    int i;
    NSString *title;
    UILabel *lbl;
    
    oneSlotSize = 1.f * (self.frame.size.width - LEFT_OFFSET - RIGHT_OFFSET - 1) / (titlesArr.count - 1);
    for (i = 0; i < titlesArr.count; i++) {
      title = [titlesArr objectAtIndex:i];
      lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, oneSlotSize, 25)];
      [lbl setText:title];
      [lbl setFont:TITLE_FONT];
      [lbl setTextColor:TITLE_COLOR];
      [lbl setLineBreakMode:UILineBreakModeMiddleTruncation];
      [lbl setAdjustsFontSizeToFitWidth:YES];
      [lbl setMinimumFontSize:8];
      [lbl setTextAlignment:UITextAlignmentCenter];
      [lbl setBackgroundColor:[UIColor clearColor]];
      [lbl setTag:i + 50];
      
      if (i) {
        [lbl setAlpha:TITLE_FADE_ALPHA];
      }
      
//      [lbl setCenter:[self getCenterPointForIndex:i]];
      [lbl setCenter:CGPointMake([self getCenterPointForIndex:i].x, 49)];
      
      
      [self addSubview:lbl];
    }
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andLabels:(NSArray *)labels {
  if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 70)]) {
    [self setBackgroundColor:[UIColor clearColor]];
    titlesArr = [[NSArray alloc] initWithArray:titles];
    
    [self setProgressColor:[UIColor colorWithRed:103/255.f green:173/255.f blue:202/255.f alpha:1]];
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ItemSelected:)];
    [self addGestureRecognizer:gest];
    
    handler = [SEFilterKnob buttonWithType:UIButtonTypeCustom];
    [handler setFrame:CGRectMake(LEFT_OFFSET, 10, 35, 55)];
    [handler setAdjustsImageWhenHighlighted:NO];
    [handler setCenter:CGPointMake(handler.center.x-(handler.frame.size.width/2.f), self.frame.size.height-19.5f)];
    [handler addTarget:self action:@selector(TouchDown:withEvent:) forControlEvents:UIControlEventTouchDown];
    [handler addTarget:self action:@selector(TouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [handler addTarget:self action:@selector(TouchMove:withEvent:) forControlEvents: UIControlEventTouchDragOutside | UIControlEventTouchDragInside];
    [self addSubview:handler];
    
    int i;
    NSString *title;
    UILabel *lbl;
    
    oneSlotSize = 1.f*(self.frame.size.width-LEFT_OFFSET-RIGHT_OFFSET-1)/(titlesArr.count-1);
    for (i = 0; i < titlesArr.count; i++) {
      title = [titlesArr objectAtIndex:i];
      lbl = [labels objectAtIndex:i];
      [lbl setFrame:CGRectMake(0, 0, oneSlotSize, 25)];//[[UILabel alloc]initWithFrame:CGRectMake(0, 0, oneSlotSize, 25)];
                                                       //            [lbl setText:title];
      [lbl setLineBreakMode:UILineBreakModeMiddleTruncation];
      [lbl setAdjustsFontSizeToFitWidth:YES];
      [lbl setMinimumFontSize:8];
      [lbl setTextAlignment:UITextAlignmentCenter];
      [lbl setShadowOffset:CGSizeMake(0, 0.5)];
      [lbl setBackgroundColor:[UIColor clearColor]];
      [lbl setTag:i+50];
      
      if (i) {
        [lbl setAlpha:TITLE_FADE_ALPHA];
      }
      
      [lbl setCenter:[self getCenterPointForIndex:i]];
      
      [self addSubview:lbl];
      //            [lbl release];
    }
  }
  return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)setSelectedIndex:(int)index {
  SelectedIndex = index;
  [self animateTitlesToIndex:index];
  [self animateHandlerToIndex:index];
  [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setTitlesColor:(UIColor *)color {
  int i;
  UILabel *lbl;
  for (i = 0; i < titlesArr.count; i++) {
    lbl = (UILabel *)[self viewWithTag:i+50];
    [lbl setTextColor:color];
  }
}

- (void)setTitlesFont:(UIFont *)font {
  int i;
  UILabel *lbl;
  for (i = 0; i < titlesArr.count; i++) {
    lbl = (UILabel *)[self viewWithTag:i+50];
    [lbl setFont:font];
  }
}

- (void)setHandlerColor:(UIColor *)color {
  [handler setHandlerColor:color];
}

#pragma mark -
#pragma mark Touch/Gesture Events

- (void)ItemSelected:(UITapGestureRecognizer *)tap {
  SelectedIndex = [self getSelectedTitleInPoint:[tap locationInView:self]];
  [self setSelectedIndex:SelectedIndex];
  
  [self sendActionsForControlEvents:UIControlEventTouchUpInside];
  [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)TouchDown:(UIButton *)btn withEvent:(UIEvent *)ev {
  CGPoint currPoint = [[[ev allTouches] anyObject] locationInView:self];
  diffPoint = CGPointMake(currPoint.x - btn.frame.origin.x, currPoint.y - btn.frame.origin.y);
  [self sendActionsForControlEvents:UIControlEventTouchDown];
}

- (void)TouchUp:(UIButton*)btn {
  
  SelectedIndex = [self getSelectedTitleInPoint:btn.center];
  [self animateHandlerToIndex:SelectedIndex];
  [self sendActionsForControlEvents:UIControlEventTouchUpInside];
  [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)TouchMove:(UIButton *)btn withEvent:(UIEvent *)ev {
  CGPoint currPoint = [[[ev allTouches] anyObject] locationInView:self];
  
  CGPoint toPoint = CGPointMake(currPoint.x-diffPoint.x, handler.frame.origin.y);
  
  toPoint = [self fixFinalPoint:toPoint];
  
  [handler setFrame:CGRectMake(toPoint.x, toPoint.y, handler.frame.size.width, handler.frame.size.height)];
  
  int selected = [self getSelectedTitleInPoint:btn.center];
  
  [self animateTitlesToIndex:selected];
  
  [self sendActionsForControlEvents:UIControlEventTouchDragInside];
}

#pragma mark -
#pragma mark Private Methods

- (CGPoint)getCenterPointForIndex:(int)i {
  return CGPointMake((i / (float)(titlesArr.count - 1)) * (self.frame.size.width - RIGHT_OFFSET - LEFT_OFFSET) + LEFT_OFFSET,
                     i == 0 ? self.frame.size.height - 55 - TITLE_SELECTED_DISTANCE:self.frame.size.height - 55);
}

- (CGPoint)fixFinalPoint:(CGPoint)pnt {
  if (pnt.x < LEFT_OFFSET - (handler.frame.size.width / 2.f)) {
    pnt.x = LEFT_OFFSET - (handler.frame.size.width / 2.f);
  } else if (pnt.x + (handler.frame.size.width / 2.f) > self.frame.size.width - RIGHT_OFFSET) {
    pnt.x = self.frame.size.width - RIGHT_OFFSET - (handler.frame.size.width / 2.f);
  }
  return pnt;
}

- (void)drawRect:(CGRect)rect {
  //
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  UIColor *__autoreleasing trackColor = [UIColor colorWithRed:73/255.f green:198/255.f blue:215/255.f alpha:1];
  CGColorRef trackColorRef = trackColor.CGColor;
  
  // Fill Main Path
  CGContextSetFillColorWithColor(context, trackColorRef);
  CGContextFillRect(context, CGRectMake(LEFT_OFFSET, 15, rect.size.width - RIGHT_OFFSET - LEFT_OFFSET, 10));
  CGContextSaveGState(context);

  //
  CGPoint centerPoint;
  for (int i = 0; i < titlesArr.count; i++) {
    //
    centerPoint = [self getCenterPointForIndex:i];
    
    // Draw Selection Circles Shadow
    CGContextSetFillColorWithColor(context, trackColorRef);
    CGContextFillEllipseInRect(context, CGRectMake(centerPoint.x - 12.5f, 9, 20, 20));
    
    // Draw white circles
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(centerPoint.x - 7.5f, 14, 10, 10));
  }
}

- (void)animateTitlesToIndex:(int)index {
  int i;
  UILabel *lbl;
  for (i = 0; i < titlesArr.count; i++) {
    lbl = (UILabel *)[self viewWithTag:i + 50];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if (i == index) {
      [lbl setCenter:CGPointMake(lbl.center.x, 49 + TITLE_SELECTED_DISTANCE)];
      [lbl setAlpha:1];
    } else {
      [lbl setCenter:CGPointMake(lbl.center.x, 49)];
      [lbl setAlpha:TITLE_FADE_ALPHA];
    }
    [UIView commitAnimations];
  }
}

- (void)animateHandlerToIndex:(int)index {
  CGPoint toPoint = [self getCenterPointForIndex:index];
  toPoint = CGPointMake(toPoint.x - (handler.frame.size.width / 2.f), handler.frame.origin.y);
  toPoint = [self fixFinalPoint:toPoint];
  
  [UIView beginAnimations:nil context:nil];
  [handler setFrame:CGRectMake(toPoint.x, toPoint.y, handler.frame.size.width, handler.frame.size.height)];
  [UIView commitAnimations];
}

- (int)getSelectedTitleInPoint:(CGPoint)pnt {
  return round((pnt.x - LEFT_OFFSET) / oneSlotSize);
}

@end