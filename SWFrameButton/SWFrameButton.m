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

#define kDefaultFontSize 15.0

@implementation SWFrameButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self setupDefaultConfiguration];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 1;
    self.layer.borderColor = self.tintColor.CGColor;
    [self setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected|UIControlStateHighlighted];
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
}

- (void)setupDefaultConfiguration
{
    [self.titleLabel setFont:[UIFont systemFontOfSize:kDefaultFontSize]];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:0.25 animations:^{
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


@end
