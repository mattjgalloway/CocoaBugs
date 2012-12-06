//
//  BuggyLayout.m
//  CollectionViewMissingCells
//
//  Created by Matt Galloway on 03/12/2012.
//  Copyright (c) 2012 Matt Galloway. All rights reserved.
//

#import "BuggyLayout.h"

@interface BuggyLayout () {
    NSMutableArray *_rects;
}

@end

@implementation BuggyLayout

- (void)prepareLayout {
    _rects = [NSMutableArray new];
    
    [_rects addObject:[NSValue valueWithCGRect:CGRectMake(0.0f, 0.0f, 100.0f, 30.0f)]];
    [_rects addObject:[NSValue valueWithCGRect:CGRectMake(0.0f, 40.0f, 2048.0f, 30.0f)]];
    [_rects addObject:[NSValue valueWithCGRect:CGRectMake(-2048.0f, 80.0f, 4096.0f, 30.0f)]];
    [_rects addObject:[NSValue valueWithCGRect:CGRectMake(0.0f, 120.0f, 512.0f, 30.0f)]];
    [_rects addObject:[NSValue valueWithCGRect:CGRectMake(522.0f, 120.0f, 512.0f, 30.0f)]];
    [_rects addObject:[NSValue valueWithCGRect:CGRectMake(1044.0f, 120.0f, 512.0f, 30.0f)]];
    [_rects addObject:[NSValue valueWithCGRect:CGRectMake(0.0f, 160.0f, 100.0f, 30.0f)]];
}

- (CGSize)collectionViewContentSize {
    __block CGRect bounds = CGRectZero;
    [_rects enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL *stop) {
        CGRect objRect = [obj CGRectValue];
        bounds = CGRectUnion(bounds, objRect);
    }];
    return bounds.size;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [NSMutableArray new];
    
    [_rects enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL *stop) {
        CGRect objRect = [obj CGRectValue];
        if (CGRectIntersectsRect(rect, objRect)) {
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:idx inSection:0]];
            attribute.frame = objRect;
            [attributes addObject:attribute];
        }
    }];
    
    return attributes;
}

@end
