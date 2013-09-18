//
//  ViewController.m
//  KeyboardAnimationCurveBug
//
//  Created by Matt Galloway on 18/09/2013.
//  Copyright (c) 2013 Swipe Stack. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)keyboardDidChangeFrame:(NSNotification*)note {
    UIViewAnimationCurve curve = (UIViewAnimationCurve)[note.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    NSLog(@"curve = %i", curve);
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
