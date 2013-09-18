//
//  AppDelegate.m
//  KeyboardAnimationCurveBug
//
//  Created by Matt Galloway on 18/09/2013.
//  Copyright (c) 2013 Swipe Stack. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate {
    ViewController *_viewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    _viewController = [ViewController new];
    self.window.rootViewController = _viewController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
