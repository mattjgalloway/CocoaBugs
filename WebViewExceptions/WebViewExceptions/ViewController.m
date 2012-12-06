//
//  ViewController.m
//  WebViewExceptions
//
//  Created by Matt Galloway on 06/12/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com"]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *leaked = [NSString stringWithFormat:@"%p", webView];
    @throw [NSException exceptionWithName:@"SOMETHING" reason:@"SOMETHING" userInfo:nil];
    NSLog(@"%@", leaked);
}

@end
