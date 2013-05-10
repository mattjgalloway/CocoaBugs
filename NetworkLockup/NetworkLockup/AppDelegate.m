//
//  AppDelegate.m
//  NetworkLockup
//
//  Created by Matt Galloway on 10/05/2013.
//  Copyright (c) 2013 zeebox. All rights reserved.
//

#import "AppDelegate.h"

@interface Request : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@end

@implementation Request {
    void (^_completion)(NSError *error);
    NSURLConnection *_connection;
}

- (void)startWithURL:(NSURL*)url completion:(void (^)(NSError *error))completion {
    _completion = completion;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:20.0];
        _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        [_connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [_connection start];
    });
}

- (void)_requestFinishedWithError:(NSError*)error {
    _completion(error);
}


#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self _requestFinishedWithError:error];
}


#pragma mark - NSURLConnectionDataDelegate

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self _requestFinishedWithError:nil];
}

@end

@implementation AppDelegate {
    UILabel *_label;
    dispatch_queue_t _queue;
    dispatch_semaphore_t _semaphore;
    NSMutableSet *_requests;
    NSUInteger _queueSize;
}

- (void)fireOffRequests {
    for (int i = 0; i < 1000; i++) {
        [self queueRequest:i];
    }
}

- (void)queueRequest:(int)i {
    _queueSize++;
    [self tellCurrentStatus];
    
    dispatch_async(_queue, ^{
        dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
        
        Request *request = [[Request alloc] init];
        
        [_requests addObject:request];
        [self tellCurrentStatus];
        
        NSURL *url = [NSURL URLWithString:@"http://www.galloway.me.uk/media/other/empty_file.txt"];
        
        [request startWithURL:url completion:^(NSError *error) {
            if (error.domain == NSURLErrorDomain && error.code == NSURLErrorTimedOut) {
                _label.textColor = [UIColor redColor];
                NSLog(@"*** TIMEOUT ***");
            }
            
            _queueSize--;
            [_requests removeObject:request];
            
            [self tellCurrentStatus];
            
            dispatch_semaphore_signal(_semaphore);
        }];
    });
}

- (void)tellCurrentStatus {
    NSString *status = [NSString stringWithFormat:@"Queue size = %i. Inflight = %i.", _queueSize, _requests.count];
    NSLog(@"%@", status);
    dispatch_async(dispatch_get_main_queue(), ^{
        _label.text = status;
    });
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _queue = dispatch_queue_create("com.zeebox.networkqueue", 0);
    dispatch_set_target_queue(_queue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0));
    _semaphore = dispatch_semaphore_create(20);
    _requests = [NSMutableSet new];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIViewController *viewController = [[UIViewController alloc] init];
    _label = [[UILabel alloc] initWithFrame:viewController.view.bounds];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _label.text = @"START";
    _label.textAlignment = NSTextAlignmentCenter;
    [viewController.view addSubview:_label];
    self.window.rootViewController = viewController;
    
    [self.window makeKeyAndVisible];
    
    [self fireOffRequests];
    
    return YES;
}

@end
