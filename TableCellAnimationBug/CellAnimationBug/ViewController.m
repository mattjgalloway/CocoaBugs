//
//  ViewController.m
//  CellAnimationBug
//
//  Created by Matt Galloway on 08/11/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController () <UIPopoverControllerDelegate>
@property (nonatomic, weak) IBOutlet UIBarButtonItem *showTableButton;
@property (nonatomic, strong) UIPopoverController *popover;
@end

@implementation ViewController

- (IBAction)showTable:(id)sender {
    TableViewController *tableViewController = [[TableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.popover = [[UIPopoverController alloc] initWithContentViewController:tableViewController];
    self.popover.delegate = self;
    [self.popover presentPopoverFromBarButtonItem:self.showTableButton permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.popover = nil;
}

-(void) keyboardWillHide:(NSNotification *)note
{
    [self.popover setPopoverContentSize:CGSizeMake(self.popover.popoverContentSize.width, self.popover.popoverContentSize.height) animated:NO];
    
}

@end
