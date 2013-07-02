//
//  ViewController.m
//  NavigationControllerPushPop
//
//  Created by Matt Galloway on 02/07/2013.
//  Copyright (c) 2013 zeebox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self initWithTitle:nil];
}

- (id)initWithTitle:(NSString*)title {
    if ((self = [super initWithNibName:nil bundle:nil])) {
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHue:((CGFloat)arc4random_uniform(360)/360.0f) saturation:1.0f brightness:1.0f alpha:1.0f];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"PopPush" style:UIBarButtonItemStyleBordered target:self action:@selector(popPush)], [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStyleBordered target:self action:@selector(push)]];
}

- (void)popPush {
    UINavigationController *navController = self.navigationController;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    double delayInSeconds = 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        ViewController *viewController = [self newViewController];
        [navController pushViewController:viewController animated:YES];
    });
}

- (void)push {
    ViewController *viewController = [self newViewController];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (ViewController*)newViewController {
    NSArray *titles = @[@"Cat", @"Dog", @"Mouse", @"Badger", @"Tiger", @"Giraffe", @"Elephant", @"Tortoise", @"Guinnea Pig"];
    ViewController *viewController = [[ViewController alloc] initWithTitle:titles[arc4random_uniform(titles.count)]];
    return viewController;
}

@end
