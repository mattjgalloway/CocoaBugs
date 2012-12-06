//
//  BuggyLayout.h
//  CollectionViewMissingCells
//
//  Created by Matt Galloway on 03/12/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuggyLayout : UICollectionViewLayout

@property (nonatomic, assign) BOOL scrolling;

- (NSUInteger)numberOfItems;

@end
