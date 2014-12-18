//
//  ViewController.m
//  TableViewEstimatedRowHeightBug
//
//  Created by Matt Galloway on 18/12/2014.
//  Copyright (c) 2014 Matt Galloway. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 500;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 40.0f + (indexPath.row % 10) * 5.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  cell.textLabel.text = [NSString stringWithFormat:@"%zd:%zd", indexPath.section, indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  UIViewController *viewController = [UIViewController new];
  viewController.view.backgroundColor = [UIColor whiteColor];

  [self presentViewController:viewController animated:YES completion:^{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self dismissViewControllerAnimated:YES completion:nil];
    });
  }];

//  [self.navigationController pushViewController:viewController animated:YES];
}

@end
