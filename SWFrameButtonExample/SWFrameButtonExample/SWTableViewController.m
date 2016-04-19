//
//  SWTableViewController.m
//  SWFrameButtonExample
//
//  Created by Sarun Wongpatcharapakorn on 4/19/16.
//  Copyright © 2016 Sarun Wongpatcharapakorn. All rights reserved.
//

#import "SWTableViewController.h"
#import "SWTableViewCell.h"

@interface SWTableViewController ()

@property (nonatomic, strong) NSMutableArray *selected;

@end

@implementation SWTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selected = [NSMutableArray array];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if ([self.selected containsObject:indexPath]) {
        cell.button.selected = YES;
    } else {
        cell.button.selected = NO;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.selected containsObject:indexPath]) {
        cell.button.selected = NO;
        [self.selected removeObject:indexPath];
    } else {
        cell.button.selected = YES;
        [self.selected addObject:indexPath];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
