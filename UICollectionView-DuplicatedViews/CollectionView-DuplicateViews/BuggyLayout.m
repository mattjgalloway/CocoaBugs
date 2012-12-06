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
    NSMutableArray *_supplementaryRects;
}

@end

@implementation BuggyLayout

- (NSUInteger)numberOfItems {
    return _rects.count;
}

- (void)setScrolling:(BOOL)scrolling {
    if (_scrolling != scrolling) {
        _scrolling = scrolling;
        [self invalidateLayout];
    }
}

- (void)prepareLayout {
    _rects = [NSMutableArray new];
    _supplementaryRects = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        for (int j = 0; j < 50; j++) {
            [_rects addObject:[NSValue valueWithCGRect:CGRectMake(j * 110.0f, i * 40.0f, 100.0f, 30.0f)]];
        }
        [_supplementaryRects addObject:[NSValue valueWithCGRect:CGRectMake(0.0f, i * 40.0f, 30.0f, 30.0f)]];
    }
}

- (CGSize)collectionViewContentSize {
    __block CGRect bounds = CGRectZero;
    [_rects enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL *stop) {
        CGRect objRect = [obj CGRectValue];
        bounds = CGRectUnion(bounds, objRect);
    }];
    return bounds.size;
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSValue *obj = [_rects objectAtIndex:indexPath.item];
    CGRect objRect = [obj CGRectValue];
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attribute.frame = objRect;
    
    CATransform3D transform;
    if (_scrolling) {
        transform = CATransform3DIdentity;
    } else {
        transform = CATransform3DMakeRotation(M_PI_4, 0.0f, 0.0f, 1.0f);
    }
    attribute.transform3D = transform;
    
    return attribute;
}

- (UICollectionViewLayoutAttributes*)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSValue *obj = [_supplementaryRects objectAtIndex:indexPath.item];
    CGRect objRect = [obj CGRectValue];
    objRect.origin.x = self.collectionView.contentOffset.x;
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:kind withIndexPath:indexPath];
    attribute.frame = objRect;
    attribute.zIndex = 1;
    return attribute;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [NSMutableArray new];
    
    [_rects enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL *stop) {
        CGRect objRect = [obj CGRectValue];
        if (CGRectIntersectsRect(rect, objRect)) {
            UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0]];
            [attributes addObject:attribute];
        }
    }];
    
    [_supplementaryRects enumerateObjectsUsingBlock:^(NSValue *obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForSupplementaryViewOfKind:@"sup" atIndexPath:[NSIndexPath indexPathForItem:idx inSection:0]];
        [attributes addObject:attribute];
    }];
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
