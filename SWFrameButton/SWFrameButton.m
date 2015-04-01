// SWFrameButton.m
//
// Copyright (c) 2014 Sarun Wongpatcharapakorn
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SWFrameButton.h"
#import <QuartzCore/QuartzCore.h>

static CGFloat const SWDefaultFontSize        = 15.0;
static CGFloat const SWCornerRadius           = 4.0;
static CGFloat const SWBorderWidth            = 1.0;
static CGFloat const SWAnimationDuration      = 0.25;
static UIEdgeInsets const SWContentEdgeInsets = {5, 10, 5, 10};

@implementation SWFrameButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self commonSetup];
        
        // Set default font when init in code
        [self.titleLabel setFont:[UIFont systemFontOfSize:SWDefaultFontSize]];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
        [self commonSetup];
    }
    return self;
}

- (void)commonSetup
{
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.tintColor.CGColor;
    [self setContentEdgeInsets:SWContentEdgeInsets];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected|UIControlStateHighlighted];
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
}

- (void)commonInit
{
    _cornerRadius = SWCornerRadius;
    _borderWidth = SWBorderWidth;
}


- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:SWAnimationDuration animations:^{
        if (highlighted) {
            if (self.selected) {
                CGFloat r, g, b;
                [self.tintColor getRed:&r green:&g blue:&b alpha:nil];
                self.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:0.5];
                self.layer.borderColor = [UIColor clearColor].CGColor;
            } else {
                self.backgroundColor = self.tintColor;
            }
        } else {
            self.layer.borderColor = self.tintColor.CGColor;
            if (self.selected) {
                self.backgroundColor = self.tintColor;
            } else {
                self.backgroundColor = [UIColor clearColor];
            }
        }

    }];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    if (selected) {
        self.backgroundColor = self.tintColor;
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)tintColorDidChange
{
    self.layer.borderColor = self.tintColor.CGColor;
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    if (self.selected) {
        self.backgroundColor = self.tintColor;
    }
}

#pragma mark - Properties

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    
    self.layer.borderWidth = borderWidth;
}

@end
