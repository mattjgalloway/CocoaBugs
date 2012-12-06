//
//  TableViewController.m
//  CellAnimationBug
//
//  Created by Matt Galloway on 08/11/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "TableViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface TableViewController () <UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, assign) BOOL searching;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    _searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _searching ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = @"Title";
    cell.detailTextLabel.text = @"Subtitle";
    cell.imageView.image = [UIImage imageNamed:@"avatar.png"];
    
    return cell;
}

/**
 * Tried this as per @mtabini's suggestions, to no avail.
 *
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [cell layoutSubviews];
    [CATransaction commit];
}
 */

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _searching = YES;
    [self.tableView reloadData];
}

@end
