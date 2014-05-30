// SWViewController.m
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

#import "SWViewController.h"
#import "SWFrameButton.h"

@interface SWViewController ()

@end

@implementation SWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    SWFrameButton *button = [[SWFrameButton alloc] init];
    [button setTitle:@"Selected Button" forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = self.view.center;
    [button setSelected:YES];
    [self.view addSubview:button];
    
    SWFrameButton *selectableButton = [[SWFrameButton alloc] init];
    [selectableButton setTitle:@"Selectable Button" forState:UIControlStateNormal];
    [selectableButton addTarget:self action:@selector(toggleSelection:) forControlEvents:UIControlEventTouchUpInside];
    [selectableButton sizeToFit];
    selectableButton.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
    [self.view addSubview:selectableButton];
    
    SWFrameButton *tintButton = [[SWFrameButton alloc] init];
    [tintButton setTitle:@"Green Tint Button" forState:UIControlStateNormal];
    [tintButton sizeToFit];
    tintButton.tintColor = [UIColor greenColor];
    tintButton.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    [self.view addSubview:tintButton];
    
    SWFrameButton *dimButton = [[SWFrameButton alloc] init];
    [dimButton setTitle:@"Dim Button" forState:UIControlStateNormal];
    [dimButton addTarget:self action:@selector(toggleDim:) forControlEvents:UIControlEventTouchUpInside];
    [dimButton sizeToFit];
    dimButton.center = CGPointMake(self.view.center.x, self.view.center.y + 150);
    [self.view addSubview:dimButton];
    
    UIButton *systemButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [systemButton setTitle:@"System Button" forState:UIControlStateNormal];
    [systemButton sizeToFit];
    systemButton.center = CGPointMake(self.view.center.x, self.view.center.y + 200);
    [self.view addSubview:systemButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (void)toggleSelection:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
}

- (void)toggleDim:(id)sender
{
    if (self.view.tintAdjustmentMode != UIViewTintAdjustmentModeDimmed) {
        self.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    } else {
        self.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    }

}

@end
