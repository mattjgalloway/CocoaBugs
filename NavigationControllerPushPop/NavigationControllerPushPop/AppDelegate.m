//
//  AppDelegate.m
//  NavigationControllerPushPop
//
//  Created by Matt Galloway on 02/07/2013.
//  Copyright (c) 2013 zeebox. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController *viewController = [[ViewController alloc] initWithTitle:@"Start"];
    self.navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    self.window.rootViewController = _navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
