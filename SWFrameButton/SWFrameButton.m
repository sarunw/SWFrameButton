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
static CGFloat const SWAppleTouchableGuidelineDimension = 44;
static UIEdgeInsets const SWContentEdgeInsets = {5, 10, 5, 10};

@interface SWFrameButton ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

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
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.backgroundImageView.alpha = 0;
    self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self insertSubview:self.backgroundImageView atIndex:0];
}

- (void)commonInit
{
    _cornerRadius = SWCornerRadius;
    _borderWidth = SWBorderWidth;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGSize buttonSize = self.bounds.size;
    CGFloat widthToAdd = MAX(SWAppleTouchableGuidelineDimension - buttonSize.width, 0);
    CGFloat heightToAdd = MAX(SWAppleTouchableGuidelineDimension - buttonSize.height, 0);
    CGRect newFrame = CGRectInset(self.bounds, -widthToAdd, -heightToAdd);
    
    return CGRectContainsPoint(newFrame, point);
}

#pragma mark - Custom Accessors

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [UIView animateWithDuration:SWAnimationDuration animations:^{
        if (highlighted) {
            if (self.selected) {
                self.backgroundImageView.alpha = 0.5;
                self.titleLabel.alpha = 0;
                self.imageView.alpha = 0;
                self.layer.borderColor = [UIColor clearColor].CGColor;
            } else {
                self.backgroundImageView.alpha = 1;
                self.titleLabel.alpha = 0;
                self.imageView.alpha = 0;
            }
        } else {
            self.layer.borderColor = self.tintColor.CGColor;
            if (self.selected) {
                self.backgroundImageView.alpha = 1;
                self.titleLabel.alpha = 0;
                self.imageView.alpha = 0;
            } else {
                self.backgroundImageView.alpha = 0;
                self.titleLabel.alpha = 1;
                self.imageView.alpha = 1;
            }
        }

    }];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    if (selected) {
        self.backgroundImageView.alpha = 1;
        self.titleLabel.alpha = 0;
        self.imageView.alpha = 0;
    } else {
        self.backgroundImageView.alpha = 0;
        self.titleLabel.alpha = 1;
        self.imageView.alpha = 1;
    }
}

- (void)tintColorDidChange
{
    self.layer.borderColor = self.tintColor.CGColor;
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    self.backgroundImageView.image = [self sw_backgroundImage];
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

- (void)setHighlightedTintColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateSelected];
    [self setTitleColor:color forState:UIControlStateSelected|UIControlStateHighlighted];

}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if (enabled) {
        self.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    } else {
        self.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    }
}

#pragma mark - helper

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundImageView.image = [self sw_backgroundImage];
}

- (UIImage *)sw_backgroundImage {
    CGRect rect = self.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSRange range =NSMakeRange(0, self.titleLabel.text.length);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];
    CGContextSetFillColorWithColor(context, self.tintColor.CGColor);
    [path fill];
    NSAttributedString *attributedString =    self.titleLabel.attributedText;

    NSDictionary *dict = [attributedString attributesAtIndex:0 effectiveRange:&range];

    CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
    
    [self.titleLabel.text drawInRect:self.titleLabel.frame withAttributes:dict];
    UIImage *i = self.imageView.image;
    [i drawAtPoint:self.imageView.frame.origin blendMode:kCGBlendModeDestinationOut alpha:1];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
